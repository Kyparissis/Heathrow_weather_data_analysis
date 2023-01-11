%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

rng(4); % Set rng for reproducibility

%% Import Heathrow.xlsx and read appropriate data
% Read Heathrow.xlsx spreadsheet as double matrix (for data)
HeathrowData = 	readmatrix('Heathrow.xlsx');
[HeathrowData_rows, HeathrowData_cols] = size(HeathrowData);

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

alpha = 0.05; % Significance level

pairID = 0;                     % Holds an ID for every pair we are gonna test
% pairID2Indicators = nan(36, 2); % i-th line is the pair's ID, (i,1) and (i,2) are the 2 indicators of the pair

for i = 1:9
    for j = (i + 1):9
        pairID = pairID + 1;
        
        [paramFisherCI, bstrpCI, p1(pairID), p2(pairID), n] = Group69Exe4Fun1(HeathrowData(:, i + 1), HeathrowData(:, j + 1));
        
        fprintf("  Indicator %d (%s) and Indicator %d (%s) [Pair #%d]   \n", i, HeathrowINDICATORText(i), j, HeathrowINDICATORText(j), pairID);
        fprintf("=====================================================\n");
        fprintf("Fisher transform confidence interval: [%e %e]\n", paramFisherCI(1), paramFisherCI(2))
        fprintf("Bootstrap confidence interval: [%e %e]\n", bstrpCI(1), bstrpCI(2))
        fprintf("p-value (H0: r == 0) from the parametric (student) test = %e \n", p1(pairID));
        fprintf("p-value (H0: r == 0) from the randomization method non-parametric test = %e \n", p2(pairID));
        
        % Cheking if r = 0 exists in fisher transf. confidence interval
        if ~(paramFisherCI(1) <= 0 && 0 <= paramFisherCI(2))
            fprintf("--> r == 0 is NOT in Fisher Confidence Interval\n")
        end
        % Cheking if r = 0 exists in bootstrap confidence interval
        if ~(bstrpCI(1) <= 0 && 0 <= bstrpCI(2))
            fprintf("--> r == 0 is NOT in bootstrap Confidence Interval\n")
        end
        % Cheking for rejection of H0: r=0 according to parametric p-value
        if p1(pairID) < alpha
            fprintf("--> p(parametric) < %.2f <=> Rejection of H0: r == 0 at this signif. level.\n", alpha)
        end
        % Cheking for rejection of H0: r=0 according to non-parametric p-value
        if p2(pairID) < alpha
            fprintf("--> p(non-parametric) < %.2f <=> Rejection of H0: r == 0 at this signif. level.\n", alpha)
        end

        fprintf("\n");

        % Updating the pointer matrixes
%         Indicators2pairID(i, j) = pairID;
%         Indicators2pairID(j, i) = pairID;
%         pairID2Indicators(pairID, :) = [i, j];
    end
end

fprintf("\n  Pairs with statistically most significant correlation\n");
fprintf("---------------------------------------------------------\n");
% Find 3 smallest p1 values
[p1s, pairsWithSmallest_p1] = mink(p1, 3);
fprintf("=> The 3 pairs with the smallest p(parametric) value are pairs: #%d #%d and #%d\n", pairsWithSmallest_p1(1), pairsWithSmallest_p1(2), pairsWithSmallest_p1(3));

% Find 3 smallest p2 values
[p2s, pairsWithSmallest_p2] = mink(p2, 3);
fprintf("=> The 3 pairs with the smallest p(non-parametric) value are pairs: #%d #%d and #%d\n", pairsWithSmallest_p2(1), pairsWithSmallest_p2(2), pairsWithSmallest_p2(3));
% % Check if the two tests agree by comparing the vectors that hold the pairIDs
% if isequal(pairsWithSmallest_p1, pairsWithSmallest_p2)
%     fprintf("====> The two tests agree!\n")
% end

% ...
% ...
% Twra tha apanthsoume sto erwthma an symfwnoun oi 4 proseggiseis.
% Apo to console output vlepoume pws oi 4 prossegiseis kata pliopsifia
% symfwnoyn metaksi tous, dhladh an aporriptoun to H0, tha to kanoun kai oi
% 4 mazi.
% Twra tha dhlwsoume ta 3 zeugh me thn statistika shmantiki sisxetisi me
% vash tous 2 elegxous (parametriko kai tyxaiopoihshs).
% Ta zeugh einai auta me ta 3 mikrotera p values, dhladh exoyn thn
% mikroterh pithanothta na exoun r=0(mhdenikh sysxetisi)
% Ta zeugh auta einai: