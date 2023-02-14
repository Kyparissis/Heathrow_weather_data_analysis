%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [OptimalModel_bin, OptimalModel_lambda] = Group69Exe10Fun1(dependedVariable, independedVariables)
    %% Depended variable sample must be vector
    if ~(isvector(dependedVariable))
        error("ERROR FOUND! Depended variable sample must be vector. Aborting...");
    end

    %% Independed variables sample must be matrix
    if ~(ismatrix(independedVariables))
        error("ERROR FOUND! Independed variable sample must be a matrix. Aborting...");
    end
    
    %% Make depended variable sample column vector
    if ~iscolumn(dependedVariable)
        dependedVariable = dependedVariable';
    end

    %% Two inputs must have the same number of rows
    if length(dependedVariable) ~= size(independedVariables, 1)
        error("ERROR FOUND! Two inputs must have the same number of rows. Aborting...");
    end
    
    %% ============== (a') ==============
    % Find all the NaN values and remove the corresponding pair values
    % so that the two vectors don't have empty values.
    rowsWithNaN = any(isnan(dependedVariable), 2) | any(isnan(independedVariables), 2);
    dependedVariable(rowsWithNaN, :) = [];
    independedVariables(rowsWithNaN, :) = [];
    
    %% ============== (b') ==============
    numIndependedVariables = size(independedVariables, 2); % number of independent variables
    n = size(independedVariables, 1);                      % number of rows
    
    numModels = 2^numIndependedVariables; % number of possible models
    adjR2 = zeros(numModels, 1);
    % Loop through all possible models
    for i = 1:numModels
        % Convert i to binary representation to determine which variables to include in this model
        bin = double(int2bit((i - 1), numIndependedVariables))';
        
        % Initialize X subset
        x = [ones(n, 1) independedVariables(:, logical(bin))];
        
        % Calculate linear regression parameters
        b = regress(dependedVariable, x);
        
        y = x * b;                 % Predicted values
        e = dependedVariable - y;  % Error
        
        % Calculate number of non-linear parameters
        p = sum(bin);
        
        % Calculate the adjR2 value
        adjR2(i) = 1 - ((n - 1)/(n - (p + 1)))*(sum(e.^2))/(sum((dependedVariable - mean(dependedVariable)).^2));
    end

    % Optimal model is the one with the maximum adjR2
    [~, OptimalModel_dec] = max(adjR2);
    
    % Returning the optimal model as  a logical vector with length equal to the number of columns in independedVariableSamples, indicating which terms are in the final model.
    OptimalModel_bin = double(int2bit((OptimalModel_dec - 1), numIndependedVariables))';

    %% ============== (c') ==============
    % Centering the data
    % It makes sure that the LASSO method is not affected by the scale of the independent variables
    X = independedVariables - repmat(mean(independedVariables), n, 1);
    Y = dependedVariable - mean(dependedVariable);

    % fit Lasso model
    [B, FitInfo] = lasso(X, Y);
    
    ind = zeros(1, size(B, 2));
    for i = 1:size(B, 2)
        if transpose(OptimalModel_bin) == (double(logical(B(:, i))))
            ind(i) = 1;
        end
    end

    if sum(ind) == 0
        OptimalModel_lambda = [];
    else
        OptimalModel_lambda = FitInfo.Lambda(logical(ind)); % Find all lambda values than can make the optimal model
        OptimalModel_smallestMSE = FitInfo.MSE(logical(ind)); % Find the MSE for all those lambda values
        [~, indOfSmallestMSEofLambda] = min(OptimalModel_smallestMSE); % Find the index of min MSE
        OptimalModel_lambda = OptimalModel_lambda(indOfSmallestMSEofLambda); % Keep lambda that gives the minimum MSE
    end

end