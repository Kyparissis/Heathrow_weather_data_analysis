% This script finds the pair of indicators that has the best adjR2 value.

clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

%% Import Heathrow.xlsx and read appropriate data
% Read Heathrow.xlsx spreadsheet as double matrix (for data)
HeathrowData = readmatrix('Heathrow.xlsx');
[HeathrowData_rows, HeathrowData_cols] = size(HeathrowData);
HeathrowINDICATORData = HeathrowData(:, 2:HeathrowData_cols);

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

dependedVariableText = "FG";
dependedVariable = HeathrowINDICATORData(:, HeathrowINDICATORText == dependedVariableText);
for i = 1:length(HeathrowINDICATORText)
    if i ~= find(HeathrowINDICATORText == "TN") && i ~= find(HeathrowINDICATORText == dependedVariableText)
        [adjR2, p] = adjR2RandomizationTest(HeathrowINDICATORData(:, i), dependedVariable);
        
        % Console output:
        fprintf("  Depended Variable: [%s] -- Independed Variable: [%s]\n",dependedVariableText, HeathrowINDICATORText(i));
        fprintf("========================================================\n");
        fprintf("--> adjR2 = %g\n", adjR2);
        fprintf("----> p-value (H0: adjR2 == 0) = %g\n\n", p);
    end
end

%%          Conclusions and comments
% ==============================================
%   Krinontas apo ta apotelesmata, dedomenou tou montelou pou epileksame
% vlepoume oti o deikths pou ginetai na eksigei kalutera ton deikth [FG]
% tha einai autos me tin megalyterh timh tou adjR2 me tautoxroni mikri p
% value gia to null hypothesis gia mideniko fitting. Etsi vlepoume oti o
% diktis poy mporei na ton eksigisei kalytera einai o [SN] me adjR2 = 0.349
% kai p value = 0 kai meta isos o diktis [T] me adjR2 = 0.204 me p value
% peripou iso me 0 (= 0.0029).