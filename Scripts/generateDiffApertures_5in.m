%  one 4-26-19 I changed all: (TTP_ts.one.one(1, :)/(10^6)) to (TTP_ts.one.one(1, :)) to fix units 

%% One
%  Ap/ d = 1
[WF_ts.one.one, x_ts.one.one, y_ts.one.one, TTP_ts.one.one] = ...
    genDiffAp(WF_stitched.one.x,  ...
              WF_stitched.one.y,  ...
              WF_stitched.one.WF, ... 
              370, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 200000); 
                                   
TTP_ts.one.one  = (TTP_ts.one.one(1, :));

%  Ap/ d = 3
[WF_ts.one.three, x_ts.one.three, y_ts.one.three, TTP_ts.one.three] = ...
    genDiffAp(WF_stitched.one.x,  ...
              WF_stitched.one.y,  ...
              WF_stitched.one.WF, ... 
              1108, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 200000); 
                                   
TTP_ts.one.three  = (TTP_ts.one.three(1, :));

%  Ap/ d = 5
[WF_ts.one.five, x_ts.one.five, y_ts.one.five, TTP_ts.one.five] = ...
    genDiffAp(WF_stitched.one.x,  ...
              WF_stitched.one.y,  ...
              WF_stitched.one.WF, ... 
              1846, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 200000); 
                                   
TTP_ts.one.five  = (TTP_ts.one.five(1, :));

%  Ap/ d = 10
[WF_ts.one.ten, x_ts.one.ten, y_ts.one.ten, TTP_ts.one.ten] = ...
    genDiffAp(WF_stitched.one.x,  ...
              WF_stitched.one.y,  ...
              WF_stitched.one.WF, ... 
              3690, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 200000);  
                                   
TTP_ts.one.ten  = (TTP_ts.one.ten(1, :));

%  Ap/ d = 20
[WF_ts.one.twenty, x_ts.one.twenty, y_ts.one.twenty, TTP_ts.one.twenty] = ...
    genDiffAp(WF_stitched.one.x,  ...
              WF_stitched.one.y,  ...
              WF_stitched.one.WF, ... 
              7379, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 200000);  
                                   
TTP_ts.one.twenty  = (TTP_ts.one.twenty(1, :));

%  RMS Jitter
rho_sl  = 1.225;
rho_inf = 1.2;
M       = 0.2;

cons = (rho_inf/rho_sl)*((M^2)+2.2*(25/298.9833));

Ap.one     = [1 3 5 10 20];
jitter.one = [rms(TTP_ts.one.one)./cons rms(TTP_ts.one.three)./cons rms(TTP_ts.one.five)./cons rms(TTP_ts.one.ten)./cons rms(TTP_ts.one.twenty)./cons];

%% Two
%  Ap/ d = 1
[WF_ts.two.one, x_ts.two.one, y_ts.two.one, TTP_ts.two.one] = ...
    genDiffAp(WF_stitched.two.x,  ...
              WF_stitched.two.y,  ...
              WF_stitched.two.WF, ... 
              197, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771); 
                                   
TTP_ts.two.one  = (TTP_ts.two.one(1, :));

%  Ap/ d = 3
[WF_ts.two.three, x_ts.two.three, y_ts.two.three, TTP_ts.two.three] = ...
    genDiffAp(WF_stitched.two.x,  ...
              WF_stitched.two.y,  ...
              WF_stitched.two.WF, ... 
              587, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771); 
                                   
TTP_ts.two.three  = (TTP_ts.two.three(1, :));

%  Ap/ d = 5
[WF_ts.two.five, x_ts.two.five, y_ts.two.five, TTP_ts.two.five] = ...
    genDiffAp(WF_stitched.two.x,  ...
              WF_stitched.two.y,  ...
              WF_stitched.two.WF, ... 
              978, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771); 
                                   
TTP_ts.two.five  = (TTP_ts.two.five(1, :));

%  Ap/ d = 10
[WF_ts.two.ten, x_ts.two.ten, y_ts.two.ten, TTP_ts.two.ten] = ...
    genDiffAp(WF_stitched.two.x,  ...
              WF_stitched.two.y,  ...
              WF_stitched.two.WF, ... 
              1954, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771);  
                                   
TTP_ts.two.ten  = (TTP_ts.two.ten(1, :));

%  Ap/ d = 20
[WF_ts.two.twenty, x_ts.two.twenty, y_ts.two.twenty, TTP_ts.two.twenty] = ...
    genDiffAp(WF_stitched.two.x,  ...
              WF_stitched.two.y,  ...
              WF_stitched.two.WF, ... 
              3907, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771);  
                                   
TTP_ts.two.twenty  = (TTP_ts.two.twenty(1, :));

%  RMS Jitter
rho_sl  = 1.225;
rho_inf = 1.2;
M       = 0.2;

cons = (rho_inf/rho_sl)*((M^2)+2.2*(25/298.9833));

Ap.two     = [1 3 5 10 20];
jitter.two = [rms(TTP_ts.two.one)./cons rms(TTP_ts.two.three)./cons rms(TTP_ts.two.five)./cons rms(TTP_ts.two.ten)./cons rms(TTP_ts.two.twenty)./cons];


%% Three
%  Ap/ d = 1
[WF_ts.three.one, x_ts.three.one, y_ts.three.one, TTP_ts.three.one] = ...
    genDiffAp(WF_stitched.three.x,  ...
              WF_stitched.three.y,  ...
              WF_stitched.three.WF, ... 
              134, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771); 
                                   
TTP_ts.three.one  = (TTP_ts.three.one(1, :));

%  Ap/ d = 3
[WF_ts.three.three, x_ts.three.three, y_ts.three.three, TTP_ts.three.three] = ...
    genDiffAp(WF_stitched.three.x,  ...
              WF_stitched.three.y,  ...
              WF_stitched.three.WF, ... 
              400, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771); 
                                   
TTP_ts.three.three  = (TTP_ts.three.three(1, :));

%  Ap/ d = 5
[WF_ts.three.five, x_ts.three.five, y_ts.three.five, TTP_ts.three.five] = ...
    genDiffAp(WF_stitched.three.x,  ...
              WF_stitched.three.y,  ...
              WF_stitched.three.WF, ... 
              665, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771); 
                                   
TTP_ts.three.five  = (TTP_ts.three.five(1, :));

%  Ap/ d = 10
[WF_ts.three.ten, x_ts.three.ten, y_ts.three.ten, TTP_ts.three.ten] = ...
    genDiffAp(WF_stitched.three.x,  ...
              WF_stitched.three.y,  ...
              WF_stitched.three.WF, ... 
              1329, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771);  
                                   
TTP_ts.three.ten  = (TTP_ts.three.ten(1, :));

%  Ap/ d = 20
[WF_ts.three.twenty, x_ts.three.twenty, y_ts.three.twenty, TTP_ts.three.twenty] = ...
    genDiffAp(WF_stitched.three.x,  ...
              WF_stitched.three.y,  ...
              WF_stitched.three.WF, ... 
              2657, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771);  
                                   
TTP_ts.three.twenty  = (TTP_ts.three.twenty(1, :));

%  RMS Jitter
rho_sl  = 1.225;
rho_inf = 1.2;
M       = 0.2;

cons = (rho_inf/rho_sl)*((M^2)+2.2*(25/298.9833));

Ap.three     = [1 3 5 10 20];
jitter.three = [rms(TTP_ts.three.one)./cons rms(TTP_ts.three.three)./cons rms(TTP_ts.three.five)./cons rms(TTP_ts.three.ten)./cons rms(TTP_ts.three.twenty)./cons];


%% Six
%  Ap/ d = 1
[WF_ts.six.one, x_ts.six.one, y_ts.six.one, TTP_ts.six.one] = ...
    genDiffAp(WF_stitched.six.x,  ...
              WF_stitched.six.y,  ...
              WF_stitched.six.WF, ... 
              68, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771); 
                                   
TTP_ts.six.one  = (TTP_ts.six.one(1, :));

%  Ap/ d = 3
[WF_ts.six.three, x_ts.six.three, y_ts.six.three, TTP_ts.six.three] = ...
    genDiffAp(WF_stitched.six.x,  ...
              WF_stitched.six.y,  ...
              WF_stitched.six.WF, ... 
              201, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771); 
                                   
TTP_ts.six.three  = (TTP_ts.six.three(1, :));

%  Ap/ d = 5
[WF_ts.six.five, x_ts.six.five, y_ts.six.five, TTP_ts.six.five] = ...
    genDiffAp(WF_stitched.six.x,  ...
              WF_stitched.six.y,  ...
              WF_stitched.six.WF, ... 
              333, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771); 
                                   
TTP_ts.six.five  = (TTP_ts.six.five(1, :));

%  Ap/ d = 10
[WF_ts.six.ten, x_ts.six.ten, y_ts.six.ten, TTP_ts.six.ten] = ...
    genDiffAp(WF_stitched.six.x,  ...
              WF_stitched.six.y,  ...
              WF_stitched.six.WF, ... 
              665, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771);  
                                   
TTP_ts.six.ten  = (TTP_ts.six.ten(1, :));

%  Ap/ d = 20
[WF_ts.six.twenty, x_ts.six.twenty, y_ts.six.twenty, TTP_ts.six.twenty] = ...
    genDiffAp(WF_stitched.six.x,  ...
              WF_stitched.six.y,  ...
              WF_stitched.six.WF, ... 
              1329, ...
              'Uc', machToVel(0.2, 78.4), ...
              'fsamp', 97771);  
                                   
TTP_ts.six.twenty  = (TTP_ts.six.twenty(1, :));

%  RMS Jitter
rho_sl  = 1.225;
rho_inf = 1.2;
M       = 0.2;

cons = (rho_inf/rho_sl)*((M^2)+2.2*(25/298.9833));

Ap.six     = [1 3 5 10 20];
jitter.six = [rms(TTP_ts.six.one)./cons rms(TTP_ts.six.three)./cons rms(TTP_ts.six.five)./cons rms(TTP_ts.six.ten)./cons rms(TTP_ts.six.twenty)./cons];


%% Save
save([save_dir 'stitch_jitter' '.mat'], 'Ap', 'jitter', '-mat', '-v7.3');
save([save_dir 'stitched_variable_ap' '.mat'], 'WF_ts', 'x_ts', 'y_ts', 'TTP_ts', '-mat', '-v7.3');



% %% Ap/ d = 1
% phase = WF_stitched.six.WF;
% xx    = WF_stitched.six.x;
% yy    = WF_stitched.six.y;
% 
% fine_m = 100;
% fine_n = 100;
% 
% delta = 15.6e-3;
% Uc    = 0.8*machToVel(0.2, 78.4);
% Uc_d  = Uc/delta;
% dx    = xx(1, 2) - xx(1, 1);
% 
% 
% % f_1  = 126210;
% f_1  = 126210*2;
% dt = 1/f_1;
% shift = round((Uc_d*dt)./dx);
% 
% k  = 68;
% n = floor((size(phase, 2)-k)/shift)+1;
% 
% WF = zeros(fine_m, fine_n, n);
% x  = zeros(fine_m, fine_n, n);
% y  = zeros(fine_m, fine_n, n);
% 
% for i = 1:n
%         pt = phase(:, (1+(i-1)*shift):(k+(i-1)*shift));
%         xt = xx(:, (1+(i-1)*shift):(k+(i-1)*shift));
%         yt = yy(:, (1+(i-1)*shift):(k+(i-1)*shift));
%         l = size(pt, 2);
%         w = size(pt, 1);
% 
%         [Xq,Yq] = meshgrid(linspace(1,l, fine_n), linspace(1,w, fine_m));
%         [X,Y]   = meshgrid(1:l, 1:w);
% 
%         WF(:, :, i) = interp2(X, Y, pt, Xq, Yq, 'cubic');
%         x(:, :, i)  = interp2(X, Y, xt, Xq, Yq, 'cubic');
%         y(:, :, i)  = interp2(X, Y, yt, Xq, Yq, 'cubic');
%         
% 
%     if(mod(i, 1000) == 0)
%         fprintf('\n 1 - %d \n', i);
%     end
% end
% 
% %
% [WF_ttpRem_1, TTP_1] = removeTTP(WF, x, y);
% x_1         = x;
% 
% %%  Ap/d = 3
% delta = 15.6e-3;
% Uc    = 0.8*machToVel(0.2, 78.4);
% Uc_d  = Uc/delta;
% dx    = xx(1, 2) - xx(1, 1);
% 
% % f_3  = 126210;
% f_3  = 126210*2;
% dt = 1/f_3;
% shift = round((Uc_d*dt)./dx);
% 
% k  = 201;
% n = floor((size(phase, 2)-k)/shift)+1;
% 
% 
% WF = zeros(fine_m, fine_n, n);
% x  = zeros(fine_m, fine_n, n);
% y  = zeros(fine_m, fine_n, n);
% 
% for i = 1:n
%         pt = phase(:, (1+(i-1)*shift):(k+(i-1)*shift));
%         xt = xx(:, (1+(i-1)*shift):(k+(i-1)*shift));
%         yt = yy(:, (1+(i-1)*shift):(k+(i-1)*shift));
%         l = size(pt, 2);
%         w = size(pt, 1);
% 
%         [Xq,Yq] = meshgrid(linspace(1,l, fine_n), linspace(1,w, fine_m));
%         [X,Y]   = meshgrid(1:l, 1:w);
% 
%         WF(:, :, i) = interp2(X, Y, pt, Xq, Yq, 'cubic');
%         x(:, :, i)  = interp2(X, Y, xt, Xq, Yq, 'cubic');
%         y(:, :, i)  = interp2(X, Y, yt, Xq, Yq, 'cubic');
%         
% 
%     if(mod(i, 1000) == 0)
%         fprintf('\n 3 - %d \n', i);
%     end
% end
% 
% %
% 
% [WF_ttpRem_3, TTP_3] = removeTTP(WF, x, y);
% x_3         = x;
% 
% %%  Ap/d = 5
% delta = 15.6e-3;
% Uc    = 0.8*machToVel(0.2, 78.4);
% Uc_d  = Uc/delta;
% dx    = xx(1, 2) - xx(1, 1);
% 
% % f_3  = 126210;
% f_5  = 126210*2;
% dt = 1/f_5;
% shift = round((Uc_d*dt)./dx);
% 
% k  = 333;
% n = floor((size(phase, 2)-k)/shift)+1;
% 
% 
% WF = zeros(fine_m, fine_n, n);
% x  = zeros(fine_m, fine_n, n);
% y  = zeros(fine_m, fine_n, n);
% 
% for i = 1:n
%         pt = phase(:, (1+(i-1)*shift):(k+(i-1)*shift));
%         xt = xx(:, (1+(i-1)*shift):(k+(i-1)*shift));
%         yt = yy(:, (1+(i-1)*shift):(k+(i-1)*shift));
%         l = size(pt, 2);
%         w = size(pt, 1);
% 
%         [Xq,Yq] = meshgrid(linspace(1,l, fine_n), linspace(1,w, fine_m));
%         [X,Y]   = meshgrid(1:l, 1:w);
% 
%         WF(:, :, i) = interp2(X, Y, pt, Xq, Yq, 'cubic');
%         x(:, :, i)  = interp2(X, Y, xt, Xq, Yq, 'cubic');
%         y(:, :, i)  = interp2(X, Y, yt, Xq, Yq, 'cubic');
%         
% 
%     if(mod(i, 1000) == 0)
%         fprintf('\n 5 - %d \n', i);
%     end
% end
% 
% %
% 
% [WF_ttpRem_5, TTP_5] = removeTTP(WF, x, y);
% x_5         = x;
% 
% %% Ap/d = 20
% 
% fine_m = 100;
% fine_n = 200;
% 
% 
% delta = 15.6e-3;
% Uc    = 0.8*machToVel(0.2, 78.4);
% Uc_d  = Uc/delta;
% dx    = xx(1, 2) - xx(1, 1);
% 
% % f_20  = 126210;
% f_20  = 126210*2;
% dt = 1/f_20;
% shift = round((Uc_d*dt)./dx);
% 
% 
% k  = 1329;
% n = floor((size(phase, 2)-k)/shift)+1;
% 
% 
% WF = zeros(fine_m, fine_n, n);
% x  = zeros(fine_m, fine_n, n);
% y  = zeros(fine_m, fine_n, n);
% 
% for i = 1:n
%         pt = phase(:, (1+(i-1)*shift):(k+(i-1)*shift));
%         xt = xx(:, (1+(i-1)*shift):(k+(i-1)*shift));
%         yt = yy(:, (1+(i-1)*shift):(k+(i-1)*shift));
%         l = size(pt, 2);
%         w = size(pt, 1);
% 
%         [Xq,Yq] = meshgrid(linspace(1,l, fine_n), linspace(1,w, fine_m));
%         [X,Y]   = meshgrid(1:l, 1:w);
% 
%         WF(:, :, i) = interp2(X, Y, pt, Xq, Yq, 'cubic');
%         x(:, :, i)  = interp2(X, Y, xt, Xq, Yq, 'cubic');
%         y(:, :, i)  = interp2(X, Y, yt, Xq, Yq, 'cubic');
%         
% 
%     if(mod(i, 1000) == 0)
%         fprintf('\n 20 - %d \n', i);
%     end
% end
% 
% 
% %
% [WF_ttpRem_20, TTP_20] = removeTTP(WF, x, y);
% x_20         = x;
