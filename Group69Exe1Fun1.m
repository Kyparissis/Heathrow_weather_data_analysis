%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [p1, p2] = Group69Exe1Fun1(sample) 
    % Calculate the number of unique / distinct values in the sample vector
    % ( Because NaNs are not equal to each other, unique treats them as
    % unique elements, so we also subtract the number of NaNs found )
    numberOfUniqueValues_sample = length(unique(sample)) - sum(isnan(sample));

    if numberOfUniqueValues_sample > 10
        %% ============== (a') ==============
        % Create the histogram for the appropriate equal division
        figure;

        % X^2 goodness-of-fit test that the sample comes from a population with a NORMAL distribution
        [~, p1] = chi2gof(sample);

        % X^2 goodness-of-fit test that the sample comes from a population with a UNIFORM distribution

    else % if numberOfUniqueValues_sample <= 10
        %% ============== (b') ==============
        % Create the bar chart
        figure;
        bar(sample);
        
        % X^2 goodness-of-fit test that the sample comes from a population with a BINOMIAL distribution
        pd = fitdist(sample, 'distname', 'Binomial');
        [~, p1] = chi2gof(sample,'cdf', pd);

        % X^2 goodness-of-fit test that the sample comes from a population with a DISCRETE UNIFORM distribution
    end
end