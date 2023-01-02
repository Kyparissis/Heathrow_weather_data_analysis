%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

%% Import Heathrow.xlsl and read appropriate data
% Read Heathrow.xlsx spreadsheet as double matrix (for data)
HeathrowData = 	readmatrix('Heathrow.xlsx');
[HeathrowData_rows, HeathrowData_cols] = size(HeathrowData);

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

%% Calculate the mean value of every indicator in the period 1949-1958
indexOf1949 = find(HeathrowData(:, 1) == 1949);
indexOf1958 = find(HeathrowData(:, 1) == 1958);
HeathrowData_1949_1958 = HeathrowData(indexOf1949:indexOf1958, :);
HeathrowINDICATORData_1949_1958 = HeathrowData_1949_1958(:, 2:HeathrowData_cols); % Removing years column

HeathrowINDICATORData_1949_1958_mean = mean(HeathrowINDICATORData_1949_1958, 1, 'omitnan');  % Mean across dimension 1 / mean of the elements in each column

%% Function call giving as sample the indicator values in the period 1973-after
indexOf1973 = find(HeathrowData(:, 1) == 1973);
HeathrowData_after1973 = HeathrowData(indexOf1973:HeathrowData_rows, :);
HeathrowINDICATORData_after1973 = HeathrowData_after1973(:, 2:HeathrowData_cols); % Removing years column

HeathrowINDICATORData_after1973_mean = mean(HeathrowINDICATORData_after1973, 1, 'omitnan');  % Mean across dimension 1 / mean of the elements in each column

ci1 = nan(9, 2);
ci2 = nan(9, 2);
for i = 1:9   % Checking for the first 9 indicators!
    [ci1(i, :), ci2(i, :)] = Group69Exe2Fun1(HeathrowINDICATORData_after1973(:, i));

    fprintf("       Indicator %d (%s)      \n", i, HeathrowINDICATORText(i));
    fprintf("==============================\n")
    fprintf("-> Mean value (1973-after) 95%% parametric confidence interval = [%d , %d]\n",ci1(i, 1), ci1(i, 2));
    fprintf("-> Mean value (1973-after) 95%% bootstrap confidence interval = [%d , %d]\n",ci2(i, 1), ci2(i, 2));
    fprintf("-> Mean value (1949-1958) = %d\n", HeathrowINDICATORData_1949_1958_mean(i));
    fprintf("-> Mean value (1973-after) = %d\n", HeathrowINDICATORData_after1973_mean(i));

    % Cheking if the indicator's mean value from the 1949-1958 period is in
    % either mean value confidence interval from the period 1973-after
    % Checking on the parametric confidence interval
    if ci1(i, 1) <= HeathrowINDICATORData_1949_1958_mean(i) & HeathrowINDICATORData_1949_1958_mean(i) <= ci1(i, 2)
        fprintf("--> Indicator %d mean value (1949-1958) is in the (1973-after) 95%% parametric confidence interval.\n", i);
    end
    % Checking on the bootstrap confidence interval
    if ci2(i, 1) <= HeathrowINDICATORData_1949_1958_mean(i) & HeathrowINDICATORData_1949_1958_mean(i) <= ci2(i, 2)
        fprintf("--> Indicator %d mean value (1949-1958) is in the (1973-after) 95%% bootstrap confidence interval.\n", i);
    end

    % Check if the two confidence intervals differ significantly
   
    
    fprintf("\n");
end

%% Conclusions and comments
% TODO: THIS