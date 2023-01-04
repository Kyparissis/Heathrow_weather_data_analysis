%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [p1, p2] = Group69Exe1Fun1(sample) 
    % Calculate the number of unique / distinct values in the sample vector
    sample = sample(~isnan(sample));
    numberOfUniqueValues_sample = length(unique(sample));

    if numberOfUniqueValues_sample > 10
        %% ============== (a') ==============
        % Create the histogram for the appropriate equal division
        figure;
        histogram(sample);
        
        % X^2 goodness-of-fit test that the sample comes from a population with a NORMAL distribution
        [~, p1] = chi2gof(sample);
        
        % X^2 goodness-of-fit test that the sample comes from a population with a UNIFORM distribution
        [~, p2] = chi2gof(sample, 'cdf', {@unifcdf, min(sample), max(sample)});
        
        title(sprintf("HISTOGRAM: p1 = %d p2 = %d", p1, p2));
    else % if numberOfUniqueValues_sample <= 10
        %% ============== (b') ==============
        % Create the bar chart
        figure;
        bar(sample);
        
        % X^2 goodness-of-fit test that the sample comes from a population with a BINOMIAL distribution
        [~, p1] = chi2gof(sample, 'cdf', {@binocdf, length(sample), 1/numberOfUniqueValues_sample}, 'nbins', numberOfUniqueValues_sample);

        % X^2 goodness-of-fit test that the sample comes from a population with a DISCRETE UNIFORM distribution
        [~, p2] = chi2gof(sample, 'cdf', {@unidcdf, max(sample)}, 'nbins', numberOfUniqueValues_sample);

        title(sprintf("BAR: p1 = %d p2 = %d", p1, p2));
    end
end