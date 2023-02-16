%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

%% Import Heathrow.xlsx and read appropriate data
% Read Heathrow.xlsx spreadsheet as double matrix (for data)
HeathrowData = readmatrix('Heathrow.xlsx');
[HeathrowData_rows, HeathrowData_cols] = size(HeathrowData);

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

%% Calculate the mean value of every indicator in the period 1949-1958
indexOf1949 = find(HeathrowData(:, 1) == 1949);
indexOf1958 = find(HeathrowData(:, 1) == 1958);
HeathrowData_1949_1958 = HeathrowData(indexOf1949:indexOf1958, :);
HeathrowINDICATORData_1949_1958 = HeathrowData_1949_1958(:, 2:HeathrowData_cols); % Removing years column

HeathrowINDICATORData_1949_1958_mean = mean(HeathrowINDICATORData_1949_1958, 1, 'omitnan');  % Mean across dimension 1 / mean of the elements in each column

%% Function call giving as sample the indicator values in the period 1973-after
indexOf1973 = find(HeathrowData(:, 1) == 1973);
HeathrowData_after1973 = HeathrowData(indexOf1973:HeathrowData_rows, :);
HeathrowINDICATORData_after1973 = HeathrowData_after1973(:, 2:HeathrowData_cols); % Removing years column

HeathrowINDICATORData_after1973_mean = mean(HeathrowINDICATORData_after1973, 1, 'omitnan'); 

parametricCI = NaN(9, 2);
bstrpCI = NaN(9, 2);
for i = 1:9   % Checking for the first 9 indicators
    [parametricCI(i, :), bstrpCI(i, :)] = Group69Exe2Fun1(HeathrowINDICATORData_after1973(:, i));

    fprintf("       Indicator %d [%s]      \n", i, HeathrowINDICATORText(i));
    fprintf("==============================\n")
    fprintf("-> Mean value (1973-after) 95%% parametric confidence interval = [%g , %g]\n",parametricCI(i, 1), parametricCI(i, 2));
    fprintf("-> Mean value (1973-after) 95%% bootstrap confidence interval = [%g , %g]\n",bstrpCI(i, 1), bstrpCI(i, 2));
    fprintf("-> Mean value (1949-1958) = %g\n", HeathrowINDICATORData_1949_1958_mean(i));
    fprintf("-> Mean value (1973-after) = %g\n", HeathrowINDICATORData_after1973_mean(i));

    % Cheking if the indicator's mean value from the 1949-1958 period is in
    % either mean value confidence interval from the period 1973-after
    % Checking on the parametric confidence interval
    if parametricCI(i, 1) <= HeathrowINDICATORData_1949_1958_mean(i) && HeathrowINDICATORData_1949_1958_mean(i) <= parametricCI(i, 2)
        fprintf("--> Indicator %d mean value (1949-1958) is in the (1973-after) 95%% parametric confidence interval.\n", i);
    end
    % Checking on the bootstrap confidence interval
    if bstrpCI(i, 1) <= HeathrowINDICATORData_1949_1958_mean(i) && HeathrowINDICATORData_1949_1958_mean(i) <= bstrpCI(i, 2)
        fprintf("--> Indicator %d mean value (1949-1958) is in the (1973-after) 95%% bootstrap confidence interval.\n", i);
    end   
    
    fprintf("\n");
end

%%          Conclusions and comments
% ==============================================
%   Ta dyo diasthmata empistosynhs (parametriko kai boostrap) kai oi
% oi meses times twn 2 periodwn ektipwnontai stin konsola.
%   Epishs ektiponetai o elegxos an h mesh timh ths periodou tou 1949-1958
% vrisketai sta dio diasthmata gia thn mesh timh ths periodou 1973-meta
% Auto fainetai na isxuei gia tous indicators [Tm] kai [SN] kai malista
% vlepoume oti ta apotelesmata gia ta dyo diasthmata empistosinis
% symfwnoun.
%
%   Parathroume oti ta dyo diasthmata empistosinis (parametriko kai
% bootstrap) den fainetai na diaferoun symantika gia kanena dikti kai
% vlepoume pws dinoun paromoia apotelesmata me ena arketa mikro tolerance.
%
%   H mesh timh ths prwths periodou 1949 - 1958 fainetai na exei
% allaksei sthn periodo 1973 - 2017 gia kapoious diktes. Oi diktes autoi
% einai oi:
% Indicator [FG]: Apo 108.9 se 29.97 (Poly symantiki allagh timhs, triplasiasmos)
% Oi ypoloipoi deiktes den fainetai na exoyn shmantikh allagh meshs timhs
% stis dyo periodous
% Edw akzisei epishs na shmeiwthei kai h periptwsh tou Indicator [PP] opoy
% Apo NaN se 624.89. Edw den eixame katholou deigmata gia th 1h periodo 
% opote den mporoume na krinoume an eixame symantiki allagh meshs timhs.