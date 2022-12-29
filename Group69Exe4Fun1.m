function [ci1, ci2, p1, p2, length1, length2] = Group69Exe4Fun1(sample1, sample2)
    %% ============== (a') ==============
    % Find the "empty" (NaN) values in the given samples and removing the value pairs,
    % so that the samples no longer have "empty" values.
    indexes = (~isnan(sample1)) & (~isnan(sample2));
    sample1 = sample1(indexes);
    sample2 = sample2(indexes);

    %% ============== (b') ==============
    % Calcuate the 95% 


    %% ============== (c') ==============


    %% ============== (d') ==============




    length1 = length(sample1);
    length2 = length(sample2);
end