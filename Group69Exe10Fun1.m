%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

function [OptimalModel, LASSO_PenaltyFactor] = Group69Exe10Fun1(dependedVariableSample, independedVariableSamples)
    %% ============== (a') ==============
    rowsWithNaN = any(isnan(dependedVariableSample), 2) | any(isnan(independedVariableSamples), 2);
    dependedVariableSample(rowsWithNaN, :) = [];
    independedVariableSamples(rowsWithNaN, :) = [];

    %% ============== (b') ==============


    %% ============== (c') ==============


    %% ============== (d') ==============


end