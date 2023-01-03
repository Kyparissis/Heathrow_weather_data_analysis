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
    if i ~= find(HeathrowINDICATORText == "TN")
        if i ~= find(HeathrowINDICATORText == dependedVariableText)
%             [] = Group69Exe8Fun1(HeathrowINDICATORData(:, i), dependedVariable);
        end
    end
end