%%
if and(exist('data_flag','var') == 0, exist('data_jitter','var') == 0)
    error('data_flag variable is missing.  This variable is nececessary to know which data to load.');
end
if exist('TTP_store','var') == 0
    if (data_flag == 1)
        load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/Stitch Data/10-31 Data/data.mat')         % 10-31 Data
    elseif (data_flag == 2)
        load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/Stitch Data/11-31 Data Small/data.mat');  % 11-31 Data Small
    elseif(data_flag == 3)
        load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/Stitch Data/11-31 Data Full/data.mat');   % 11-31 Data Full
    else
        error('Unsupported data_flag');
    end
end

%%
numberOfStitch = 3;

%% One
gen_stitch_params_5in_one;

one = fliplr(data_jitter.one.phase);
x   = fliplr(data_jitter.one.x);
y   = fliplr(data_jitter.one.y);

[ WF_stitched.one, OUTPUT.one ] = stitchWF2( one, x, y, params);

WF_stitched.one.x = -1.*WF_stitched.one.x;  % I don't know why this is needed yet.  
multiWaitbar( 'Stitching...', 'Increment', 1/numberOfStitch, 'Color', 'r' );

%% Two
gen_stitch_params_5in_two;

two = fliplr(data_jitter.two.phase);
x   = fliplr(data_jitter.two.x);
y   = fliplr(data_jitter.two.y);

[ WF_stitched.two, OUTPUT.two ] = stitchWF2( two, x, y, params);

WF_stitched.two.x = -1.*WF_stitched.two.x;  % I don't know why this is needed yet.
multiWaitbar( 'Stitching...', 'Increment', 1/numberOfStitch, 'Color', 'r' );

% %% Three
% gen_stitch_params_5in_three;
% 
% three = fliplr(data_jitter.three.phase);
% x   = fliplr(data_jitter.three.x);
% y   = fliplr(data_jitter.three.y);
% 
% [ WF_stitched.three, OUTPUT.three ] = stitchWF2( three, x, y, params);
% 
% WF_stitched.three.x = -1.*WF_stitched.three.x;  % I don't know why this is needed yet. 
% multiWaitbar( 'Stitching...', 'Increment', 1/numberOfStitch, 'Color', 'r' );

%% Six
gen_stitch_params_5in_six;

six = fliplr(data_jitter.six.phase);
x   = fliplr(data_jitter.six.x);
y   = fliplr(data_jitter.six.y);

[ WF_stitched.six, OUTPUT.six ] = stitchWF2( six, x, y, params);

WF_stitched.six.x = -1.*WF_stitched.six.x;  % I don't know why this is needed yet.
multiWaitbar( 'Stitching...', 'Increment', 1/numberOfStitch, 'Color', 'r' );

%% Save
save([save_dir 'stitch' '.mat'], 'WF_stitched', 'OUTPUT', '-mat', '-v7.3');
