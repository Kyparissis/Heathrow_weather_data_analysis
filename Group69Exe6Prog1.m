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

R2 = nan(10, 10); % Row is depended variable, column is independed
% Assume one of every 10 indic. as depended variable and every one of the
% other 9 as independed and show a plot with those 9 subplots
for i = 1:length(HeathrowINDICATORText)
    if i ~= find(HeathrowINDICATORText == 'TN')
        figure; % Init. new figure to hold subplots
        k = 0;  % Counter for subplot placing
        dependedVariable = HeathrowData(:, i + 1);
        sgtitle(sprintf("Depended Variable: [%s]", HeathrowINDICATORText(i)));
    end
    for j = 1:length(HeathrowINDICATORText)
         if i ~= find(HeathrowINDICATORText == 'TN') && j ~= find(HeathrowINDICATORText == 'TN') && j ~= i
            independedVariable = HeathrowData(:, j + 1);
            k = k + 1;
            subplot(5, 2, k);
            R2(i, j) = Group69Exe6Fun1(independedVariable, dependedVariable);
            title(sprintf("Independed Variable: [%s]", HeathrowINDICATORText(j)));
         end
    end
end

[maxR2s, maxR2s_inds] = maxk(R2, 2, 2); % maxR2s_inds is a 10x2 matrix, every row is a depended variable, columns are indicators' number/indexes
                                        % maxk omits nans
for i = 1:size(R2, 1)
    if i ~= find(HeathrowINDICATORText == 'TN')
        fprintf("    Depended Variable: Indicator %d [%s]   \n", i, HeathrowINDICATORText(i));
        fprintf("===========================================\n");
        fprintf("First biggest R2 is with with indep. var. Indicator %d [%s], R2 = %f\n", maxR2s_inds(i, 1), HeathrowINDICATORText(maxR2s_inds(i, 1)), maxR2s(i, 1));   
        fprintf("Second biggest R2 is with with indep. var. Indicator %d [%s], R2 = %f\n\n", maxR2s_inds(i, 2), HeathrowINDICATORText(maxR2s_inds(i, 2)), maxR2s(i, 2));   
    end
end
