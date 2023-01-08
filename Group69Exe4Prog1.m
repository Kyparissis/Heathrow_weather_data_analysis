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

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

alpha = 0.05;

for i = 1:9
    for j = (i + 1):9
        [paramFisherCI, bstrpCI, p1, p2, n] = Group69Exe4Fun1(HeathrowData(:, i + 1), HeathrowData(:, j + 1));
        
        fprintf("  Indicator %d (%s) and Indicator %d (%s)    \n", i, HeathrowINDICATORText(i), j, HeathrowINDICATORText(j));
        fprintf("==========================================\n");
        fprintf("Fisher transform confidence interval: [%d %d]\n", paramFisherCI(1), paramFisherCI(2))
        fprintf("Bootstrap confidence interval: [%d %d]\n", bstrpCI(1), bstrpCI(2))
        fprintf("p-value (H0: r == 0) from the parametric (student) test = %d \n", p1);
        fprintf("p-value (H0: r == 0) from the resampling test = %d \n", p2);

        fprintf("\n");
    end
end