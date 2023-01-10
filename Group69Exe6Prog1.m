%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

%% TODO: CHECH THIS. PLOTS MIGHT APPEAR IN WRONG ORDER??

%% Import Heathrow.xlsx and read appropriate data
% Read Heathrow.xlsx spreadsheet as double matrix (for data)
HeathrowData = 	readmatrix('Heathrow.xlsx');
[HeathrowData_rows, HeathrowData_cols] = size(HeathrowData);

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

for i = 1:length(HeathrowINDICATORText)
    if i ~= find(HeathrowINDICATORText == 'TN')
        figure;
        k = 0;
    end
    for j = 1:length(HeathrowINDICATORText)
         if i ~= find(HeathrowINDICATORText == 'TN') & j ~= find(HeathrowINDICATORText == 'TN') & j ~= i
            k = k + 1;
            subplot(5, 2, k);
            Group69Exe6Fun1(HeathrowData(:, j + 1), HeathrowData(:, i + 1));
        end
    end
end