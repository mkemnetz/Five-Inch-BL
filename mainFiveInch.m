%%
clc;
close all;
multiWaitbar( 'CloseAll' );
multiWaitbar( 'Overall Progress', 0 , 'Color', 'b');


%%
program_start = tic;

%% 1
fprintf('\n\n\n\nCleaning Workspace...\n');
multiWaitbar( 'Cleaning Workspace...', 0.5, 'Color', 'r' );

clearvars -except program_start;

multiWaitbar( 'Cleaning Workspace...', 1, 'Color', 'g' );
multiWaitbar( 'Overall Progress', 'Increment', 1/9 );

%% 2
fprintf('Loading in Processed Data...\n');
multiWaitbar( 'Loading in Processed Data...', 0.5, 'Color', 'r' );

% load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/F1/WF_processed.mat');  % 10-31 Data
% load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/11-31/F1/F1.mat');  % 11-31 Data Small
load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/11-31/F1/F1_2.mat');  % 11-31 Data Small

multiWaitbar( 'Loading in Processed Data...', 1, 'Color', 'g' );
multiWaitbar( 'Overall Progress', 'Increment', 1/9 );

%% 3
fprintf('Windowing down WFs and removing TTP...\n');
multiWaitbar( 'Windowing down WFs and removing TTP...', 0.5, 'Color', 'r' );

% trim          = [2; 32; 7; 60];  % 10-31 Data
trim          = [2; 32; 7; 60];  % 11-31 Data
x_Final_m     = cat(3,x_Final{:});
y_Final_m     = cat(3,y_Final{:});
phase_Final_m = cat(3,phase_Final{:});
x_Final_m     = trimMat(x_Final_m, trim);
y_Final_m     = trimMat(y_Final_m, trim);
phase_Final_m = trimMat(phase_Final_m, trim);
x_Final_m     = x_Final_m +(-1)*x_Final_m(1, 1, 1);
data          = buildFakeData(phase_Final_m, x_Final_m, y_Final_m);
clearvars -except data program_start;

multiWaitbar( 'Windowing down WFs and removing TTP...', 1, 'Color', 'g' );
multiWaitbar( 'Overall Progress', 'Increment', 1/9 );

%% 4
fprintf('Computing Global Error Directly (All Modes)...\n');
multiWaitbar( 'Computing Global Error Directly (All Modes)...', 0, 'Color', 'r' );

computeErrorGlobal;

multiWaitbar( 'Computing Global Error Directly (All Modes)...', 1, 'Color', 'g' );
multiWaitbar( 'Overall Progress', 'Increment', 1/9 );

%% 5
fprintf('Computing JPOD...\n');
multiWaitbar( 'Computing JPOD...', 0, 'Color', 'r' );

clearvars -except data  program_start e2_1 e2_2 e2_3 e2_4;
JPOD = cat(3, cat(3, cat(3, data.zero.phase, data.one.phase), data.two.phase), data.three.phase);
[ POD_Modes, Time_Coeff, energy ] = computePOD( JPOD );

multiWaitbar( 'Overall Progress', 'Increment', 1/9 );

%% 6
fprintf('Projecting onto JPOD Modes...\n');
computeProjectedTimeCoeffs_JPOD;

multiWaitbar( 'Overall Progress', 'Increment', 1/9 );

%% 7
% Number of modes to use
NumberOfModes = 20;

fprintf('Summing up first %i modes...\n', NumberOfModes);
projectJPOD;

clearvars -except data  program_start e2_1 e2_2 e2_3 e2_4 NumberOfModes a_n_zero a_n_one a_n_two a_n_three a_n_four POD_Modes Time_Coeff WF_zero WF_one WF_two WF_three WF_four

multiWaitbar( 'Overall Progress', 'Increment', 1/9 );

%% 8
fprintf('Compute Global Error with %i modes...\n', NumberOfModes);
computeErrorGlobal_JPOD;

multiWaitbar( 'Overall Progress', 'Increment', 1/9 );

%% 9
fprintf('Compute Relative Error...');
computeRelativeError_JPOD;

multiWaitbar( 'Overall Progress', 'Increment', 1/9 );

%%
program_end         = toc(program_start);
[hours, mins, secs] = sec2hms(program_end);
fprintf('Elapsed time is %0.2f Hours, %0.2f Minutes, %0.2f Seconds ...\n', hours, mins, secs);
multiWaitbar( 'CloseAll' );

