%% ------------|   Group 69   |------------
% Kyparissis Kyparissis (University ID: 10346) (Email: kyparkypar@ece.auth.gr)
% Fotios Alexandridis   (University ID:  9953) (Email: faalexandr@ece.auth.gr)

clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

rng(3);

%% Import Heathrow.xlsx and read appropriate data
% Read Heathrow.xlsx spreadsheet as double matrix (for data)
HeathrowData = 	readmatrix('Heathrow.xlsx');
[HeathrowData_rows, HeathrowData_cols] = size(HeathrowData);

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

for i = 1:9     % Cheking for the first 9 indicators
    [p_parametric, p_bootstrap] = Group69Exe3Fun1(HeathrowData(:, 1), HeathrowData(:, i + 1));

    fprintf("       Indicator %d (%s)      \n", i, HeathrowINDICATORText(i));
    fprintf("==============================\n");
    fprintf("p-value from the parametric (student) check = %d \n", p_parametric);
    fprintf("p-value from the resampling (bootstrap) check = %d \n", p_bootstrap);


    fprintf("\n");
end

% O deiktis pou tha exei thn megaliteri diafora stis dio periodous tha
% einai autos me tin mikroteri pithanotita na exei diafora meswn timwn = 0,
% dhladh o diktis me tis mikroteres times p.
% Apofasizoume na orisoume significance level alpha = 0.05, dhladh opoia
% timh p einai mikroteri tou alpha, aporiptoume to null hypothesis tou
% deikti ekeinou gia midenikh diafora meswn timwn
% Vlepoume oti aporriptonai oi deiktes:
% me ton deikti () na exei tin mikroteri timh p opote fainetai na einai
% autos me thn megalyterh diafora stis dyo periodous.
% Twra tha apanthsoume sto erwthma sxetika me to an symfwnoun oi 2 typoi
% elegxou (parametriko kai epanadeigmatolipsias).
% ...