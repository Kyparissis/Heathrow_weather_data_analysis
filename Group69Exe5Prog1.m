%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

%% Import Heathrow.xlsx and read appropriate data
% Read Heathrow.xlsx spreadsheet as double matrix (for data)
HeathrowData = 	readmatrix('Heathrow.xlsx');
[HeathrowData_rows, HeathrowData_cols] = size(HeathrowData);

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

for i = 1:9
    for j = (i + 1):9        
        fprintf("  Indicator %d [%s] and Indicator %d [%s]    \n", i, HeathrowINDICATORText(i), j, HeathrowINDICATORText(j));
        fprintf("==========================================\n");
        % Calculate Pearson's correlation coeff and signif. p-value
        X = HeathrowData(:, i + 1);
        Y = HeathrowData(:, j + 1);
        X = X((~isnan(HeathrowData(:, i + 1))) & (~isnan(HeathrowData(:, j + 1))));
        Y = Y((~isnan(HeathrowData(:, i + 1))) & (~isnan(HeathrowData(:, j + 1))));
        [R, p_significance]  = corrcoef(X, Y);
        r = R(1, 2);
        p_significance = p_significance(1, 2);
        fprintf("Pearson's correlation coeff. = %g\n", r);
        fprintf("p-value (H0: r = 0) = %g\n", p_significance);
        
        % Call the function of this subquestion
        [mutualInfoEstimate, p, n] = Group69Exe5Fun1(HeathrowData(:, i + 1), HeathrowData(:, j + 1));
        fprintf("Mutal Information I(X,Y) = %g\n", mutualInfoEstimate);
        fprintf("p-value (Non-parametric test using the randomization method) (H0: I = 0) = %g\n", p);

        fprintf("\n");
    end
end

%%          Conclusions and comments
% ==============================================
%    O syntelestis sysxetisis pearson einai ena metro ths grammikhs
% sysxetisis dyo metavlitwn enw h amoivaia plhroforia einai ena metro
% tou ogkou twn plhroforiwn pou moirazontai dyo metavlhtes. Enw kai ta
% dyo mporoun na xrhsimopoithoun gia thn posotikopoihhsh ths sxeshs
% metaksi dyo metavlitwn, to kanoyn me diaforetikous tropous kai
% epomenws den einai amesa sygkrisimes. O syntelestis sysxetisis pearson
% metra thn isxu kai thn kateuthinsi mias grammikhs sxeshs enw h
% amoivaia plhroforia metra thn meiwsh ths avevaiothtas gia th mia
% metavliti dedomenhs gnwshs ths allhs.
%   Den egine epilogh apo zeygh diktwn poy mporei na exoun mh grammikh
% sysxetisi alla egine elegxos gia ola ta zeugh twn diktwn.
% Genika vlepoume pws exoume periptwseis opou exoume upsili mh grammikh susxetish,
% xwris na exoume grammikh susxetish opws thn periptwsh
% me [RA] kai [FG], alla kai periptwseis me upshlh grammikh susxetish
% px h periptwsh twn [T] kai [TM]