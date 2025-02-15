#!/usr/bin/bash


#####################################
#                                   #
#                                   #
# Copyright (c) 2025 Mohamed Elsisi #
#                                   #
#                                   #
#####################################



# Prompt the user for the folder containing the AutoDock Vina binary (up to the folder path)
echo "Enter the folder path where the AutoDock Vina binary is located (e.g., /path/to/):"
read -r vina_folder

# Define the full path of the Vina path
vina_path="$vina_folder/autodock_vina_1_1_2_linux_x86/bin/vina"

# Prompt the user for the folder containing the config file (up to the folder path, without 'conf.txt')
echo "Enter the folder path where the conf.txt file is located (e.g., /path/to/):"
read -r config_folder

# Define the full path to the config file
config_file="$config_folder/conf.txt"

# Prompt the user for the folder containing pdbqt files
echo "Paste the folder destination containing pdbqt files: (e.g., /path/to/)" 
read -r folder
cd "$folder" || exit

# Create the CSV file to save the results
output_csv="affinity_results.csv"
echo "Filename, Mode, Affinity (kcal/mol), RMSD l.b., RMSD u.b." > "$output_csv"

# Capture the start time
start_time=$(date +%s)

# Process each pdbqt file in the folder
for f in *.pdbqt
do
  echo "Processing: $f"
  # Run AutoDock Vina with the constant vina_path and the user-provided config_file
  "$vina_path" --config "$config_file" --ligand "$f" --out "$(pwd)/${f%.pdbqt}_out.pdbqt" --log "$(pwd)/${f%.pdbqt}_log.log"

  # Extract the affinity table from the .log file
  log_file="${f%.pdbqt}_log.log"
  
  # Loop through the .log file and extract the relevant data
  while read -r line; do
    # Match the affinity table lines (mode, affinity, rmsd)
    if [[ "$line" =~ ^[[:space:]]*[0-9]+[[:space:]]+[+-]?[0-9]+(\.[0-9]+)?[[:space:]]+[0-9]+(\.[0-9]+)?[[:space:]]+[0-9]+(\.[0-9]+)?$ ]]; then
      mode=$(echo "$line" | awk '{print $1}')
      affinity=$(echo "$line" | awk '{print $2}')
      rmsd_lb=$(echo "$line" | awk '{print $3}')
      rmsd_ub=$(echo "$line" | awk '{print $4}')
      
      # Append the data to the CSV file
      echo "$f, $mode, $affinity, $rmsd_lb, $rmsd_ub" >> "$output_csv"
    fi
  done < "$log_file"
done

# Capture the end time
end_time=$(date +%s)

# Calculate the elapsed time in seconds
elapsed_time=$((end_time - start_time))

# Convert elapsed time to hours, minutes, and seconds
hours=$((elapsed_time / 3600))
minutes=$(( (elapsed_time % 3600) / 60 ))
seconds=$((elapsed_time % 60))

# Display the elapsed time
echo "Time taken for docking: ${hours}h ${minutes}m ${seconds}s"
echo "Affinity results saved in $output_csv"
