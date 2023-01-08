%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [p1, p2] = Group69Exe3Fun1(years, indicatorSample)
    %% ============== (a') ==============
    % Find discontinued values on the years vector argument
    problematicIndexes = find(diff(years) ~= 1);
    
    % If no such point is found, stop execution and throw an error
    if isempty(problematicIndexes)
        fprintf("ERROR FOUND! Discontinuity couldn't be found the first argument.\n")
        fprintf("Aborting...\n")
        
        p1 = NaN;
        p2 = NaN;
        
        return;
    end
    
%     % Debugging:
%     fprintf("Discontinuity, in the first argument, found firstly between index #%d and index #%d .\n", problematicIndexes(1), problematicIndexes(1) + 1)
%     fprintf("Value at index #%d is %d .\n", (problematicIndexes(1)) , years((problematicIndexes(1))) );
%     fprintf("Value at index #%d is %d .\n", (problematicIndexes(1) + 1) , years(problematicIndexes(1) + 1) );

    %% ============== (b') ==============
    % Splitting the indicatorSample into two vectors based on where discontinuity is first found
    sample_X1 = indicatorSample(1:(problematicIndexes(1)));
    sample_X2 = indicatorSample((problematicIndexes(1) + 1):length(indicatorSample));
    
    % Removing NaNs from the samples
    sample_X1 = sample_X1(~isnan(sample_X1));
    sample_X2 = sample_X2(~isnan(sample_X2));
    
    %% ============== (c') ==============
    %% Parametric (student) hypothesis testing for mean difference
    % (Guided by exercise 3.11)
    sample_X1_mean = mean(sample_X1);
    sample_X1_std = std(sample_X1);
    sample_X1_length = length(sample_X1);
    sample_X2_mean = mean(sample_X2);
    sample_X2_std = std(sample_X2);
    sample_X2_length = length(sample_X2);

    X1_X2_meanDiff = sample_X1_mean - sample_X2_mean;
    X1_X2_pooledVariance = (sample_X1_std^2*(sample_X1_length - 1) + sample_X2_std^2*(sample_X2_length - 1)) / (sample_X1_length + sample_X2_length - 2);
    X1_X2_pooledStd = sqrt(X1_X2_pooledVariance);
    
    % Compute the transformed t-statistic
    t_sample = X1_X2_meanDiff / (X1_X2_pooledStd * sqrt(1/sample_X1_length + 1/sample_X2_length));

    p1 = 2 * (1 - tcdf(abs(t_sample), sample_X1_length + sample_X2_length - 2)); % p-value for two-sided test
%     [~, p1] = ttest2(sample_X1, sample_X2);

    %% Resampling method (bootstrap is chosen) testing for mean difference
    


end