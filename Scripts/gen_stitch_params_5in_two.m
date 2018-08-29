%% gen_stitch_params_5in.m
%  Matthew Kemnetz
%  This file generates the parameters and constants used in the wavefront
%  stitching algorithm

%  Set the number of rows and columns for the interpolated wavefront.  The
%  main algorithm uses interp2 to refine the mesh.  
params.fine = 400;

%  Set the start frame number to begin the stitching
params.start = 	1;

%  Set the number of frames to stitch together.
params.N     = 1000;

%  Set the number of excess rows and columns to be trimed off either side; 
params.excessRows    = 1;
params.excessColumns = 1;

%  Set smoothing filter size
params.filterSize = 5;

% Set a flag to decide if you want to use the constant conv speed or the
% computed conv speed to stitch the frames.  
% true  => instantaneous computed conv speed
% false => constant conv speed
params.instantConv_flag = true;

% Set a flag to decide if you want to use the tip, tilt, and piston 
% correction.
% true  => TTP is added to neighboring frames to ensure continuity in 
%          overlap region 
% false => TTP is NOT added
params.TTP_flag = true;

params.mach = 0.2;
% params.mach = 0.03;

% Temp in Farenheit
params.T    = 78.4;

params.expected_shift = 10;

% Set the forced overlap used if the computer overlap is 0.
params.forcedOverlap = 10;

% Set the sampling frequency used in the experiment.  Used to compute 
% convective velocity 
params.fsamp = 40307;

% Set the boundary layer thickness from the experiment.
params.delta = 15.6e-3;


% Set the free stream velocity from the experiment.
params.Vinf = machToVel(0.2, 78.4);


