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

for i = 1:9
    for j = (i + 1):9        
        fprintf("  Indicator %d (%s) and Indicator %d (%s)    \n", i, HeathrowINDICATORText(i), j, HeathrowINDICATORText(j));
        fprintf("==========================================\n");
        X = HeathrowData(:, i + 1);
        Y = HeathrowData(:, j + 1);
        X = X((~isnan(HeathrowData(:, i + 1))) & (~isnan(HeathrowData(:, j + 1))));
        Y = Y((~isnan(HeathrowData(:, i + 1))) & (~isnan(HeathrowData(:, j + 1))));
        R = corrcoef(X, Y);
        r = R(1, 2);
        fprintf("Pearson's correlation coeff. = %d\n", r);
        
        % ...
        p_significance = NaN;
        fprintf("p-value = %d\n", p_significance);

        [mutualInfoEstimate, p, n] = Group69Exe5Fun1(HeathrowData(:, i + 1), HeathrowData(:, j + 1));
        fprintf("Mutal Information I(X,Y) = %d\n", mutualInfoEstimate);
        fprintf("p-value (Non-parametric test using the randomization method) = %d\n", p);

        fprintf("\n");
    end
end