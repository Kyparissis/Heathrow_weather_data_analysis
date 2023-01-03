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

for i = 1:9     % Cheking for the first 9 indicators
    [p1, p2] = Group69Exe3Fun1(HeathrowData(:, 1), HeathrowData(:, i + 1));

    fprintf("       Indicator %d (%s)      \n", i, HeathrowINDICATORText(i));
    fprintf("==============================\n");
    fprintf("p-value from the parametric (student) check = %d \n", p1);
    fprintf("p-value from the resampling check = %d \n", p2);


    fprintf("\n");
end