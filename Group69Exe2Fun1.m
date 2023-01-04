%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [parametricCI, bstrpCI] = Group69Exe2Fun1(sample)
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