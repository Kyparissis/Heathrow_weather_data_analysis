function [AdjCoeff, p] = Group69Exe8Fun1(sample1, sample2)
    %% ============== (a') ==============
    % Find the "empty" (NaN) values in the given samples and removing the value pairs,
    % so that the samples no longer have "empty" values.
    indexes = (~isnan(sample1)) & (~isnan(sample2));
    sample1 = sample1(indexes);
    sample2 = sample2(indexes);


    %% ============== (b') ==============


    %% ============== (c') ==============


    %% ============== (d') ==============


end