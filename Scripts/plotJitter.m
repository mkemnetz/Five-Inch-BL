if and(exist('data_flag','var') == 0, exist('TTP_store','var') == 0)
    error('data_flag variable is missing.  This variable is nececessary to know which data to load.');
end
if exist('TTP_store','var') == 0
    if (data_flag == 1)
        load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/Main Data/10-31 Data/TTP.mat')         % 10-31 Data
    elseif (data_flag == 2)
        load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/Main Data/11-31 Data Small/TTP.mat');  % 11-31 Data Small
    elseif(data_flag == 3)
        load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/Main Data/11-31 Data Full/TTP.mat');   % 11-31 Data Full
    else
        error('Unsupported data_flag');
    end
end

%%
delta = 0.0156;
TTP_1 = TTP_store.one;
TTP_2 = TTP_store.two;
TTP_3 = TTP_store.three;
TTP_4 = TTP_store.four;
TTP_5 = TTP_store.five;
TTP_6 = TTP_store.six;

% TTP_1_th  = atan((TTP_1(1, :)/(10^6))./(delta));
% TTP_2_th  = atan((TTP_2(1, :)/(10^6))./(2*delta));
% TTP_3_th  = atan((TTP_3(1, :)/(10^6))./(3*delta));
% TTP_4_th  = atan((TTP_4(1, :)/(10^6))./(4*delta));
% TTP_5_th  = atan((TTP_5(1, :)/(10^6))./(5*delta));
% TTP_6_th  = atan((TTP_6(1, :)/(10^6))./(6*delta));
TTP_1_th  = (TTP_1(1, :)/(10^6));
TTP_2_th  = (TTP_2(1, :)/(10^6));
TTP_3_th  = (TTP_3(1, :)/(10^6));
TTP_4_th  = (TTP_4(1, :)/(10^6));
TTP_5_th  = (TTP_5(1, :)/(10^6));
TTP_6_th  = (TTP_6(1, :)/(10^6));

%% Jitter PDF
[N1,edges1] = histcounts(TTP_1_th./rms(TTP_1_th), 20);
[N2,edges2] = histcounts(TTP_2_th./rms(TTP_2_th), 20);
[N3,edges3] = histcounts(TTP_3_th./rms(TTP_3_th), 20);
[N4,edges4] = histcounts(TTP_4_th./rms(TTP_4_th), 20);
[N5,edges5] = histcounts(TTP_5_th./rms(TTP_5_th), 20);
[N6,edges6] = histcounts(TTP_6_th./rms(TTP_6_th), 20);
x1          = 0.5 * (edges1(1:end-1) + edges1(2:end));
x2          = 0.5 * (edges2(1:end-1) + edges2(2:end));
x3          = 0.5 * (edges3(1:end-1) + edges3(2:end));
x4          = 0.5 * (edges4(1:end-1) + edges4(2:end));
x5          = 0.5 * (edges5(1:end-1) + edges5(2:end));
x6          = 0.5 * (edges6(1:end-1) + edges6(2:end));
normX       = -3:0.001:3;



figure();
set(gcf,'units','centimeters','position',[0 0 1.2*8.5 8.5]);
plot(x1,N1/size(TTP_1_th, 2)/diff(x1(1:2)), '-')
hold on;
plot(x2,N2/size(TTP_2_th, 2)/diff(x2(1:2)), '-')
plot(x3,N3/size(TTP_3_th, 2)/diff(x3(1:2)), '-o')
plot(x4,N4/size(TTP_4_th, 2)/diff(x4(1:2)), '-o')
plot(x5,N5/size(TTP_5_th, 2)/diff(x5(1:2)), '-x')
plot(x6,h6.N6/size(TTP_6_th, 2)/diff(x6(1:2)), '-x')
plot(normX,normpdf(normX,0,1), 'LineWidth',2)


xlim([-4 10]);
h = legend('$Ap/\delta \approx 1.00$', '$Ap/\delta \approx 2.00$', ...
    '$Ap/\delta \approx 3.00$', '$Ap/\delta \approx 4.00$', '$Ap/\delta \approx 5.00$', '$Ap/\delta \approx 6.00$', sprintf( '%s\n%s', 'Normal Distribution:', '$\mu = 0.00$, $\sigma = 1.00$' ) , 'location', 'northeast');
set(h,'Interpreter','Latex');
xlabel('$\theta/\theta_{rms}$', 'Interpreter','Latex');
ylabel('PDF', 'Interpreter', 'Latex');
title('PDF of Aero-Optical Jitter, $\theta_x$','Interpreter','Latex');

%% Jitter_rms vs. Aperture
load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/Main Data/11-31 Data Full/jitter_stitch.mat');

rho_sl = 1.225;
rho_inf = 1.2;
M = 0.2;

data_jitter.one.x(1, end)

cons = (rho_inf/rho_sl)*((M^2)+2.2*(25/298.9833));
a= rms(TTP_6_th)./cons;
x = [data_jitter.one.x(1, end) data_jitter.two.x(1, end) ...
    data_jitter.three.x(1, end) data_jitter.four.x(1, end) ...
    data_jitter.five.x(1, end) data_jitter.six.x(1, end)];
y = [rms(TTP_1_th)./cons rms(TTP_2_th)./cons rms(TTP_3_th)./cons rms(TTP_4_th)./cons rms(TTP_5_th)./cons rms(TTP_6_th)./cons] - a;

figure();
set(gcf,'units','centimeters','position',[0 0 1.2*8 8]);
AX = semilogy(x, y, '-x');
hold on;
semilogy(xdata_stitch, ydata_stitch, '-x');

h = legend('Experimental Data', 'Stitching Method', 'location', 'northeast');
set(h,'Interpreter','Latex');
xlabel('$Ap/\delta$', 'Interpreter','Latex');
ylabel('$\frac{\theta_{rms}}{(\rho_{\infty}/\rho_{SL}) \cdot (M^2+(\Delta T/T_\infty))}$', 'Interpreter', 'Latex');
title('Normalized $\theta_{rms}$ vs Aperture', 'Interpreter', 'Latex');
