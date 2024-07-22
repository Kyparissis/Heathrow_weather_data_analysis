% This function computes the 95% parametric and bootstrap confidence intervals for the mean value of a sample.
% INPUTS: 
% sample: A vector of the sample.
% OUTPUTS:
% parametricCI: The 95% parametric confidence interval for the mean value.
% bstrpCI: The 95% bootstrap confidence interval for the mean value.
function [parametricCI, bstrpCI] = computeConfidenceIntervals(sample)
    %% Sample must be a vector
    if ~isvector(sample)
        error("ERROR FOUND! Sample must be a vector. Aborting...");
    end
    
    %% Sample must be a column vector
    if ~iscolumn(sample)
        sample = sample';
    end

    % Remove NaNs from the sample
    sample = sample(~isnan(sample));
    n = length(sample);

    %% 95% parametric confidence interval for the mean value
    alpha = 0.05;   % Significance level (100 × (1 – alpha)% confidence interval = 95% <=> alpha = 5% = 0.05)
    [~, ~, parametricCI] = ttest(sample, [], 'Alpha', alpha);
    
    %% 95% bootstrap confidence interval for the mean value
    alpha = 0.05;   % Significance level (100 × (1 – alpha)% confidence interval = 95% <=> alpha = 5% = 0.05)
    numOfBootstrapSamples = 1000;

    bstrpCI_lowerLimit = floor((numOfBootstrapSamples + 1)*alpha/2);
    bstrpCI_upperLimit = numOfBootstrapSamples + 1 - bstrpCI_lowerLimit;

    bootstrapped_means = NaN(numOfBootstrapSamples, 1);
    for i = 1:numOfBootstrapSamples
        bootstrapIndexes = unidrnd(n, n, 1);
        bootstrapped_sample = sample(bootstrapIndexes);
        bootstrapped_means(i) = mean(bootstrapped_sample);
    end

    % Sort the bootstrapped means in ascending order
    bootstrapped_means = sort(bootstrapped_means);
    
    bstrpCI(1) = bootstrapped_means(bstrpCI_lowerLimit);
    bstrpCI(2) = bootstrapped_means(bstrpCI_upperLimit);
end