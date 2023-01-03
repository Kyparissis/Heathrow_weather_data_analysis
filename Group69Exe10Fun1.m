function [OptimalModel, LASSO_PenaltyFactor] = Group69Exe10Fun1(dependedVariableSample, independedVariableSamples)
    %% ============== (a') ==============
    rowsWithNaN = any(isnan(dependedVariableSample), 2) | any(isnan(independedVariableSamples), 2);
    dependedVariableSample(rowsWithNaN, :) = [];
    independedVariableSamples(rowsWithNaN, :) = [];

    %% ============== (b') ==============


    %% ============== (c') ==============


    %% ============== (d') ==============


end