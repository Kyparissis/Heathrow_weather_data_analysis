% This function calculates and plots the non-linear regression lines between two samples.
% The non-linear regression lines are calculated using the least squares method and are up to the 3rd degree polynomial and the ln-transform.
% The adjusted R-squared statistic is also calculated.
% INPUTS:
% sample1: A vector of the first sample.
% sample2: A vector of the second sample.
% OUTPUTS:
% adjR2_Model: The adjusted R-squared statistic for the best model.
% TypeOfModel: The type of the best model.
function [adjR2_Model, TypeOfModel] = plotNonLinearRegressionLines(sample1, sample2)
    %% Both samples must be vectors
    if ~(isvector(sample1) && isvector(sample2))
        error("ERROR FOUND! Two samples must be vectors. Aborting...");
    end
    
    %% Make both vector samples column vectors
    if ~iscolumn(sample1)
        sample1 = sample1';
    end
    if ~iscolumn(sample2)
        sample2 = sample2';
    end

    %% Two sample vectors must have the same length
    if length(sample1) ~= length(sample2)
        error("ERROR FOUND! Two sample vectors must have the same length. Aborting...");
    end
    
    %% ============== (a') ==============
    % Find the "empty" (NaN) values in the given samples and removing the value pairs,
    % so that the samples no longer have "empty" values.
    indexesToKeep = (~isnan(sample1)) & (~isnan(sample2));
    sample1 = sample1(indexesToKeep);     % Independed variable
    sample2 = sample2(indexesToKeep);     % Depended variable
    
    n = length(sample1); % == length(sample2)

    %% ============== (b') ==============
    figure;
    %% 1st degree (linear) regression model using least squares method
    %% TypeOfModel is 1
    numOfVariables = 1;  % Number of non-linear parameters
    x = [ones(n,1) sample1];
    Y = sample2;
    b = regress(Y, x);

    % Linear regression model: y = ax + b = b(2)*x + b(1)
    x0 = linspace(min(sample1), max(sample1), 2)';
    y0 = b(2)*x0 + b(1);
    
    subplot(2,2,1);
    scatter(sample1, sample2, 12, 'blue', 'filled');
    hold on;
    plot(x0, y0, 'LineWidth', 2, 'Color', "#D95319");

    y = x * b;  % Predicted values
    e = Y - y;  % Error
    
    % Calculate the adjusted R-squared statistic
    adjR2(1) = 1 - ((n - 1)/(n - (numOfVariables + 1)))*(sum(e.^2))/(sum((sample2 - mean(sample2)).^2));
    % Show adjR2 as text on plot
    ax = axis;
    text(ax(2)-0.05*(ax(2)-ax(1)),ax(4)-0.15*(ax(4)-ax(3)), sprintf("adjR^2 = %g", adjR2(1)), 'Horiz','right', 'Vert', 'cap');

    title("1st degree (linear) regression model");
    subtitle("(Model #1)");

    %% 2nd degree regression model using least squares method
    %% TypeOfModel is 2
    numOfVariables = 2;  % Number of non-linear parameters
    x = [ones(n,1) sample1 sample1.^2];
    Y = sample2;
    b = regress(Y, x);

    % Regression model: y = a*x^2 + b*x + c = b(3)*x^2 + b(2)*x + b(1)
    x0 = linspace(min(sample1), max(sample1), 1000)';
    y0 = b(3)*x0.^2 + b(2)*x0 + b(1);
    
    subplot(2,2,2);
    scatter(sample1, sample2, 12, 'blue', 'filled');
    hold on;
    plot(x0, y0, 'LineWidth', 2, 'Color', "#D95319");
    
    y = x * b;  % Predicted values
    e = Y - y;  % Error
    
    % Calculate the adjusted R-squared statistic
    adjR2(2) = 1 - ((n - 1)/(n - (numOfVariables + 1)))*(sum(e.^2))/(sum((sample2 - mean(sample2)).^2));
    % Show adjR2 as text on plot
    ax = axis;
    text(ax(2)-0.05*(ax(2)-ax(1)),ax(4)-0.15*(ax(4)-ax(3)), sprintf("adjR^2 = %g", adjR2(2)), 'Horiz','right', 'Vert', 'cap');

    title("2nd degree regression model");
    subtitle("(Model #2)");

    %% 3rd degree regression model using least squares method
    %% TypeOfModel is 3
    numOfVariables = 3;  % Number of non-linear parameters
    x = [ones(n,1) sample1 sample1.^2 sample1.^3];
    Y = sample2;
    b = regress(Y, x);

    % Regression model: y = a*x^3 + b*x^2 + c*x + d = b(4)*x^3 + b(3)*x^2 + b(2)*x + b(1)
    x0 = linspace(min(sample1), max(sample1), 1000)';
    y0 = b(4)*x0.^3 + b(3)*x0.^2 + b(2)*x0 + b(1);
    
    subplot(2,2,3);
    scatter(sample1, sample2, 12, 'blue', 'filled');
    hold on;
    plot(x0, y0, 'LineWidth', 2, 'Color', "#D95319");
    
    y = x * b;  % Predicted values
    e = Y - y;  % Error

    % Calculate the adjusted R-squared statistic
    adjR2(3) = 1 - ((n - 1)/(n - (numOfVariables + 1)))*(sum(e.^2))/(sum((sample2 - mean(sample2)).^2));
    % Show adjR2 as text on plot
    ax = axis;
    text(ax(2)-0.05*(ax(2)-ax(1)),ax(4)-0.15*(ax(4)-ax(3)), sprintf("adjR^2 = %g", adjR2(3)), 'Horiz','right', 'Vert', 'cap');

    title("3rd degree regression model");
    subtitle("(Model #3)");

    %% Ln-transform y = a*exp(b*x) regression model using least squares method
    %% TypeOfModel is 4
    Y = log(sample2);
    x = [ones(n,1) sample1];
    b = regress(Y, x);

    % Regression model: y= ln(a) + b*x
    y = x * b;  % Predicted values
    subplot(2,2,4);
    scatter(sample1, log(sample2), 12, 'blue', 'filled');
    hold on;
    plot(sample1, y, 'LineWidth', 2, 'Color', "#D95319");
    
    e = Y - y;  % Error

    % Calculate the adjusted R-squared statistic
    adjR2(4) = 1 - ((n - 1)/(n - 2))*(sum(e.^2))/(sum((Y - mean(Y)).^2));
    % Show adjR2 as text on plot
    ax = axis;
    text(ax(2)-0.05*(ax(2)-ax(1)),ax(4)-0.15*(ax(4)-ax(3)), sprintf("adjR^2 = %g", adjR2(4)), 'Horiz','right', 'Vert', 'cap');

    title("Ln-transform - intrinsically linear function regression model");
    subtitle("(Model #4)");

    %% ============== (d') ==============
    [adjR2_Model, TypeOfModel] = max(adjR2);
    
end