%%
TTP_1_th  = (TTP_1(1, :)/(10^6));
TTP_3_th  = (TTP_3(1, :)/(10^6));
TTP_5_th  = (TTP_5(1, :)/(10^6));
TTP_20_th = TTP_5_th;
% TTP_20_th = (TTP_20(1, :)/(10^6));

%% Jitter_rms vs. Aperture
rho_sl = 1.225;
rho_inf = 1.2;
M = 0.5;

cons = (rho_inf/rho_sl)*(M^2);
x = [1 3 5 20];
y = [rms(TTP_1_th)./cons rms(TTP_3_th)./cons rms(TTP_5_th)./cons rms(TTP_20_th)./cons];

figure();
set(gcf,'units','centimeters','position',[0 0 1.2*8 8]);
AX = semilogy(x, y, '-x');

% h = legend('$Ap/\delta \approx 1.00$', '$Ap/\delta \approx 3.00$', ...
%     '$Ap/\delta \approx 5.00$', '$Ap/\delta \approx 20.00$', 'Normal Distribution: $\mu = 0.00$, $\sigma = 1$' , 'location', 'northeast');
% set(h,'Interpreter','Latex');
xlabel('$Ap/\delta$', 'Interpreter','Latex');
ylabel('$\frac{\theta_{rms}}{(\rho_{\infty}/\rho_{SL}) \cdot M^2}$', 'Interpreter', 'Latex');
title('Normalized $\theta_{rms}$ vs Aperture', 'Interpreter', 'Latex');

