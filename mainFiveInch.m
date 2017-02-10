%%
clc;
close all;
multiWaitbar( 'CloseAll' );
multiWaitbar( 'Overall Progress', 0 , 'Color', 'b');


%% 1
% Start the program clock to display run time at end
program_start = tic;

% 1 => 10-31 Data
% 2 => 11-31 Data Small
% 3 => 11-31 Data Full
data_flag     = 2;


%% 2
fprintf('\n\n\n\nCleaning Workspace...\n');
multiWaitbar( 'Cleaning Workspace...', 0.5, 'Color', 'r' );

clearvars -except program_start data_flag;

multiWaitbar( 'Cleaning Workspace...', 1, 'Color', 'g' );
multiWaitbar( 'Overall Progress', 'Increment', 1/10 );

%% 3
fprintf('Loading in Processed Data...\n');
multiWaitbar( 'Loading in Processed Data...', 0.5, 'Color', 'r' );
if (data_flag == 1)
    load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/F1/WF_processed.mat');  % 10-31 Data
elseif (data_flag == 2)
    load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/11-31/F1/F1.mat');  % 11-31 Data Small
elseif(data_flag == 3)
    load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/11-31/F1/F1_2.mat');  % 11-31 Data Full
else
    error('Unsupported data_flag');
end

multiWaitbar( 'Loading in Processed Data...', 1, 'Color', 'g' );
multiWaitbar( 'Overall Progress', 'Increment', 1/10 );

%% 4
% set up save directory for the data.
save_dir_pre  = '/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/Main Data/';
if (data_flag == 1)
    save_dir = [save_dir_pre '10-31 Data/'];
elseif (data_flag == 2)
    save_dir = [save_dir_pre '11-31 Data Small/'];
elseif(data_flag == 3)
    save_dir = [save_dir_pre '11-31 Data Full/'];
else
    error('Unsupported data_flag');
end

save_dir = dir_check(save_dir); 
        
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
[data_jitter, TTP_store] = ...
    buildFakeJitterData(phase_Final_m, x_Final_m, y_Final_m);

clearvars -except data save_dir data_jitter TTP_store program_start save_str;
save([save_dir 'data' '.mat'], 'data*', '-mat', '-v7.3');
save([save_dir 'TTP'  '.mat'], 'TTP*', '-mat', '-v7.3');

multiWaitbar( 'Windowing down WFs and removing TTP...', 1, 'Color', 'g' );
multiWaitbar( 'Overall Progress', 'Increment', 1/10 );

%% 4
fprintf('Computing Aero-Optical Jitter...\n');
multiWaitbar( 'Computing Aero-Optical Jitter...', 0.5, 'Color', 'r' );

plotJitter;

multiWaitbar( 'Computing Aero-Optical Jitter...', 1, 'Color', 'g' );
multiWaitbar( 'Overall Progress', 'Increment', 1/10 );

%% 5
fprintf('Computing Global Error Directly (All Modes)...\n');
multiWaitbar( 'Computing Global Error Directly (All Modes)...', 0, 'Color', 'r' );

computeErrorGlobal;

multiWaitbar( 'Computing Global Error Directly (All Modes)...', 1, 'Color', 'g' );
multiWaitbar( 'Overall Progress', 'Increment', 1/10 );

%% 6
fprintf('Computing JPOD...\n');
multiWaitbar( 'Computing JPOD...', 0, 'Color', 'r' );

clearvars -except data  save_dir program_start save_str e2_1 e2_2 e2_3 e2_4;
Nmodes_plot = 100;
computeJPOD;

multiWaitbar( 'Overall Progress', 'Increment', 1/10 );

%% 7
fprintf('Projecting onto JPOD Modes...\n');
computeProjectedTimeCoeffs_JPOD;

multiWaitbar( 'Overall Progress', 'Increment', 1/10 );

%% 8
% Number of modes to use
NumberOfModes = 20;

fprintf('Summing up first %i modes...\n', NumberOfModes);
projectJPOD;

clearvars -except data  save_dir program_start save_str e2_1 e2_2 e2_3 e2_4 NumberOfModes a_n_zero a_n_one a_n_two a_n_three a_n_four POD_Modes Time_Coeff WF_zero WF_one WF_two WF_three WF_four

multiWaitbar( 'Overall Progress', 'Increment', 1/10 );

%% 9
fprintf('Compute Global Error with %i modes...\n', NumberOfModes);
computeErrorGlobal_JPOD;

multiWaitbar( 'Overall Progress', 'Increment', 1/10 );

%% 10
fprintf('Compute Relative Error...');
computeRelativeError_JPOD;

multiWaitbar( 'Overall Progress', 'Increment', 1/10 );

%%
program_end         = toc(program_start);
[hours, mins, secs] = sec2hms(program_end);
fprintf('Elapsed time is %0.2f Hours, %0.2f Minutes, %0.2f Seconds ...\n', hours, mins, secs);
multiWaitbar( 'CloseAll' );

