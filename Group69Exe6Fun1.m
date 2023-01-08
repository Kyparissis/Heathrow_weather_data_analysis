function [coeffDet] = Group69Exe6Fun1(sample1, sample2)
    %% Two sample vectors must have the same length
    if length(sample1) ~= length(sample2)
        fprintf("ERROR FOUND! Two sample vectors must have the same length.\n");
        fprintf("Aborting...\n")
        coeffDet = NaN;

        return;
    end

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