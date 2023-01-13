%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [adjR2, p] = Group69Exe8Fun1(sample1, sample2)
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
    sample1 = sample1(indexesToKeep);
    sample2 = sample2(indexesToKeep);
    n = length(sample1); % == length(sample2)

    %% ============== (b') ==============
    %% 2nd degree regression model using least squares method
    x = [ones(n,1) sample1 sample1.^2];
    Y = sample2;
    [b, ~] = regress(Y, x);

    y = x * b;  % Predicted values
    e = Y - y;  % Error
        
    % Number of non-linear parameters
    numOfVariables = 2;
    
    adjR2 = 1 - ((n - 1)/(n - (numOfVariables + 1)))*(sum(e.^2))/(sum((sample2 - mean(sample2)).^2));

    %% ============== (c') ==============
    %% Randomization test (for adjR2) 
    numOfRandomizations = 2000;
    
    adjR2_rand = nan(1, numOfRandomizations);

    for j = 1:numOfRandomizations
        sample1_rand = sample1;
        sample2_rand = sample2(randperm(n));
        x = [ones(n,1) sample1_rand sample1_rand.^2];
        Y = sample2_rand;

        b_rand = regress(Y, x);

        y = x * b_rand;  % Predicted values
        e_rand = Y - y;  % Error
    
        numOfVariables = 2;
    
        adjR2_rand(j) = 1 - ((n - 1)/(n - (numOfVariables + 1)))*(sum(e_rand.^2))/(sum((sample2 - mean(sample2)).^2));
    end

    % Calculate p-value
    % p-value represents the probability of observing a correlation coefficient as extreme or more extreme
    % than the one observed in the original data, given that the null hypothesis (H0: r = 0) is true.
    p = sum(adjR2_rand >= adjR2) / numOfRandomizations;


end

% Could also use:
%     lmObj = fitlm(sample1, Y, 'poly2'); 
%     lmObj.Rsquared.Adjusted;
%     lmObj.ModelFitVsNullModel.Pvalue % F-statistic