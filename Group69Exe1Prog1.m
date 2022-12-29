clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

% Read Heathrow.xlsx spreadsheet as double matrix
HeathrowData = 	readmatrix('Heathrow.xlsx'); 
[HeathrowData_rows, HeathrowData_cols] = size(HeathrowData);

p1 = zeros(1, HeathrowData_cols - 1);
p2 = zeros(1, HeathrowData_cols - 1);
for i = 2:HeathrowData_cols
    [p1(i), p2(i)] = Group69Exe1Fun1(HeathrowData(:, i));
end