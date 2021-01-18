# Tissue Specific FBA

If you use this code, please cite the associated Springer Chapter:
"Supreeta Vijayakumar, Giuseppe Magazzù, Pradip Moon, Annalisa Occhipinti and Claudio Angione - A Practical Guide to Integrating Multimodal Machine Learning and Metabolic Modeling".

## Prerequisites

The following dependencies are required in order to complete the flux balance analysis:

### MATLAB 
https://uk.mathworks.com/downloads/
### COBRA Toolbox 
https://opencobra.github.io/cobratoolbox/latest/installation.html

https://github.com/opencobra/cobratoolbox/
### Git 
https://git-scm.com/downloads
### Solvers (QP solvers allowed by MATLAB, only one required):
#### IBM CPLEX
https://www.ibm.com/products/ilog-cplex-optimization-studio
#### Gurobi
https://www.gurobi.com/downloads/
#### TOMLAB CPLEX
https://tomopt.com/tomlab/download/products.php
#### MOSEK
https://www.mosek.com/downloads/

### (Optional) Text Editors for Programming:
#### Notepad++
https://notepad-plus-plus.org/downloads/
#### Sublime Text
https://www.sublimetext.com/
#### Atom
https://atom.io/
#### Brackets
http://brackets.io/

## Running the code

The folder Tissue Specific FBA contains a set of demo .mat variables, a .csv input dataset and .m scripts that can be run in MATLAB. 

These files include:

`fbamodel.mat` - a genome-scale metabolic model (GSMM) of human breast cancer 

`evaluate_objective.m` - a function called by the script `RUN.m` that performs regularized optimization during FBA by minimizing norm-2 

`gene_expression.csv` - gene expression values for breast cancer

`genes.mat` - a list of genes within the breast cancer model

`ixs_genes_sorted_by_length.mat` - an array indexing all genes by their length (required when replacing genes with their expression values)

`pos_genes_in_react_expr.mat` - an array indexing the position of all genes within all reactions in the model

`reaction_expression.mat` - an array defining the connection between genes and reactions

`RUN.m` - the executeable script for running tissue-specific FBA

The gene expression dataset integrated in this tutorial is the TCGA breast cancer dataset:
https://www.cancer.gov/about-nci/organization/ccg/research/structural-genomics/tcga.

To perform the analysis, simply open `RUN.m` in MATLAB and run the script.

All variables and datasets can be substituted and the script can be adapted according to the users' requirements.

## License

This is free software for academic use that can be redistributed and/or modified under the terms of the GNU Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

This code is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Public License for more details.

Supreeta Vijayakumar - January 2021
