% This script runs FBA by integrating gene expression data for breast cancer patients
% Add the path to COBRA Toolbox
 addpath(genpath('C:\Program Files\MATLAB\R2020b\toolbox\cobra'));
% Initialize the COBRA Toolbox (this only needs to be completed once and can then be commented out for subsequent runs of the script)
 initCobraToolbox;
% Select Gurobi as the quadratic solver
 changeCobraSolver('gurobi','QP');
% Avoid solver feasibility error by adjusting the optimization parameter
 changeCobraSolverParams('QP', 'method', 1); 

% Load variables
% Human genome-scale model of breast cancer
load('fbamodel.mat'); 
% Specify genes as a separate variable
genes = fbamodel.genes;
% Array indexing the position of genes within reactions
load('pos_genes_in_react_expr.mat');  
% Array defining the connection between genes and reactions
load('reaction_expression.mat'); 
% Array indexing genes by their length (required when replacing genes with their expression values)
load('ixs_genes_sorted_by_length');

% Specify the number of objectives for FBA
M = 1; 
% Specify the number of variables (genes) for FBA 
V = numel(genes); 

% Load gene expression data
Data = readmatrix('gene_expression_data.csv','Range','B2:DB17815');
% Define the dimensions of the data
% p genes (rows) and n samples (columns)
p = size(Data,1);
n = size(Data,2);

% Create vector to store the optimal biomass flux for each sample
biomass = zeros(1,n); 
% Create matrix to store the total fluxes obtained for each sample
fluxes = zeros(size(fbamodel.rxns,1),n); 

% Run the model for each patient
% Set the gamma value
gamma = 10;
% For each sample in the dataset, calculate the flux distribution by optimizing the flux objective f
for i=1:n
[v_out, f_out] = evaluate_objective(Data(:,i),M,V,fbamodel,genes,reaction_expression,pos_genes_in_react_expr,ixs_genes_sorted_by_length,gamma);
% Save biomass values in the vector created in line 24
biomass(i) = f_out;
% Store total flux distribution in the matrix created in line 26
fluxes(:,i) = array2table(v_out);
end
% Save flux values for all samples into a .csv file to be used for survival analysis and machine learning applications
writematrix(fluxes,'fluxes.csv');