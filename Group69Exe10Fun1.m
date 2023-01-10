%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [OptimalModel, LASSO_PenaltyFactor] = Group69Exe10Fun1(dependedVariableSample, independedVariableSamples)
    %% Depended variable sample must be vector
    if ~(isvector(dependedVariableSample))
        error("ERROR FOUND! Depended variable sample must be vector.\nAborting...\n");
    end
    
    %% Make depended variable sample column vector
    if ~iscolumn(dependedVariableSample)
        dependedVariableSample = dependedVariableSample';
    end

    %% Two inputs must have the same number of rows
    if length(dependedVariableSample) ~= size(independedVariableSamples, 1)
        error("ERROR FOUND! Two inputs must have the same number of rows.\nAborting...\n");
    end
    %% ============== (a') ==============
    rowsWithNaN = any(isnan(dependedVariableSample), 2) | any(isnan(independedVariableSamples), 2);
    dependedVariableSample(rowsWithNaN, :) = [];
    independedVariableSamples(rowsWithNaN, :) = [];
    
    %% ============== (b') ==============
    numIndependedVariables = size(independedVariableSamples, 2); % number of independent variables
    n = size(independedVariableSamples, 1);
    numModels = 2^numIndependedVariables; % number of possible models

    % Initialize adjR2
    adjR2 = zeros(numModels, 1);

    % Loop through all possible models
    for i = 1:numModels
        % Convert i to binary representation to determine which variables to include in this model
        bin = double(int2bit((i - 1), numIndependedVariables));
        
        % initialize X subset
        x = [ones(n, 1)];

        % loop through all variables and add to subset if included in model
        for j = 1:length(bin)
            if bin(j) == 1
                x = [x independedVariableSamples(:, j)];
            end
        end
        
        % Calculate linear regression parameters
        Y = dependedVariableSample;
        b = regress(Y, x);
        
        y = x * b;  % Predicted values
        e = Y - y;  % Error
        
        % Calculate number of parameters
        p = size(x, 2) - 1;

        adjR2(i) = 1 - ((n - 1)/(n - (p + 1)))*(sum(e.^2))/(sum((Y - mean(Y)).^2));
    end
    
    % Optimal model is the one with the maximum adjR2
    [~, OptimalModel] = max(adjR2);
    % Returning the optimal model as an 1xnumIndependedVariables boolean
    % matrix. If index (1,i) = 1, model uses Independed Variable from
    % column i. If index (1,i) = 0 it doesn't use that variable
    OptimalModel = double(int2bit((OptimalModel - 1), numIndependedVariables))';

    %% ============== (c') ==============
    


end