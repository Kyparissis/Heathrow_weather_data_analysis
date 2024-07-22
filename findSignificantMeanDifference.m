% This script reads the Heathrow.xlsx spreadsheet and performs a parametric and a bootstrap test to find the 
% indicators that have a significant mean difference.

clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

rng(3); % Set rng for reproducibility

%% Import Heathrow.xlsx and read appropriate data
% Read Heathrow.xlsx spreadsheet as double matrix (for data)
HeathrowData = readmatrix('Heathrow.xlsx');
[HeathrowData_rows, HeathrowData_cols] = size(HeathrowData);

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

p_parametric = nan(1, 9);
p_bootstrap = nan(1, 9);
for i = 1:9     % Cheking for the first 9 indicators
    [p_parametric(i), p_bootstrap(i)] = parametricTestSignificantMeanDifference(HeathrowData(:, 1), HeathrowData(:, i + 1));

    fprintf("       Indicator %d [%s]      \n", i, HeathrowINDICATORText(i));
    fprintf("==============================\n");
    fprintf("p-value (H0: Mean diff. = 0) from the parametric (student) test = %g \n", p_parametric(i));
    fprintf("p-value (H0: Mean diff. = 0) from the resampling (bootstrap) test = %g \n", p_bootstrap(i));

    fprintf("\n");
end

fprintf("\n  Indicators with  mean difference\n");
fprintf("------------------------------------\n");
fprintf("[According to parametric p-values]\n");
rejectedH0_ind_param = find(p_parametric < 0.05);
disp(HeathrowINDICATORText(rejectedH0_ind_param))
fprintf("[According to bootstrap p-values]\n")
rejectedH0_ind_boot = find(p_bootstrap < 0.05);
disp(HeathrowINDICATORText(rejectedH0_ind_boot))


fprintf("\n  Indicator with statistically most significant mean difference\n");
fprintf("-----------------------------------------------------------------\n");
[min_p_parametric, min_p_parametricInd] = min(p_parametric);
[min_p_bootstrap, min_p_bootstrapInd] = min(p_bootstrap);
fprintf("=> Indicator with the smallest p(parametric) value is [%s] \n", HeathrowINDICATORText(min_p_parametricInd));
fprintf("=> Indicator with the smallest p(bootstrap) value is [%s] \n", HeathrowINDICATORText(min_p_bootstrapInd));


%%          Conclusions and comments
% ==============================================
%   Oi deiktes  oi opoioi tha exoun diafora stis meses times stis dyo
% periodous tha einai autoi poy tha exoun poly mikri pithanothta gia
% diafora meswn timwn ish me mhden
% Etsi, apofasizoume na orisoume significance level alpha = 0.05, dhladh opoia
% timh p einai mikroteri tou alpha, aporiptoume to null hypothesis tou
% deikti ekeinou gia midenikh diafora meswn timwn
% Vlepoume oti aporriptonai oi deiktes: [T],[TM],[V],[RA],[TS],[FG] symfwna
% me ton parametriko elegxo.
% Aporripontai oi idioi diktes kai gia ton bootstrap elegxo.
% Ara oi dyo typoi elegxou symfwnoun edw.
%
%   O deiktis pou fainetai na exei thn megalyterh diafora stis dyo periodous
% tha einai autos me thn mikroteri timh elegxou p gia kathe elegxo
% O deiktis me tin mikroteri p timh einai o [FG] gia ton parametriko elegxo alla kai gia ton
% boostrap elegxo kai ara sympairenoume oti to apotelesma gia tous dyo
% typous elegxou symfwnoun kai edw.
%
% Telos aksizei na shmeiwthei kai h periptwsh tou indicator [PP] opoy kai
% stis dyo periptwseis phrame p = NaN. Auto symbainei dioti stin periodo
% 1949 - 1958 den eixame katholou deigmata.
%  Aksizei na shmeiwthei edw oti egine xrhsh tou rng() gia
%  apanalipsimothta.