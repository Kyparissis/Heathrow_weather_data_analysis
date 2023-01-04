%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [paramFisherCI, bstrpCI, p1, p2, n] = Group69Exe4Fun1(sample1, sample2)
    %% Two sample vectors must have the same length
    if length(sample1) ~= length(sample2)
        fprintf("ERROR! Two sample vectors must have the same length.\n");
        paramFisherCI = [NaN NaN];
        bstrpCI = [NaN NaN];
        p1 = NaN;
        p2 = NaN;
        n = NaN;

        return;
    end

    %% ============== (a') ==============
    % Find the "empty" (NaN) values in the given samples and removing the value pairs,
    % so that the samples no longer have "empty" values.
    indexes = (~isnan(sample1)) & (~isnan(sample2));
    sample1 = sample1(indexes);
    sample2 = sample2(indexes);
    n = length(sample1); % == length(sample2)

    %% ============== (b') ==============
    % Calculate the corr (r) 95% confidence interval using the Fisher Transform
    R = corrcoef(sample1, sample2);
    r = R(1, 2);
    
    z = atanh(r); % == 0.5*log((1 + r)/(1 - r));
    
    alpha = 0.05;   % Significance level (100 × (1 – alpha)% confidence interval = 95% <=> alpha = 5% = 0.05)
    t_crit = norminv(1 - alpha/2);
    se = sqrt(1/(n - 3)); % Standard error of transformed correlation coefficient

    zeta(1) = z - t_crit*se;
    zeta(2) = z + t_crit*se;

    paramFisherCI(1) = tanh(zeta(1));
    paramFisherCI(2) = tanh(zeta(2));

    % Calculate the corr (r) 95% confidence interval using the bootstrap method
    alpha = 0.05;   % Significance level (100 × (1 – alpha)% confidence interval = 95% <=> alpha = 5% = 0.05)
    numOfBootstrapSamples = 1000;

    bstrpCI_lowerLimit = floor((numOfBootstrapSamples + 1)*alpha/2);
    bstrpCI_upperLimit = numOfBootstrapSamples + 1 - bstrpCI_lowerLimit;
    
    r_bootstrapped = NaN(numOfBootstrapSamples, 1);
    for i = 1:numOfBootstrapSamples
        bootstrapIndex = unidrnd(n, n, 1);
        sample1_resampled = sample1(bootstrapIndex);
        sample2_resampled = sample2(bootstrapIndex);

        % Compute correlation coefficient of resampled data
        R_bootstrapped_tmp = corrcoef(sample1_resampled, sample2_resampled);
        r_bootstrapped(i) = R_bootstrapped_tmp(1, 2);
    end

    % Sort the bootstrapped r in ascending order
    r_bootstrapped = sort(r_bootstrapped);
    
    bstrpCI(1) = r_bootstrapped(bstrpCI_lowerLimit);
    bstrpCI(2) = r_bootstrapped(bstrpCI_upperLimit);

    %% ============== (c') ==============
    % Hypothesis test for H0: r=0 using the t(Student)-statistic parametric test
    t = r * sqrt((n - 2) / (1 - r^2));   % Compute t-statistic
    p1 = 2 * (1 - tcdf(abs(t), n - 2));  % Compute p-value using t-distribution with n-2 degrees of freedom

    % Hypothesis test for H0: r=0 using the randomization method non-parametric test    
    numOfRandomizations = 1000;

    r_rand = zeros(numOfRandomizations, 1);    
    % Generate randomization samples
    for i = 1:numOfRandomizations
        % Generate a random permutation of sample1
        sample1_rand = sample1(randperm(n));

        % Compute correlation coefficient for randomization sample
        R_rand_tmp = corrcoef(sample1_rand, sample2);
        r_rand(i) = R_rand_tmp(1, 2);
    end

    % Compute p-value as the fraction of randomizations with a test statistic
    % greater than or equal to the observed test statistic
    p2 = sum(r_rand >= r_obs) / numOfRandomizations;
end