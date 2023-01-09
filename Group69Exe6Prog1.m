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

for i = 1:length(HeathrowINDICATORText)
    for j = 1:length(HeathrowINDICATORText)
        if i ~= find(HeathrowINDICATORText == 'TN') & j ~= find(HeathrowINDICATORText == 'TN') & j ~= i
            Group69Exe6Fun1(HeathrowData(:, i + 1), HeathrowData(:, j + 1));
            xlabel(sprintf("Indicator %d (%s) sample", i, HeathrowINDICATORText(i)));
            ylabel(sprintf("Indicator %d (%s) sample", j, HeathrowINDICATORText(j)));
        end
    end
end