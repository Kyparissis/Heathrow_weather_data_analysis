%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

% Read Heathrow.xlsx spreadsheet as double matrix
HeathrowData = 	readmatrix('Heathrow.xlsx'); 
[HeathrowData_rows, HeathrowData_cols] = size(HeathrowData);

%% Calculate the mean value of every indicator in the period 1949-1958
indexOf1949 = find(HeathrowData(:, 1) == 1949);
indexOf1958 = find(HeathrowData(:, 1) == 1958);
HeathrowData_1949_1958 = HeathrowData(indexOf1949:indexOf1958, :);
HeathrowINDICATORData_1949_1958 = HeathrowData_1949_1958(:, 2:HeathrowData_cols);

HeathrowData_1949_1958_mean = mean(HeathrowData_1949_1958, 1, 'omitnan');  % Mean across dimension 1 / mean of the elements in each column

%% Function call giving as sample the indicator values in the period 1973-after
indexOf1973 = find(HeathrowData(:, 1) == 1973);
HeathrowData_after1973 = HeathrowData(indexOf1973:HeathrowData_rows, :);
HeathrowINDICATORData_after1973 = HeathrowData_after1973(:, 2:HeathrowData_cols);

% for i = 1:9
%     [ci1(i, :) ci2(i, :)] = Group69Exe2Fun1(HeathrowINDICATORData_after1973(i))
% end