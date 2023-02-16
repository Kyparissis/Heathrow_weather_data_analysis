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
HeathrowINDICATORData = HeathrowData(:, 2:HeathrowData_cols);

% Read Heathrow.xlsx spreadsheet as string matrix (for indicators text)
HeathrowDataText = readcell('Heathrow.xlsx');
HeathrowINDICATORText = string(HeathrowDataText(1, 2:HeathrowData_cols)); % Removing years column and keeping 1st row 

dependedVariableText = "FG";
dependedVariable = HeathrowINDICATORData(:, HeathrowINDICATORText == dependedVariableText);

TypeOfModel_str = ["1st degree polyonymial" "2nd degree polyonymial" "3rd degree polyonymial" "Ln-transform"];
for i = 1:length(HeathrowINDICATORText)
    if i ~= find(HeathrowINDICATORText == "TN") && i ~= find(HeathrowINDICATORText == dependedVariableText)
        [adjR2_Model, TypeOfModel] = Group69Exe7Fun1(HeathrowINDICATORData(:, i), dependedVariable);
        
        sgtitle(sprintf("Depended Variable: [%s] -- Independed Variable: [%s]", dependedVariableText, HeathrowINDICATORText(i)));
        
        % Console output:
        fprintf("  Depended Variable: [%s] -- Independed Variable: [%s]\n",dependedVariableText, HeathrowINDICATORText(i));
        fprintf("========================================================\n");
        fprintf("--> Best fitted by model #%d (%s)\n", TypeOfModel, TypeOfModel_str(TypeOfModel));
        fprintf("----> adjR2 = %g\n\n", adjR2_Model);
    end
end

%%          Conclusions and comments
% ==============================================
%   Enas diktis mporei na eksigisei ton dikti [FG] ean exei sxetika megali
% timh adjR2, to opoio apotelei metro tou fitness.
%   Oi diktes pou fainetai na exoun sxetika megalh timh (se sxesh kai me tous
% ypoloipous) einai oi:
% [RA]: adjR2 = 0.349 me to polyonimiko modelo 2ou vathmou.
% [T]: adjR2 = 0.2517 me to model tou Ln-transform (eggenhs grammiko modelo)
%   Akzizei episis na shmeiwthei oti mporoume epishs na doume oti orismenes
% times tou adjR2 einai arnhtikes. O typos gia to adjR2 apo th theoria
% epitrepei na einai arnhtiko. Proorizetai gia na proseggisei thn
% pragmatiki posostiaia diakymansi poy eksigitai. Etsi an to R2 einai
% konta sto 0, to adjR2 mporei na einai elafrws arnhtiko kai to theoroume
% ws ektimisi ish me 0. (To adjR2 einai ena kritirio epiloghs montelou epomenos 
% oute to proshmo oute to megethos tou exoun kamia statistiki shmasia, se antithesi 
% me to R2. Dhladh ena xamhlo adjR2 apla mas leei oti to montelo den tairiazei.)
% (Epishs prepei panta adjR2 <= R2)