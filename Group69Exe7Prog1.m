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

dependedVariableText = "FG";
dependedVariable = HeathrowINDICATORData(:, find(HeathrowINDICATORText == dependedVariableText));
for i = 1:length(HeathrowINDICATORText)
    if i ~= find(HeathrowINDICATORText == "TN") && i ~= find(HeathrowINDICATORText == dependedVariableText)
        [adjR2_Model(i), TypeOfModel(i)] = Group69Exe7Fun1(HeathrowINDICATORData(:, i), dependedVariable);
        
        sgtitle(sprintf("Depended Variable: [%s] -- Independed Variable: [%s]", dependedVariableText, HeathrowINDICATORText(i)));
        
        % Console output:
        fprintf("  Depended Variable: [%s] -- Independed Variable: [%s]\n",dependedVariableText, HeathrowINDICATORText(i));
        fprintf("========================================================\n");
        fprintf("--> Best fitted by model #%d\n", TypeOfModel(i));
        fprintf("----> with adjR2 = %f\n\n", adjR2_Model(i));
    end
end

% ...
%
%   We can also see that some adjusted R square (adjR2) values are negative.
% The formula for adjusted R square allows it to be negative. It is intended to approximate the actual percentage variance explained. 
% So if the actual R square is close to zero the adjusted R square can be slightly negative and we think of it as an estimate of zero.
% Keep in mind that adjusted R square is a model selection criterion, so neither its sign nor its magnitude have any statistical meaning (unlike R square). 
% Low adjusted R square, whether negative or not, just tells you that the model is a poor fit.
% 
% ...