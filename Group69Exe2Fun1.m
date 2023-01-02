function [ci1, ci2] = Group69Exe2Fun1(SampleObservations)
    SampleObservations = SampleObservations(~isnan(SampleObservations));

    % 95% parametric confidence interval for the mean value
    alpha = 0.05;   % Significance level (100 × (1 – alpha)% confidence interval = 95% <=> alpha = 5% = 0.05)
    [~, ~, ci1] = ttest(SampleObservations, [], 'Alpha', alpha);
    
    % TODO: Check if this is correct. Maybe percentile bootstrap method
    % needed?? Check exe. 3.7
    % 95% bootstrap confidence interval for the mean value
    alpha = 0.05;   % Significance level (100 × (1 – alpha)% confidence interval = 95% <=> alpha = 5% = 0.05)
    B = 1000;       % number of bootstrap samples
    ci2 = bootci(B, @mean, SampleObservations);
end