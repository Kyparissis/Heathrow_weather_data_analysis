%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [paramFisherCI, bstrpCI, p1, p2, n] = Group69Exe4Fun1(sample1, sample2)
    %% Both samples must be vectors
    if ~(isvector(sample1) & isvector(sample2))
        error("ERROR FOUND! Two samples must be vectors.\nAborting...\n");
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
        error("ERROR FOUND! Two sample vectors must have the same length.\nAborting...\n");
    end

    %% ============== (a') ==============
    % Find the "empty" (NaN) values in the given samples and removing the value pairs,
    % so that the samples no longer have "empty" values.
    indexes = (~isnan(sample1)) & (~isnan(sample2));
    sample1 = sample1(indexes);
    sample2 = sample2(indexes);
    n = length(sample1); % == length(sample2)

    R = corrcoef(sample1, sample2);
    r = R(1, 2);

    %% ============== (b') ==============
    %% Calculate the correlation coeff. (r) 95% confidence interval using the Fisher Transform
    alpha = 0.05;   % Significance level (100 × (1 – alpha)% confidence interval = 95% <=> alpha = 5% = 0.05)

    z = atanh(r); % == 0.5*log((1 + r)/(1 - r));
    
    t_crit = norminv(1 - alpha/2);
    se = sqrt(1/(n - 3)); % Standard error of transformed correlation coefficient

    zeta(1) = z - t_crit*se;
    zeta(2) = z + t_crit*se;

    paramFisherCI(1) = tanh(zeta(1));
    paramFisherCI(2) = tanh(zeta(2));

    %% Calculate the correlation coeff. (r) 95% confidence interval using the bootstrap method
    % TODO: Check correctness
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
    %% Hypothesis test for H0: r=0 using the t(Student)-statistic parametric test
    t = r * sqrt((n - 2) / (1 - r^2));   % Compute t-statistic
    p1 = 2 * (1 - tcdf(abs(t), n - 2));  % Compute p-value using t-distribution with n - 2 degrees of freedom

    %% Hypothesis test for H0: r=0 using the randomization method non-parametric test    
    % TODO: Fix this
    numberOfRandSamples = 1000;
    p2 = NaN;
    

end