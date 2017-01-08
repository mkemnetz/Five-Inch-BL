function [data_jitter, TTP_store] = buildFakeJitterData(WF, x, y) 
%BUILDFAKEJITTERDATA - This function takes in the large 5in wavefronts and 
%builds six sets of data.  These represent aperture sizes of 1, 2, 3, 4, 
%5, and 6 delta.
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
%    data - A struct holding the various aperured data
%           data.one   = one delta aperture
%           data.two   = two delta aperture
%           data.three = three delta aperture
%           data.four  = four delta aperture
%           data.five  = five delta aperture
%           data.six  = five delta aperture
%           Each of the above also holds phase, x, and y values.  Example:
%           data.one.x
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

data_jitter.one.phase   = WF(:, 1:10, :) - repmat(mean(WF(:, 1:10, :), 3), 1, 1, size(WF, 3));
data_jitter.two.phase   = WF(:, 1:18, :) - repmat(mean(WF(:, 1:18, :), 3), 1, 1, size(WF, 3));
data_jitter.three.phase = WF(:, 1:26, :) - repmat(mean(WF(:, 1:26, :), 3), 1, 1, size(WF, 3));
data_jitter.four.phase  = WF(:, 1:35, :) - repmat(mean(WF(:, 1:35, :), 3), 1, 1, size(WF, 3));
data_jitter.five.phase  = WF(:, 1:43, :) - repmat(mean(WF(:, 1:43, :), 3), 1, 1, size(WF, 3));
data_jitter.six.phase   = WF(:, 1:51, :) - repmat(mean(WF(:, 1:51, :), 3), 1, 1, size(WF, 3));

data_jitter.one.x   = x(:, 1:10, :) - x(1, 1, 1);
data_jitter.two.x   = x(:, 1:18, :) - x(1, 1, 1);
data_jitter.three.x = x(:, 1:26, :) - x(1, 1, 1);
data_jitter.four.x  = x(:, 1:35, :) - x(1, 1, 1);
data_jitter.five.x  = x(:, 1:43, :) - x(1, 1, 1);
data_jitter.six.x   = x(:, 1:51, :) - x(1, 1, 1);

data_jitter.one.y   = y(:, 1:10, :);
data_jitter.two.y   = y(:, 1:18, :);
data_jitter.three.y = y(:, 1:26, :);
data_jitter.four.y  = y(:, 1:35, :);
data_jitter.five.y  = y(:, 1:43, :);
data_jitter.six.y   = y(:, 1:51, :);


[ data_jitter.one.phase,   TTP_store.one   ] = removeTTP( ...
    data_jitter.one.phase,   data_jitter.one.x,   data_jitter.one.y );
[ data_jitter.two.phase,   TTP_store.two   ] = removeTTP( ...
    data_jitter.two.phase,   data_jitter.two.x,   data_jitter.two.y );
[ data_jitter.three.phase, TTP_store.three ] = removeTTP( ...
    data_jitter.three.phase, data_jitter.three.x, data_jitter.three.y );
[ data_jitter.four.phase,  TTP_store.four  ] = removeTTP( ...
    data_jitter.four.phase,  data_jitter.four.x,  data_jitter.four.y );
[ data_jitter.five.phase,  TTP_store.five  ] = removeTTP( ...
    data_jitter.five.phase,  data_jitter.five.x,  data_jitter.five.y );
[ data_jitter.six.phase,   TTP_store.six   ] = removeTTP( ...
    data_jitter.six.phase,   data_jitter.six.x,   data_jitter.six.y );                       











 % ===== EOF ====== [buildfakedata.m] ======  

