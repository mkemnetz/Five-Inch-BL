%%
clc;
close all;

%%
tic;

%%
fprintf('\n\n\n\nCleaning Workspace...\n');
clear all;



%%
fprintf('Loading in Processed Data...\n');
load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/F1/WF_processed.mat');

%%
fprintf('Windowing down WFs and removing TTP...\n');
trim          = [2; 32; 7; 60];
x_Final_m     = cat(3,x_Final{:});
y_Final_m     = cat(3,y_Final{:});
phase_Final_m = cat(3,phase_Final{:});
x_Final_m     = trimMat(x_Final_m, trim);
y_Final_m     = trimMat(y_Final_m, trim);
phase_Final_m = trimMat(phase_Final_m, trim);
x_Final_m     = x_Final_m +(-1)*x_Final_m(1, 1, 1);
data          = buildFakeData(phase_Final_m, x_Final_m, y_Final_m);
clearvars -except data;

%%
fprintf('Computing Global Error Directly (All Modes)...\n');
computeErrorGlobal;

%%
fprintf('Computing JPOD...\n');
clearvars -except data e2_1 e2_2 e2_3 e2_4;
JPOD = cat(3, cat(3, cat(3, data.zero.phase, data.one.phase), data.two.phase), data.three.phase);
[ POD_Modes, Time_Coeff, energy ] = computePOD( JPOD );


%% 
fprintf('Projecting onto JPOD Modes...\n');
computeProjectedTimeCoeffs_JPOD;

%%
% Number of modes to use
NumberOfModes = 20;

fprintf('Summing up first %i modes...\n', NumberOfModes);
projectJPOD;

clearvars -except data e2_1 e2_2 e2_3 e2_4 NumberOfModes a_n_zero a_n_one a_n_two a_n_three a_n_four POD_Modes Time_Coeff WF_zero WF_one WF_two WF_three WF_four

%%
computeErrorGlobal_JPOD;

%%
toc;


