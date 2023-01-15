%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

w = warning ('off', 'all');

%% Import Heathrow.xlsx and read appropriate data
% Read Heathrow.xlsx spreadsheet as double matrix (for data)
HeathrowData = 	readmatrix('Heathrow.xlsx');
[HeathrowData_rows, HeathrowData_cols] = size(HeathrowData);

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

p1 = zeros(1, HeathrowData_cols - 1);
p2 = zeros(1, HeathrowData_cols - 1);
for i = 2:HeathrowData_cols
    [p1(i), p2(i)] = Group69Exe1Fun1(HeathrowData(:, i));
    title(sprintf("Indicator %d [%s]", (i - 1), HeathrowINDICATORText(i - 1)));
end