% This function calculates the p-values for the goodness-of-fit tests that the sample comes from a population with a specific distribution.
% The function returns the p-values for the following tests:
% 1. X^2 goodness-of-fit test that the sample comes from a population with a NORMAL distribution.
% 2. X^2 goodness-of-fit test that the sample comes from a population with a UNIFORM distribution.
% 3. X^2 goodness-of-fit test that the sample comes from a population with a BINOMIAL distribution.
% 4. X^2 goodness-of-fit test that the sample comes from a population with a DISCRETE UNIFORM distribution.
% The function also returns a flag that indicates if the sample is treated as a continuous or a discrete variable.
% INPUTS:
% sample: A vector of the sample.
% OUTPUTS:
% p1: The p-value for the X^2 goodness-of-fit test that the sample comes from a population with a NORMAL/BINOMIAL distribution.
% p2: The p-value for the X^2 goodness-of-fit test that the sample comes from a population with a UNIFORM/DISCRETE UNIFORM distribution.
% isContinuous: A flag that indicates if the sample is treated as a continuous (1) or a discrete (0) variable.
function [p1, p2, isContinuous] = distributionChiSquaredTests(sample)  
    %% Sample must be a vector
    if ~isvector(sample)
        error("ERROR FOUND! Sample must be a vector. Aborting...");
    end
    
    %% Sample must be a column vector
    if ~iscolumn(sample)
        sample = sample';
    end
    
    % Remove NaNs from sample
    sample = sample(~isnan(sample)); 
    n = length(sample);

    % Calculate the number of unique / distinct values in the sample vector    
    numberOfUniqueValues = length(unique(sample));

    if numberOfUniqueValues > 10
        isContinuous = 1; % It is treated as a continuous variable
        %% ============== (a') ==============
        % Create the histogram for the appropriate equal division
        figure;
        histObj = histogram(sample, 'FaceColor', "#0072BD");
        xlabel("Bins");
        ylabel("Number of appearances");
        
        %% X^2 goodness-of-fit test that the sample comes from a population with a NORMAL distribution
        [~, p1] = chi2gof(sample);
        
        %% X^2 goodness-of-fit test that the sample comes from a population with a UNIFORM distribution
        params = mle(sample, 'distribution', 'Uniform'); % Maximum likelihood estimates
        a = params(1); % lower endpoint (minimum)
        b = params(2); % upper endpoint (maximum)
        nbins = histObj.NumBins; % number of bins
        edges = linspace(a, b, nbins + 1); % edges of the bins
        Expected = n/nbins*ones(nbins,1); % expected value (equal for uniform dist)

        [~, p2] = chi2gof(sample, 'Expected', Expected, 'Edges', edges);
        
        subtitle(sprintf("(Number of distinct values > 10)\nHISTOGRAM\np_{1_{Normal}} = %g and p_{2_{Contin. Unif.}} = %g", p1, p2));
    else % if numberOfUniqueValues_sample <= 10
        isContinuous = 0; % It is treated as a discrete variable
        %% ============== (b') ==============
        % Create the bar chart
        figure;
        [NumOfAppearances, DistinctVals] = groupcounts(sample);
        bar(DistinctVals, NumOfAppearances, 'FaceColor', "#EDB120");
        xlabel("Sample's distinct/unique values");
        ylabel("Number of appearances");
        
        %% X^2 goodness-of-fit test that the sample comes from a population with a BINOMIAL distribution
        bins = 0:max(sample);
        ObservedFreq = histcounts(sample, 0:(max(sample) + 1));
        p = mle(sample, 'distribution', 'Binomial', 'NTrials', n);
        ExpectedFreq = n*(binopdf(bins, n, p));
        
        % For discrete distr. c = 1 so we want df = length(bins) - 1
        [~, p1] = chi2gof(bins, 'Ctrs', bins, 'Frequency', ObservedFreq, 'Expected', ExpectedFreq, 'NParams', 0); 
        
        %% X^2 goodness-of-fit test that the sample comes from a population with a DISCRETE UNIFORM distribution
        ExpectedFreq = n*((1 / length(bins))*ones(1, length(bins)));
        
        [~, p2] = chi2gof(bins, 'Ctrs', bins, 'Frequency', ObservedFreq, 'Expected', ExpectedFreq, 'NParams', 0);
       
        
        subtitle(sprintf("(Number of distinct values <= 10)\nBAR GRAPH\np_{1_{Binomial}} = %g and p_{2_{Disc. Unif.}} = %g", p1, p2));
    end

end