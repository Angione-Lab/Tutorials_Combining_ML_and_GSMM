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
load('ixs_genes_sorted_by_length.mat');

% Load gene expression data
Data = readtable('gene_expression_data.csv');
% Get the list of genes in the file
genes_in_dataset = string(table2cell(Data(:, 1)));
% Get gene expression profiles
Data = table2array(Data(:,2:end));
% Convert log2FC expression to FC centered around 1
Data = 2.^(Data);
% Define the dimensions of the data
% p genes (rows) and n samples (columns)
p = size(Data,1);
n = size(Data,2);

% Create vector to store the optimal biomass flux for each sample, if of interest
% biomass = zeros(1,n); 
% Create cell array to store the total fluxes obtained for each sample
fluxes{n,size(fbamodel.rxns,1)} = [];

GeneExpressionArray = ones(numel(genes),1); 
% Run the model for each patient
% Set the gamma value
gamma = 10;
% For each sample in the dataset, calculate the flux distribution by optimizing the flux objective f
for i=1:n
    expr_profile = Data(:,i);
    % Filter the gene expression data for the genes that are present in the dataset
    % For those not present leave 1, i.e. normally expressed
    pos_genes_in_dataset = zeros(numel(genes),1);   
    for j=1:length(pos_genes_in_dataset)
        position = find(strcmp(genes{j},genes_in_dataset),1); 
        if ~isempty(position)                                   
            pos_genes_in_dataset(j) = position(1);              
            GeneExpressionArray(j) = expr_profile(pos_genes_in_dataset(j));         
        end
    end
    [v_out, f_out] = evaluate_objective(GeneExpressionArray,fbamodel,genes,reaction_expression,pos_genes_in_react_expr,ixs_genes_sorted_by_length,gamma);

% Store biomass values if of interest
%    biomass(i) = f_out;
% Store total flux distribution 
    fluxes(i,:) = num2cell(v_out);
end
% Save flux values for all samples into a .csv file to be used for survival analysis and machine learning applications
writetable(cell2table(fluxes),'fluxes.csv');