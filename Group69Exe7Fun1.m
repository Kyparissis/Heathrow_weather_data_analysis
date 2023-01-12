%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [adjR2_Model, TypeOfModel] = Group69Exe7Fun1(sample1, sample2)
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
    n = length(sample1);

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

    R2(1) = 1 - (sum(e.^2))/(sum((Y - mean(Y)).^2));
    adjR2(1) = 1 - ((n - 1)/(n - (numOfVariables + 1)))*(sum(e.^2))/(sum((sample2 - mean(sample2)).^2));
    text(max(xlim), 2*max(ylim)/3, sprintf("adjR^2 = %f", adjR2(1)), 'Horiz','right', 'Vert', 'cap');

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

    R2(2) = 1 - (sum(e.^2))/(sum((Y - mean(Y)).^2));
    adjR2(2) = 1 - ((n - 1)/(n - (numOfVariables + 1)))*(sum(e.^2))/(sum((sample2 - mean(sample2)).^2));
    text(max(xlim), 2*max(ylim)/3, sprintf("adjR^2 = %f", adjR2(2)), 'Horiz','right', 'Vert', 'cap');

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

    R2(3) = 1 - (sum(e.^2))/(sum((Y - mean(Y)).^2));
    adjR2(3) = 1 - ((n - 1)/(n - (numOfVariables + 1)))*(sum(e.^2))/(sum((sample2 - mean(sample2)).^2));
    text(max(xlim), 2*max(ylim)/3, sprintf("adjR^2 = %f", adjR2(3)), 'Horiz','right', 'Vert', 'cap');

    title("3rd degree regression model");
    subtitle("(Model #3)");

    %% Ln-transform y = a*exp(b*x) regression model using least squares method
    %% TypeOfModel is 4
    Y = log(sample2);
    x = [ones(n,1) sample1];
    b = regress(Y, x);

    % Regression model: y= ln(a) + b*x
    x0 = linspace(min(sample1), max(sample1), 1000)';
    y0 = b(2)*x0 + b(1);
    subplot(2,2,4);
    scatter(sample1, log(sample2), 12, 'blue', 'filled');
    hold on;
    plot(x0, y0, 'LineWidth', 2, 'Color', "#D95319");
    
    y = x * b;  % Predicted values
    e = Y - y;  % Error

    R2(4) = 1 - (sum(e.^2))/(sum((Y - mean(Y)).^2));
    adjR2(4) = 1 - ((n - 1)/(n - 2))*(sum(e.^2))/(sum((Y - mean(Y)).^2));
    text(max(xlim), max(ylim), sprintf("adjR^2 = %f", adjR2(4)), 'Horiz','right', 'Vert', 'cap');

    title("Ln-transform - intrinsically linear function regression model");
    subtitle("(Model #4)");

    %% ============== (d') ==============
    [adjR2_Model, TypeOfModel] = max(adjR2);
    
end

% Test: Group69Exe7Fun1([16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46]', [2508 2518 3304 3423 3057 3190 3590 3883 3823 3646 3708 3333 3517 3241 3103 2776]')
% The formula for adjusted R square allows it to be negative. It is intended to approximate the actual percentage variance explained. 
% So if the actual R square is close to zero the adjusted R square can be slightly negative. Just think of it as an estimate of zero.