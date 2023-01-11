%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [OptimalModel_bin, LASSO_PenaltyFactor] = Group69Exe10Fun1(dependedVariableSample, independedVariableSamples)
    %% Depended variable sample must be vector
    if ~(isvector(dependedVariableSample))
        error("ERROR FOUND! Depended variable sample must be vector. Aborting...");
    end

    %% Independed variables sample must be matrix
    if ~(ismatrix(independedVariableSamples))
        error("ERROR FOUND! Independed variable sample must be a matrix. Aborting...");
    end
    
    %% Make depended variable sample column vector
    if ~iscolumn(dependedVariableSample)
        dependedVariableSample = dependedVariableSample';
    end

    %% Two inputs must have the same number of rows
    if length(dependedVariableSample) ~= size(independedVariableSamples, 1)
        error("ERROR FOUND! Two inputs must have the same number of rows. Aborting...");
    end
    
    %% ============== (a') ==============
    % Find all the NaN values and remove the corresponding pair values
    % so that the two vectors don't have empty values.
    rowsWithNaN = any(isnan(dependedVariableSample), 2) | any(isnan(independedVariableSamples), 2);
    dependedVariableSample(rowsWithNaN, :) = [];
    independedVariableSamples(rowsWithNaN, :) = [];
    
    %% ============== (b') ==============
    numIndependedVariables = size(independedVariableSamples, 2); % number of independent variables
    n = size(independedVariableSamples, 1);                      % number of rows
    
    numModels = 2^numIndependedVariables; % number of possible models
    adjR2 = zeros(numModels, 1);
    % Loop through all possible models
    for i = 1:numModels
        % Convert i to binary representation to determine which variables to include in this model
        bin = double(int2bit((i - 1), numIndependedVariables))';
        
        % Initialize X subset
        x = [ones(n, 1) independedVariableSamples(:, logical(bin))];
        
        % Calculate linear regression parameters
        b = regress(dependedVariableSample, x);
        
        y = x * b;                       % Predicted values
        e = dependedVariableSample - y;  % Error
        
        % Calculate number of parameters
        p = sum(bin);
        
        % Calculate the adjR2 value
        adjR2(i) = 1 - ((n - 1)/(n - (p + 1)))*(sum(e.^2))/(sum((dependedVariableSample - mean(dependedVariableSample)).^2));
    end
    
    % Optimal model is the one with the maximum adjR2
    [~, OptimalModel_dec] = max(adjR2);
    % Returning the optimal model as an 1xnumIndependedVariables boolean
    % vector. If index (1,i) = 1, model uses Independed Variable from
    % independedVariableSamples's column i. 
    % If index (1,i) = 0 it doesn't use that variable.
    % eg. OptimalModel_bin = [0 0 1 0 1 0 0 0 0] keeps columns' 3 and 5 independed variables
    OptimalModel_bin = double(int2bit((OptimalModel_dec - 1), numIndependedVariables))';

    %% ============== (c') ==============
    % Centering the data
    % It makes sure that the LASSO method is not affected by the scale of the independent variables
    independedVariableSamples_centered = independedVariableSamples - repmat(mean(independedVariableSamples), n, 1);
    dependedVariableSample_centered = dependedVariableSample - mean(dependedVariableSample);
    
    

end