%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [p1, p2] = Group69Exe1Fun1(sample)     
    sample = sample(~isnan(sample)); % Remove NaNs from sample

    % Calculate the number of unique / distinct values in the sample vector    
    numberOfUniqueValues_sample = length(unique(sample));

    if numberOfUniqueValues_sample > 10
        %% ============== (a') ==============
        % Create the histogram for the appropriate equal division
        figure;
        histObj = histogram(sample);
        
        %% X^2 goodness-of-fit test that the sample comes from a population with a NORMAL distribution
        % Might be correct
        [~, p1] = chi2gof(sample);
        
        %% X^2 goodness-of-fit test that the sample comes from a population with a UNIFORM distribution
        % Might be correct
        params = mle(sample, 'distribution', 'Uniform'); % Maximum likelihood estimates
        a = params(1); % lower endpoint (minimum)
        b = params(2); % upper endpoint (maximum)
        nbins = histObj.NumBins; % number of bins
        edges = linspace(a,b,nbins+1); % edges of the bins
        Expected = length(sample)/nbins*ones(nbins,1); % expected value (equal for uniform dist)

        [~,p2] = chi2gof(sample, 'Expected', Expected, 'Edges', edges);
        
        title(sprintf("HISTOGRAM"));
    else % if numberOfUniqueValues_sample <= 10
        %% ============== (b') ==============
        % Create the bar chart
        figure;
        bar(sample);
        
        %% X^2 goodness-of-fit test that the sample comes from a population with a BINOMIAL distribution
        % false
%         p = mle(sample, 'distribution', 'Binomial', 'NTrials', length(sample));
%         [~, p1] = chi2gof(sample, 'CDF', {@binocdf, length(sample), p});

        %% X^2 goodness-of-fit test that the sample comes from a population with a DISCRETE UNIFORM distribution
%         %false
%         % Calculate the expected number of occurrences of each value
%         Expected = length(sample) / numberOfUniqueValues_sample;
% 
%         % Calculate the chi-squared statistic
%         chi2 = sum((histcounts(sample) - Expected).^2 / Expected);
% 
%         % Calculate the degrees of freedom
%         df = numberOfUniqueValues_sample - 1;
% 
%         % Calculate the p-value
%         p2 = 1 - chi2cdf(chi2, df);

        title(sprintf("BAR"));
    end
    
    subtitle(sprintf("p_1 = %d | p_2 = %d", p1, p2));
    
end