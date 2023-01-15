%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [p1, p2, isContinuous] = Group69Exe1Fun1(sample)  
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
        

        subtitle(sprintf("(Number of distinct values > 10)\nHISTOGRAM\np_{1_{Normal}} = %f and p_{2_{Contin. Unif.}} = %f", p1, p2));
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
        [NumOfAppearances, DistinctVals] = groupcounts(sample);
        bins = 0:max(sample);
        ObservedFreq = zeros(1, length(bins));
        for i = 1:length(DistinctVals)
            ObservedFreq(DistinctVals(i) + 1) = NumOfAppearances(i);
        end
        NTrials = length(sample);
        p = mle(sample, 'distribution', 'Binomial', 'NTrials', NTrials);
        ExpectedFreq = NTrials*(binopdf(bins, NTrials, p));
        
        [~, p1] = chi2gof(bins, 'Frequency', ObservedFreq, 'Expected', ExpectedFreq);

        %% X^2 goodness-of-fit test that the sample comes from a population with a DISCRETE UNIFORM distribution
        [NumOfAppearances, DistinctVals] = groupcounts(sample);
        bins = 0:max(sample);
        ObservedFreq = zeros(1, length(bins));
        for i = 1:length(DistinctVals)
            ObservedFreq(DistinctVals(i) + 1) = NumOfAppearances(i);
        end
        NTrials = length(sample);
        n = mle(sample, 'distribution', 'Discrete Uniform');
        ExpectedFreq = NTrials*(unidpdf(bins, n));
        
        [~, p2] = chi2gof(bins, 'Frequency', ObservedFreq, 'Expected', ExpectedFreq);

        subtitle(sprintf("(Number of distinct values <= 10)\nBAR GRAPH\np_{1_{Binomial}} = %f and p_{2_{Disc. Unif.}} = %f", p1, p2));
    end

end