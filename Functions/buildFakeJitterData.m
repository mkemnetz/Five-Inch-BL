function [data_jitter] = buildFakeJitterData(WF, x, y) 
%BUILDFAKEJITTERDATA - This function takes in the large 5in wavefronts and builds
%five sets of data.  These represent aperture sizes of 1, 2, 3, 4, and 5
%delta
% 
% Syntax:  [data_jitter] = buildFakeJitterData(WF, x, y) 
% 
% Inputs: 
%    WF - A 3D array or a cell array carrying OPD.  The third dimension is
%           time.
%    x  - A 3D array or a cell array carrying the corresponding x position
%           of the OPD.
%    x  - A 3D array or a cell array carrying the corresponding y position
%           of the OPD.
%
% Outputs: 
%    data - A struct holding the value of the original data and the three
%           separations.
%           data.zero  = zero separation or the "upstream" data
%           data.one   = one delta separation
%           data.two   = two delta separation
%           data.three = three delta separation
%           data.four  = four delta separation
%           Each of the above also holds phase, x, and y values.  Example:
%           data.zero.x
% 
% Example: 
%    [data_jitter] = buildFakeJitterData(WF, x, y)  
% 
% Other m-files required: removeTTP.m
% Subfunctions: none 
% MAT-files required: none 
% 
% See also: buildFakeData.m
 
% Author: Matthew Kemnetz 
% Hessert Laboratory for Aerospace Research B034 
% email: mkemnetz@nd.edu, kemnetz.m@gmail.com 
% Website: http://www.matthewkemnetz.com 
% December 2016; Last revision: 6-December-2016  
% Copyright 2016, Matthew Kemnetz, All rights reserved. 
 
%% ------------- BEGIN CODE -------------- %% 
if iscell(WF)
    WF = cat(3,WF{:});
end

if iscell(x)
    x = cat(3,x{:});
end

if iscell(y)
    y = cat(3,y{:});
end

data_jitter.one.phase   = WF(:, 10:27, :);
data_jitter.two.phase   = WF(:, 18:35, :);
data_jitter.three.phase = WF(:, 27:44, :);
data_jitter.four.phase  = WF(:, 35:52, :);
data_jitter.five.phase  = WF(:, 35:52, :);

data_jitter.one.x   = x(:, 10:27, :) - x(1, 10, 1);
data_jitter.two.x   = x(:, 18:35, :) - x(1, 18, 1);
data_jitter.three.x = x(:, 27:44, :) - x(1, 27, 1);
data_jitter.four.x  = x(:, 35:52, :) - x(1, 35, 1);
data_jitter.five.x  = x(:, 35:52, :) - x(1, 35, 1);

data_jitter.one.y   = y(:, 10:27, :);
data_jitter.two.y   = y(:, 18:35, :);
data_jitter.three.y = y(:, 27:44, :);
data_jitter.four.y  = y(:, 35:52, :);
data_jitter.five.y  = y(:, 35:52, :);


[ data_jitter.one.phase, ~ ]   = removeTTP( data_jitter.one.phase, ...
                            data_jitter.one.x, data_jitter.one.y );
[ data_jitter.two.phase, ~ ]   = removeTTP( data_jitter.two.phase, ...
                            data_jitter.two.x, data_jitter.two.y );
[ data_jitter.three.phase, ~ ] = removeTTP( data_jitter.three.phase, ...
                            data_jitter.three.x, data_jitter.three.y );
[ data_jitter.four.phase, ~ ]  = removeTTP( data_jitter.four.phase, ...
                            data_jitter.four.x, data_jitter.four.y );
[ data_jitter.five.phase, ~ ]  = removeTTP( data_jitter.five.phase, ...
                            data_jitter.five.x, data_jitter.five.y );
                       











 % ===== EOF ====== [buildfakedata.m] ======  

