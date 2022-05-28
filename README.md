# Tutorials_Combining_ML_and_GSMM
If you use this code, please cite the associated Springer Chapter:
"Supreeta Vijayakumar, Giuseppe Magazzù, Pradip Moon, Annalisa Occhipinti and Claudio Angione - A Practical Guide to Integrating Multimodal Machine Learning and Metabolic Modeling".

Link: https://pubmed.ncbi.nlm.nih.gov/35604554/

## Running the code

Each of the four subfolders within the repository contains scripts, variables and datasets associated with one of four tutorials described in the publication "A Practical Guide to Integrating Multimodal Machine Learning and Metabolic Modeling".  

The figure `pipeline.pdf` summarizes the workflow for the integration of metabolic modeling with multimodal machine learning and survival analysis outlined in the four tutorials contained in each of the subfolders.

In summary, gene expression data is used as input for a human genome-scale model of breast cancer to generate context-specific metabolic fluxes. These fluxes are in turn used as input for survival (time-to-event) prediction or machine learning analysis using data that has been informed by alterations in metabolic pathways. Further details relating to each analysis are provided in the subfolders.

Note that the tutorial for Tissue Specific FBA must be run before the Survival Analysis, Classification Task with Early Data Integration or Regression Task with Late Data Integration since `fluxes.csv` is a prerequisite for applying survival or machine learning analysis. The latter three tutorials can be run in any order.

## License

This is free software for academic use that can be redistributed and/or modified under the terms of the GNU Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

This code is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Public License for more details.

The Authors - May 2022
