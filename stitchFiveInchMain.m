%%
clc;
closeALL;
multiWaitbar( 'CloseAll' );
multiWaitbar( 'Overall Progress', 0 , 'Color', 'b');


%% 1
% Start the program clock to display run time at end
program_start = tic;

% 1 => 10-31 Data
% 2 => 11-31 Data Small
% 3 => 11-31 Data Full
data_flag     = 3;

numberOfSteps = 7;

%% 2
fprintf('\n\n\n\nCleaning Workspace...\n');
multiWaitbar( 'Cleaning Workspace...', 0.5, 'Color', 'r' );

clearvars -except program_start data_flag numberOfSteps;

multiWaitbar( 'Cleaning Workspace...', 1, 'Color', 'g' );
multiWaitbar( 'Overall Progress', 'Increment', 1/numberOfSteps );

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
multiWaitbar( 'Overall Progress', 'Increment', 1/numberOfSteps );

%% 4
% set up save directory for the data.
save_dir_pre  = '/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/Stitch Data/';
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
        
%% 5
fprintf('Windowing down WFs and removing TTP...\n');
multiWaitbar( 'Windowing down WFs and removing TTP...', 0.5, 'Color', 'r' );

% trim          = [2; 32; 7; 60];  % 10-31 Data
trim          = [2; 32; 7; 60];  % 11-31 Data
x_Final_m     = cat(3,x_Final{:});
y_Final_m     = cat(3,y_Final{:});
phase_Final_m = cat(3,phase_Final{:});
phase_Final_m = phase_Final_m.*2;  %
x_Final_m     = trimMat(x_Final_m, trim);
y_Final_m     = trimMat(y_Final_m, trim);
phase_Final_m = trimMat(phase_Final_m, trim);
x_Final_m     = x_Final_m +(-1)*x_Final_m(1, 1, 1);
 data          = buildFakeData(phase_Final_m, x_Final_m, y_Final_m);
[data_jitter, TTP_store] = ...
    buildFakeJitterData(phase_Final_m, x_Final_m, y_Final_m);

clearvars -except data save_dir data_jitter TTP_store program_start save_str numberOfSteps;
save([save_dir 'data' '.mat'], 'data*', '-mat', '-v7.3');
save([save_dir 'TTP'  '.mat'], 'TTP*', '-mat', '-v7.3');

multiWaitbar( 'Windowing down WFs and removing TTP...', 1, 'Color', 'g' );
multiWaitbar( 'Overall Progress', 'Increment', 1/numberOfSteps );

%% 6
fprintf('Stitching...\n');
multiWaitbar( 'Stitching...', 0, 'Color', 'r' );

stitchFiveInch;

multiWaitbar( 'Stitching...', 1, 'Color', 'g' );
multiWaitbar( 'Overall Progress', 'Increment', 1/numberOfSteps );

%% 7
fprintf('Generate new apertures...\n');
multiWaitbar( 'Generate new apertures...', 0.5, 'Color', 'r' );

generateDiffApertures_5in;

multiWaitbar( 'Generate new apertures...', 1, 'Color', 'g' );
multiWaitbar( 'Overall Progress', 'Increment', 1/numberOfSteps );

%%
program_end         = toc(program_start);
[hours, mins, secs] = sec2hms(program_end);
fprintf('Elapsed time is %0.2f Hours, %0.2f Minutes, %0.2f Seconds ...\n', hours, mins, secs);
multiWaitbar( 'CloseAll' );
