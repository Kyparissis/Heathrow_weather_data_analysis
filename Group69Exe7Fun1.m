function [TypeOfModel, AdjCoeff] = Group69Exe7Fun1(sample1, sample2)
    %% Two sample vectors must have the same length
    if length(sample1) ~= length(sample2)
        TypeOfModel = NaN;
        AdjCoeff = NaN;

        return;
    end
    
    %% ============== (a') ==============
    % Find the "empty" (NaN) values in the given samples and removing the value pairs,
    % so that the samples no longer have "empty" values.
    indexes = (~isnan(sample1)) & (~isnan(sample2));
    sample1 = sample1(indexes);     % Independed variable
    sample2 = sample2(indexes);     % Depended variable


    %% ============== (b') ==============


    %% ============== (c') ==============


    %% ============== (d') ==============


end