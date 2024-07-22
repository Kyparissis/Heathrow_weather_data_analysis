% This script calculates the Pearson's correlation coefficient and the mutual information between every pair of indicators.

clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

w = warning ('off', 'all');

%% Import Heathrow.xlsx and read appropriate data
% Read Heathrow.xlsx spreadsheet as double matrix (for data)
HeathrowData = readmatrix('Heathrow.xlsx');
[HeathrowData_rows, HeathrowData_cols] = size(HeathrowData);

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

p1 = zeros(1, HeathrowData_cols - 1);
p2 = zeros(1, HeathrowData_cols - 1);
isContinuous = zeros(1, HeathrowData_cols - 1);
for i = 2:HeathrowData_cols
    [p1(i), p2(i), isContinuous(i)] = distributionChiSquaredTests(HeathrowData(:, i));
    
    title(sprintf("Indicator %d [%s]", (i - 1), HeathrowINDICATORText(i - 1)));
    
    fprintf("      Indicator %d [%s]\n", (i - 1), HeathrowINDICATORText(i - 1));
    fprintf("============================= \n");
    if isContinuous(i) == 1
        fprintf("--> Indicator is treated as a CONTINUOUS variable.\n");
        if p1(i) > p2(i)
            fprintf("----> Indicator follows NORMAL distribution.\n")
        else
            fprintf("----> Indicator follows UNIFORM distribution.\n")
        end
    else
        fprintf("--> Indicator is treated as a DISCRETE variable.\n");
        if p1(i) > p2(i)
            fprintf("----> Indicator follows BINOMIAL distribution.\n")
        else
            fprintf("----> Indicator follows DISCRETE UNIFORM distribution.\n")
        end
    end
    fprintf("\n")
end