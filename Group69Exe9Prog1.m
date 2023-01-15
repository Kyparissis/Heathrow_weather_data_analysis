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
HeathrowINDICATORData = HeathrowData(:, 2:HeathrowData_cols);

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

%% Keeping data after 1973
row_1973 = find(HeathrowData(:, 1) == 1973);
HeathrowData = HeathrowData(row_1973:HeathrowData_rows, :);

%% Removing years column from data
yearsColumn = HeathrowData(:, 1);
HeathrowData(:, 1) = [];

%% ============== (a') ==============
% Find all the NaN values and remove the corresponding pair values
% so that HeathrowData doesn't have empty values.
rowsWithNaN = any(isnan(HeathrowData), 2);
HeathrowData(rowsWithNaN, :) = [];
[HeathrowData_rows_noNaN, HeathrowData_cols_noNaN] = size(HeathrowData);

%% For [FG] Indicator
dependedVariableCol = [find(HeathrowINDICATORText == "FG") find(HeathrowINDICATORText == "GR")];
for i = 1:length(dependedVariableCol)
    % Getting dependedVariable column
    dependedVariable = HeathrowData(:, dependedVariableCol(i)); 
    dependedVariableText = HeathrowINDICATORText(dependedVariableCol(i));
    % Removing dependedVariable column from matrix and getting independedVariables 
    independedVariables = HeathrowData;
    independedVariables(:, dependedVariableCol(i)) = [];
    
    % Getting independed indicators' texts (used for console output)
    independedVariableTexts = HeathrowINDICATORText;
    independedVariableTexts(dependedVariableCol(i)) = [];
    
    fprintf("   Depended Variable: [%s]    \n", HeathrowINDICATORText(dependedVariableCol(i)));
    fprintf("============================= \n");
    
    %% ============== (b') ==============
    fprintf("[ Linear regression model with all indicators ]\n")
    Y = dependedVariable;
    x = [ones(HeathrowData_rows_noNaN, 1) independedVariables];

    % Calculate linear regression parameters
    [b, ~, ~, ~, stats] = regress(Y, x);
   
    % Used to get the pvals
    % We don't need to insert ones(HeathrowData_rows_noNaN, 1) col here
    lmObj = fitlm(independedVariables, Y, 'VarNames', [independedVariableTexts dependedVariableText]); 
   
    y = x * b;
    e = Y - y;

    k = size(independedVariables, 2);
    n = HeathrowData_rows_noNaN;

    se2 = (1/(n - (k + 1)))*sum(e.^2); % error variance == stats(4) == lmObj.MSE
    R2 = 1 - (sum(e.^2))/(sum((Y - mean(Y)).^2)); % == stats(1) == lmObj.Rsquared.Ordinary
    adjR2 = 1 - ((n - 1)/(n - (k + 1)))*(sum(e.^2))/(sum((Y - mean(Y)).^2)); % == lmObj.Rsquared.Adjusted
    fprintf("--> Error variance = %f\n", se2);
    fprintf("--> R2 = %f\n", R2);
    fprintf("--> adjR2 = %f\n", adjR2);
    
    % Significance test
    % If greater than 0.05, term is not significant at the 5% significance level given the other terms in the model.
    pval = table2array(lmObj.Coefficients(:, 4));
    alpha = 0.05;
    for j = 2:length(pval) % Ignoring 1st pval since its for the intercept
        if pval(j) < alpha
            fprintf("---> Indicator's [%s] coeff. is statistically significant.\n", independedVariableTexts(j - 1));
        end
    end

    %% ============== (c') ==============
    fprintf("\n[ Stepwise regression model ]\n")
    Y = dependedVariable;
    x = [ones(HeathrowData_rows_noNaN, 1) independedVariables];

    % Calculate linear regression parameters
    [bs_tmp, ~, pval, finalmodel, stats] = stepwisefit(independedVariables, Y, 'display', 'off'); % Could use stepwiselm as well
%     stepObj = stepwiselm(independedVariables, Y, 'VarNames', [independedVariableTexts dependedVariableText]);
    
    bs = [stats.intercept;
               bs_tmp    ];
    
    for j = 1:length(finalmodel)  
        if finalmodel(j) == 1
            fprintf("Indicator [%s] used in model.\n", independedVariableTexts(j))
        end
    end

    y = x * (bs.*[1 finalmodel]');
    e = Y - y;

    k = sum(finalmodel);
    n = HeathrowData_rows_noNaN;

    se2 = (1/(n - (k + 1)))*(sum(e.^2));  % error variance == stepObj.MSE
    R2 = 1 - (sum(e.^2))/(sum((Y - mean(Y)).^2)); % == stepObj.Rsquared.Ordinary
    adjR2 =1 - ((n - 1)/(n - (k + 1)))*(sum(e.^2))/(sum((Y - mean(Y)).^2)); % == stepObj.Rsquared.Adjusted
    fprintf("--> Error variance = %f\n", se2);
    fprintf("--> R2 = %f\n", R2);
    fprintf("--> adjR2 = %f\n", adjR2);

    alpha = 0.05;
    for j = 1:length(pval)
        if pval(j) < alpha && finalmodel(j) == 1 % if we got pvals from stepwiselm, finalmodel check is not needed
            fprintf("---> Indicator's [%s] coeff. is statistically significant.\n", independedVariableTexts(j));
        end
    end
    
    %% ============== (c') ==============
    fprintf("\n[ Dimension reduction regression model (LASSO) ]\n")
    % Centering the data
%     xc = independedVariables - repmat(mean(independedVariables), HeathrowData_rows_noNaN, 1)
%     yc = dependedVariable - mean(dependedVariable)
    
%     [bL, fitinfo] = lasso(independedVariables, dependedVariable);
%     y_pred = xc*bL;
%     lassoPlot(bL,fitinfo,'PlotType','Lambda','XScale','log');
% 
%     SSres = sum((y-y_pred).^2);
%     SStot = sum((y-mean(y)).^2);
%     R2 = 1 - SSres/SStot;
%     p = size(X,2);
%     adj_R2 = 1 - (1-R2)*(size(y,1)-1)/(size(y,1)-p-1);

    fprintf("\n\n");
end

%% Conclusions and comments
% TODO: THIS
%>...
%...
% ...








