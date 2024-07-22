% This script finds the pairs of indicators that have a significant correlation.

clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

rng(4); % Set rng for reproducibility

%% Import Heathrow.xlsx and read appropriate data
% Read Heathrow.xlsx spreadsheet as double matrix (for data)
HeathrowData = readmatrix('Heathrow.xlsx');
[HeathrowData_rows, HeathrowData_cols] = size(HeathrowData);

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

alpha = 0.05; % Significance level

pairID = 0;  % Holds an ID for every pair we are gonna test
paramFisherCI = nan(36, 2);
bstrpCI = nan(36, 2);
p_param = nan(1, 36);
p_nonParam = nan(1, 36);
isLinearCorr_FisherCI = zeros(1, 36);
isLinearCorr_bootCI = zeros(1, 36);
isLinearCorr_param_p = zeros(1, 36);
isLinearCorr_nonParam_p = zeros(1, 36);
for i = 1:9
    for j = (i + 1):9
        pairID = pairID + 1;
        
        [paramFisherCI(pairID, :), bstrpCI(pairID, :), p_param(pairID), p_nonParam(pairID), n] = getParametricCorrelation(HeathrowData(:, i + 1), HeathrowData(:, j + 1));
        
        fprintf("  Indicator %d [%s] and Indicator %d [%s] - [Pair #%d]   \n", i, HeathrowINDICATORText(i), j, HeathrowINDICATORText(j), pairID);
        fprintf("=======================================================\n");
        fprintf("Fisher transform confidence interval: [%g , %g]\n", paramFisherCI(pairID, 1), paramFisherCI(pairID, 2))
        fprintf("Bootstrap confidence interval: [%g , %g]\n", bstrpCI(pairID, 1), bstrpCI(pairID, 2))
        fprintf("p-value (H0: r == 0) from the parametric (student) test = %g \n", p_param(pairID));
        fprintf("p-value (H0: r == 0) from the randomization method non-parametric test = %g \n", p_nonParam(pairID));
        
        % Cheking if r = 0 exists in fisher transf. confidence interval
        if ~(paramFisherCI(pairID, 1) <= 0 && 0 <= paramFisherCI(pairID, 2))
            isLinearCorr_FisherCI(pairID) = 1;
        end
        % Cheking if r = 0 exists in bootstrap confidence interval
        if ~(bstrpCI(pairID, 1) <= 0 && 0 <= bstrpCI(pairID, 2))
            isLinearCorr_bootCI(pairID) = 1;
        end
        % Cheking for rejection of H0: r=0 according to parametric p-value
        if p_param(pairID) < alpha
            isLinearCorr_param_p(pairID) = 1;
        end
        % Cheking for rejection of H0: r=0 according to non-parametric p-value
        if p_nonParam(pairID) < alpha
            isLinearCorr_nonParam_p(pairID) = 1;
        end

        fprintf("\n");
    end
end

fprintf("\n  Pairs with correlation\n");
fprintf("--------------------------\n");
fprintf("[According to Fisher transform confidence interval]\n")
disp(find(isLinearCorr_FisherCI == 1));
fprintf("[According to bootstrap confidence interval]\n")
disp(find(isLinearCorr_bootCI == 1));
fprintf("[According to parametric p-value]\n")
disp(find(isLinearCorr_param_p == 1));
fprintf("[According to non-parametric p-value]\n")
disp(find(isLinearCorr_nonParam_p == 1));

fprintf("\n  Pairs with statistically most significant correlation\n");
fprintf("---------------------------------------------------------\n");
% Find 3 smallest p1 values
[p1s, pairsWithSmallest_p1] = mink(p_param, 3);
fprintf("=> The 3 pairs with the smallest p(parametric) value are pairs:");
disp(pairsWithSmallest_p1)
% Find 3 smallest p2 values
[p2s, pairsWithSmallest_p2] = mink(p_nonParam, 3);
fprintf("=> The 3 pairs with the smallest p(non-parametric) value are pairs:");
disp(pairsWithSmallest_p2)


%%          Conclusions and comments
% ==============================================
%   Sthn konsola fainetai o orismos toy kathe zeugous me enan auksonta arithmo.
%   Gia na vroume poia zeugh deiktwn exoun grammiki sysxetisi symfwna me to
%  parametriko h kai bootstrap diasthmata empistosinis, tha vroume se poia
%  apo auta ta diasthmata den anhkei h timh 0. Sthn konsola ektiponontai ta
%  zeugh auta.
%   Gia na vroume poia zeugh deiktwn exoun grammikh sysxetisi symfwna me
%  tous parametrikous kai elegxous tyxaiopoihshs, tha elegksoume poies
%  times p einai mikroteres apo to epipedo shmantikothtas alpha etsi wste
%  na mporesoume na aporipsoume to null hypothesis gia r = 0 (mhdenikh
%  sysxetisi). Sthn konsola ektiponontai ta zeugh auta.
%    Parathroume oti oi 4 elegxoi symfwnoyn kata pleiopsifia. H parametriki
%  timh toy p kai to fisher transform confidence interval symfwnoun
%  apolytws metaksi tous enw oi alloi 2 elegxoi tyxaiopoihshs/bootstrap
%  fainetai na symfwnoyn me 2 mikres diafores. Auto mporei na ofiletai
%  ston mikro arithmo bootstrap samples poy dhmiourghsame h kai sto mikro
%  arithmo randomizations poy kaname me apotelesma na vgazoume oriaka 
%  diaforetikes times.
%    Ta tria zeygh symfwna me ton parametriko kai elegxo tyxaiopoihshs
%  einai ta zeygh 1,6,13 kai fainetai oi 2 elegxoi na symfwnoyn apolyta
%  edw.
%  Aksizei na shmeiwthei edw oti egine xrhsh tou rng() gia
%  apanalipsimothta.