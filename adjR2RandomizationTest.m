% This function calculates the adjusted R2 value and p-value for the given two samples using random permutation test.
% The adjusted R2 value is calculated using the 2nd degree regression model and the least squares method.
% The p-value is calculated using the randomization method.
% INPUTS:
% sample1: A vector of the first sample.
% sample2: A vector of the second sample.
% OUTPUTS:
% adjR2: The adjusted R2 value.
% p: The p-value.
function [adjR2, p] = adjR2RandomizationTest(sample1, sample2)
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
    
    % Calculate the adjusted R2
    adjR2 = 1 - ((n - 1)/(n - (numOfVariables + 1)))*(sum(e.^2))/(sum((sample2 - mean(sample2)).^2));

    %% ============== (c') ==============
    %% Randomization test (for adjR2) 
    numOfRandomizations = 2000;
    
    adjR2_rand = nan(1, numOfRandomizations + 1);

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
    
    adjR2_rand(numOfRandomizations + 1) = adjR2;
    adjR2_rand = sort(adjR2_rand);
    rank = find(adjR2_rand == adjR2);
    % If all the values are identical, select the middle rank
    if length(rank) == numOfRandomizations + 1
        rank = round((numOfRandomizations + 1)/2);
    elseif length(rank) >= 2
        % If at least one bootstrap statistic is identical to the 
        % original, pick the rank of one of them at random
        rank = rank(unidrnd(length(rank)));
    end
    % p-value represents the probability of observing a correlation coefficient as extreme or more extreme
    % than the one observed in the original data, given that the null hypothesis (H0: r = 0) is true.
    if rank > 0.5*(numOfRandomizations + 1)
        p = 2*(1 - rank/(numOfRandomizations + 1));
    else
        p = 2*rank/(numOfRandomizations + 1);
    end

end

% Could also use:
%     lmObj = fitlm(sample1, Y, 'poly2'); 
%     lmObj.Rsquared.Adjusted;
%     lmObj.ModelFitVsNullModel.Pvalue % F-statistic