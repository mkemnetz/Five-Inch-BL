function [WF_ts, x_ts, y_ts, TTP_rem] = genDiffAp(x_in, y_in, WF_in, index_in, varargin) 
%GENDIFFAP - One line description of what the function or script performs (H1 line) 
%Optional file header info (to give more details about the function than in the H1 line) 
%Optional file header info (to give more details about the function than in the H1 line) 
%Optional file header info (to give more details about the function than in the H1 line) 
% 
% Syntax:  [output1,output2] = genDiffAp(input1,input2,input3) 
% 
% Inputs: 
%    input1 - Description 
%    input2 - Description 
%    input3 - Description 
% 
% Outputs: 
%    output1 - Description 
%    output2 - Description 
% 
% Example: 
%    Line 1 of example 
%    Line 2 of example 
%    Line 3 of example 
% 
% Other m-files required: machToVel.m 
% Subfunctions: none 
% MAT-files required: none 
% 
% See also: OTHER_FUNCTION_NAME1,  OTHER_FUNCTION_NAME2 
 
% Author: Matthew Kemnetz 
% Hessert Laboratory for Aerospace Research B034 
% email: mkemnetz@nd.edu, kemnetz.m@gmail.com 
% Website: http://www.matthewkemnetz.com 
% August 2018; Last revision: 27-August-2018 
% Copyright 2018, Matthew Kemnetz, All rights reserved. 
 
%% ------------- BEGIN CODE -------------- %% 
%% Parse Inputs
defaultInterpSize = [100, 100];
defaultDelta      = 15.6e-3;
defaultUc         = 0.8*machToVel(0.5, 75);
defaultFrequency  = 252420;

p = inputParser;
addRequired( p, 'x_in'       , @isnumeric)
addRequired( p, 'y_in'       , @isnumeric)
addRequired( p, 'WF_in'      , @isnumeric)
addRequired( p, 'index_in'   , @isnumeric)
addParameter(p, 'interpSize' , defaultInterpSize, @isnumeric);
addParameter(p, 'delta'      , defaultDelta     , @isnumeric);
addParameter(p, 'Uc'         , defaultUc        , @isnumeric);
addParameter(p, 'fsamp'      , defaultFrequency , @isnumeric);

parse(p, x_in, y_in, WF_in, index_in, varargin{:});

xx     = p.Results.x_in;
yy     = p.Results.y_in;
phase  = p.Results.WF_in;
index  = p.Results.index_in;
fine_m = p.Results.interpSize(1);
fine_n = p.Results.interpSize(2);
delta  = p.Results.delta;
Uc     = p.Results.Uc;
fsamp  = p.Results.fsamp;
 
%%
Uc_d  = Uc/delta;
dx    = xx(1, 2) - xx(1, 1);
dt    = 1/fsamp;
shift = round((Uc_d*dt)./dx);

n = floor((size(phase, 2)-index)/shift)+1;

WF = zeros(fine_m, fine_n, n);
x  = zeros(fine_m, fine_n, n);
y  = zeros(fine_m, fine_n, n);

for i = 1:n
        pt = phase(:, (1+(i-1)*shift):(index+(i-1)*shift));
        xt = xx(:, (1+(i-1)*shift):(index+(i-1)*shift));
        yt = yy(:, (1+(i-1)*shift):(index+(i-1)*shift));
        l = size(pt, 2);
        w = size(pt, 1);

        [Xq,Yq] = meshgrid(linspace(1,l, fine_n), linspace(1,w, fine_m));
        [X,Y]   = meshgrid(1:l, 1:w);

        WF(:, :, i) = interp2(X, Y, pt, Xq, Yq, 'cubic');
        x(:, :, i)  = interp2(X, Y, xt, Xq, Yq, 'cubic');
        y(:, :, i)  = interp2(X, Y, yt, Xq, Yq, 'cubic');
        

    if(mod(i, 1000) == 0)
        fprintf('\n 1 - %d \n', i);
    end
end

%
% [WF_ts, TTP_rem] = removeTTP(WF, x, y);
% x_ts             = x;
% y_ts             = y;

% 4/24/29 - changing units to meters to be consistent.  
[WF_ts, TTP_rem] = removeTTP(WF./1e6, x.*15.6e-3, y.*15.6e-3);
x_ts             = x.*15.6e-3;
y_ts             = y.*15.6e-3;
 
 
 
 
 
 
 
%% -------------- END CODE --------------- %% 
end 
%% --------- BEGIN SUBFUNCTIONS ---------- %% 










 % ===== EOF ====== [genDiffAp.m] ======  

