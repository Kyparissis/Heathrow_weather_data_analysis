%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

%% Import Heathrow.xlsx and read appropriate data
% Read Heathrow.xlsx spreadsheet as double matrix (for data)
HeathrowData = 	readmatrix('Heathrow.xlsx');
[HeathrowData_rows, HeathrowData_cols] = size(HeathrowData);
HeathrowINDICATORData = HeathrowData(:, 2:HeathrowData_cols);

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

%% For depended variable FG
dependedVariableText = "FG";
dependedVariable = HeathrowINDICATORData(:, HeathrowINDICATORText == dependedVariableText);
independedVariablesColumns = find(HeathrowINDICATORText ~= "GR" &  HeathrowINDICATORText ~= "TN" & HeathrowINDICATORText ~= dependedVariableText);
independedVariables = HeathrowINDICATORData(:, independedVariablesColumns);

fprintf("   Depended Variable: [%s]    \n", dependedVariableText);
fprintf("============================= \n");

[OptimalModel_bin, LASSO_PenaltyFactor] = Group69Exe10Fun1(dependedVariable, independedVariables);

for j = 1:length(OptimalModel_bin)  
    if OptimalModel_bin(j) == 1
        fprintf("-> Indicator [%s] used in optimal model.\n", HeathrowINDICATORText(independedVariablesColumns(j)))
    end
end
if isempty(LASSO_PenaltyFactor)
    fprintf("---> LASSO couldn't find the optimal model.\n")
else
    fprintf("---> LASSO found the optimal model with penalty = %f\n", LASSO_PenaltyFactor);
end

%% For depended variable GR
dependedVariableText = "GR";
dependedVariable = HeathrowINDICATORData(:, HeathrowINDICATORText == dependedVariableText);
independedVariablesColumns = find(HeathrowINDICATORText ~= "FG" &  HeathrowINDICATORText ~= "TN" & HeathrowINDICATORText ~= dependedVariableText);
independedVariables = HeathrowINDICATORData(:, independedVariablesColumns);

fprintf("\n   Depended Variable: [%s]    \n", dependedVariableText);
fprintf("============================= \n");

[OptimalModel_bin, LASSO_PenaltyFactor] = Group69Exe10Fun1(dependedVariable, independedVariables);

for j = 1:length(OptimalModel_bin)  
    if OptimalModel_bin(j) == 1
        fprintf("-> Indicator [%s] used in optimal model.\n", HeathrowINDICATORText(independedVariablesColumns(j)))
    end
end
if isempty(LASSO_PenaltyFactor)
    fprintf("---> LASSO couldn't find the optimal model.\n")
else
    fprintf("---> LASSO found the optimal model with penalty = %f\n", LASSO_PenaltyFactor);
end

%% Conclusions and comments
% TODO: THIS
%>...
%...
% ...
