function [data] = buildfakedata(WF, x, y) 
%BUILDFAKEDATA - This function takes in the large 5in wavefronts and builds
%four sets of data.  These represent separations of 0, 1, 2, and 3 boundary
%layer thicknesses.
% 
% Syntax:  [data] = buildfakedata(WF) 
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
%    [data] = buildfakedata(WF)  
% 
% Other m-files required: none 
% Subfunctions: none 
% MAT-files required: none 
% 
% See also: none
 
% Author: Matthew Kemnetz 
% Hessert Laboratory for Aerospace Research B034 
% email: mkemnetz@nd.edu, kemnetz.m@gmail.com 
% Website: http://www.matthewkemnetz.com 
% November 2016; Last revision: 17-November-2016 
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

data.zero.phase  = WF(:, 1:18, :);
data.one.phase   = WF(:, 10:27, :);
data.two.phase   = WF(:, 18:35, :);
data.three.phase = WF(:, 27:45, :);
data.four.phase  = WF(:, 35:52, :);

data.zero.x  = x(:, 1:18, :);
data.one.x   = x(:, 10:27, :);
data.two.x   = x(:, 18:35, :);
data.three.x = x(:, 27:45, :);
data.four.x  = x(:, 35:52, :);

data.zero.y  = y(:, 1:18, :);
data.one.y   = y(:, 10:27, :);
data.two.y   = y(:, 18:35, :);
data.three.y = y(:, 27:45, :);
data.four.y  = y(:, 35:52, :);

[ data.zero.phase, ~ ] = removeTTP( data.zero.phase, ...
                            data.zero.x, data.zero.y );
[ data.one.phase, ~ ] = removeTTP( data.one.phase, ...
                            data.one.x, data.one.y );
[ data.two.phase, ~ ] = removeTTP( data.two.phase, ...
                            data.two.x, data.two.y );
[ data.three.phase, ~ ] = removeTTP( data.three.phase, ...
                            data.three.x, data.three.y );
[ data.four.phase, ~ ] = removeTTP( data.four.phase, ...
                            data.four.x, data.four.y );
                       











 % ===== EOF ====== [buildfakedata.m] ======  

