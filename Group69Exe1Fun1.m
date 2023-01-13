%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [p1, p2, isContinuous] = Group69Exe1Fun1(sample)     
    sample = sample(~isnan(sample)); % Remove NaNs from sample
    n = length(sample);

    % Calculate the number of unique / distinct values in the sample vector    
    numberOfUniqueValues_sample = length(unique(sample));

    if numberOfUniqueValues_sample > 10
        isContinuous = 1; % It is treated as a continuous variable
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
        edges = linspace(a, b, nbins + 1); % edges of the bins
        Expected = n/nbins*ones(nbins,1); % expected value (equal for uniform dist)

        [~,p2] = chi2gof(sample, 'Expected', Expected, 'Edges', edges);
        
        subtitle(sprintf("(Num. of distinct values > 10) HISTOGRAM\np_{1_{Normal}} = %e | p_{2_{Contin. Unif.}} = %e", p1, p2));
        xlabel("Bins");
        ylabel("Number of appearances");
    else % if numberOfUniqueValues_sample <= 10
        isContinuous = 0; % It is treated as a discrete variable
        %% ============== (b') ==============
        % Create the bar chart
        figure;
        bar(sample);

        p = sum(sample)/n;

        % Perform the chi square goodness of fit test
        [h,p1] = chi2gof(sample,'Ctrs',1:9,'Frequency',n,'Expected',n*p);
        
        %% X^2 goodness-of-fit test that the sample comes from a population with a BINOMIAL distribution
        % false
        

        %% X^2 goodness-of-fit test that the sample comes from a population with a DISCRETE UNIFORM distribution
        p2 = NaN;
        
        subtitle(sprintf("(Num. of distinct values <= 10) BAR GRAPH\np_{1_{Binomial}} = %e | p_{2_{Disc. Unif.}} = %e", p1, p2));
    end

end