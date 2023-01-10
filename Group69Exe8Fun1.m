%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [adjR2, p] = Group69Exe8Fun1(sample1, sample2)
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
    n = length(sample1);


    %% ============== (b') ==============
    %% 2nd degree regression model using least squares method
    degree = 2;
    x = [ones(n,1) sample1 sample1.^2];
    Y = sample2;
    [b, ~] = regress(Y, x);

    y = x * b;  % Predicted values
    e = Y - y;  % Error
    
    adjR2 = 1 - ((n - 1)/(n - (degree + 1)))*(sum(e.^2))/(sum((sample2 - mean(sample2)).^2));

    %% ============== (c') ==============
    %% Randomization test (for adjR2) 


    p = NaN;


end