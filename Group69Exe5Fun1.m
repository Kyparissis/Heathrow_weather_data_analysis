function [mutualInfoEstimate, p, length1, length2] = Group69Exe5Fun1(sample1, sample2)
    %% ============== (a') ==============
    % Find the "empty" (NaN) values in the given samples and removing the value pairs,
    % so that the samples no longer have "empty" values.
    indexes = (~isnan(sample1)) & (~isnan(sample2));
    sample1 = sample1(indexes);
    sample2 = sample2(indexes);

    %% ============== (b') ==============
    sample1_mean = mean(sample1);
    sample2_mean = mean(sample2);
    sample1_discrimination = double(find(sample1 >= sample1_mean))
    sample2_discrimination = double(find(sample2 >= sample2_mean))
%     mutualInfoEstimate

    %% ============== (c') ==============


    %% ============== (d') ==============


end