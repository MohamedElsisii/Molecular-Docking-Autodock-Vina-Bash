# Molecular Docking - AutoDock Vina - Bash

![image_fx_](https://github.com/user-attachments/assets/3a91554a-1677-4d2a-84b5-4bacf4ca72b1)

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
### 5. Open Babel Graphical User Interface (GUI)

**Installation:**

        sudo apt-get install -y openbabel-gui

**How to run Open Babel GUI:**

        obgui
