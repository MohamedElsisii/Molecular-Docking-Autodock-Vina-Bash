# Molecular Docking - AutoDock Vina - Bash

![Untitled-1](https://github.com/user-attachments/assets/8f964552-e811-478c-a91d-40055f69772b)


## Overview

This repository provides a step-by-step guide for performing molecular docking on a Linux system. It includes a Bash script (`Docking.sh`) that automates the docking process using AutoDock Vina. The repository also covers the necessary tools required for molecular docking, along with their installation commands.

## Required Data

Before starting the workflow, ensure you have the following data prepared:

- **Target Molecule**
- **Ligands**
- **Binding site coordinates**

## Required Tools & Installation
Before running the docking script, install the following tools:
![Autodock Vina_page-0001](https://github.com/user-attachments/assets/65870750-a15b-4a9b-bb2e-9cac82c40ae0)

### 1. Update Packages

To ensure all packages are up to date, run:

        sudo apt-get -y update

### 2. PyMol

**Installation:**

        sudo apt-get install -y pymol
**How to run PyMol:**

        pymol
### 3. MGLTools

**Installation:**

        cd ~
        curl -k https://ccsb.scripps.edu/download/532/ --output mgltools.tar.gz
        mkdir -p mgltools
        tar -xvzf mgltools.tar.gz -C mgltools --strip-components=1
        cd mgltools
        bash install.sh
        source ./initMGLtools.sh

**How to run MGLTools:**
        
        adt
### 4. Autodock Vina

**Installation:**

        cd ~ && curl -L https://vina.scripps.edu/wp-content/uploads/sites/55/2020/12/autodock_vina_1_1_2_linux_x86.tgz | tar -xz
### 5. Open Babel

**Installation:**

        sudo apt-get install -y openbabel

**How to run Open Babel:**

        obabel
## Preparing Inputs Before Docking

### 1) Target Molecule Preparation
- Remove Solvents
- Add Hydrogen Atoms
- Add Kollman Charges
- Merge Non-polar hydrogen atoms

**On PyMOL:**

1. Upload the protein structure.
2. Run the following commands in PyMOL:

        remove solvent
        h_add
       
3. Save the protein and ligand in PDBQT format. 

**On MGLTools:**

1. Add Kollman charges: Edit - Charges - Compute Kollman.
2. Merge non-polar hydrogen atoms: Edit - Merge - Non-polar.
3. Save the protein in PDBQT format.

### 2) Ligands Preparation

- Using Open Babel in the terminal, energy minimize all the ligands using the correct algorithm, force field, and number of steps.
Example:

        obminimize -ff UFF -cg -n 500 -sd ligand.pdbqt -O minimized_ligand.pdbqt
### 3) Binding Site Coordinates

1- If the protein is co-crystallized:
- Use MGLTools to set the grid box on the co-crystallized ligand.
- Extract the grid box dimensions into a configuration file (config.txt).

2- If the protein is not co-crystallized:
- Use the P2Rank website (https://prankweb.cz/) to predict the binding site.

* Once the binding site coordinates are determined, create the configuration file (config.txt) with the following content:

        receptor= path_to_target_molecule.pdbqt
        
        x_center= 123 
        y_center= 123
        z_center=123 
        
        x_size=123
        y_size=123
        z_size=123

**Note: Do not forget to remove the ligand from the protein structure before docking if the structure is co-crystallized** 

## Required Files for Docking.sh

Before running the script, ensure you have the following files prepared:

1- Target Molecule in .pdbqt format

2- Ligands in .pdbqt format

3- conf.txt (Configuration file)

## Running the Docking Script

The script requires the following user inputs:

1- The folder path where AutoDock Vina was downloaded.

2- The folder path where the conf.txt file is located.

3- The folder path containing the ligands in .pdbqt format.

Run the script using:

        bash Docking.sh

## Output of the Script
After execution, the following output files will be generated:

- Log file for each ligand containing docking results.
- Output file for each ligand pose from the docking process.
- CSV file containing the docking results for all ligands.

Mohamed Elsisi (c) 2025
