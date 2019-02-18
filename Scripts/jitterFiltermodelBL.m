%%
clearvars;
close all;
clc;

multiWaitbar( 'CloseAll' );
multiWaitbar( 'Overall Progress', 0 , 'Color', 'b');

%%
exp        = load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/experimental_jitter_BL2.mat');
stitch     = load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/stitch_jitter_BL2.mat');
adam_model = load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/adam_model.mat');
%% Filter
zz = 0:0.01:5;
gg = G(zz);

figure()
plot(zz, gg)
hold on;
plot(zz, sinc(zz))
grid on;

%%
figure();
semilogy(exp.Ap, exp.jitter, '-bx');
hold on
semilogy(stitch.Ap, stitch.jitter, '-rx');
xlabel('$Ap/\Lambda$', 'interpreter', 'latex');

%% Adam's spectra
St_d = logspace(-2, 1, 10000);
theta_modeled = model(St_d, 5e-5);

figure();
loglog(St_d, theta_modeled);
hold on;
loglog(adam_model.St_d, adam_model.jitter, 'rx');
xlim([0.05 10]);
ylim([1e-6 1e-4]);

delta           = 0.24;
theta_modeled_filtered1  = theta_modeled.*(Gst(1*delta, St_d, delta)).^2;
theta_modeled_filtered3  = theta_modeled.*(Gst(3*delta, St_d, delta)).^2;
theta_modeled_filtered5  = theta_modeled.*(Gst(5*delta, St_d, delta)).^2;

figure();
set(gcf,'PaperUnits', 'centimeters','PaperPosition', [0 0 10 6], 'PaperSize', [10 6]);
set(gcf,'Units', 'centimeters','Position', [0 0 10 6]);
loglog(St_d, theta_modeled, '-b');
hold on;
loglog(St_d, theta_modeled_filtered1, '-.r');
loglog(St_d, theta_modeled_filtered3, '--g');
loglog(St_d, theta_modeled_filtered5, ':k');
xlim([0.05 10]);
ylim([1e-6 4e-5]);
grid on;

xlabel('$St$', 'interpreter', 'latex');
ylabel('$\hat{\theta}$', 'Interpreter', 'Latex');
hleg = legend({'Empiracally Fit $\hat{\theta}$', '$Ap/\delta = 1$', '$Ap/\delta = 3$', '$Ap/\delta = 5$'}, 'Location','northwest');
set(hleg, 'interpreter', 'latex');
set(hleg, 'location', 'southeast');


%% Adam's spectra (frequency space)
f                        = 0:1:1e5;
theta_modeled_f          = (modelf(f, 1));
theta_modeled_filtered_f = theta_modeled_f.*(Gf(1, f, 0.8*machToVel(0.4, 70)));

figure();
semilogy(f, theta_modeled_f);
hold on;
semilogy(f, theta_modeled_filtered_f.^2);

delta           = 0.24;
Ap              = 0:1e-3:25*delta;

jitter_rms_f      = zeros(1, length(Ap));
for i = 1:length(Ap)
    if (mod(i, 100) == 0)
        multiWaitbar( 'Overall Progress', 'Value', i/length(Ap) );
    end
    theta_modeled_filtered_f  = theta_modeled_f.*(Gf(Ap(i), f, 0.8*machToVel(0.4, 70)));
    jitter_rms_f(1, i) = sqrt(sum(theta_modeled_filtered_f.^2));
end

%%
z = Ap./delta;
x = jitter_rms_f(z > 1.024 & z < 1.026)./exp.jitter(1);
xx = mean(x);
figure();
set(gcf,'units','normalized','position',[0 0.56 0.145 0.21]);
semilogy(stitch.Ap, stitch.jitter, 'b-+');
hold on
semilogy(exp.Ap, exp.jitter, 'g--+', 'LineWidth', 2);
semilogy(z, ((1/xx).*(jitter_rms_f)), 'r-.','LineWidth', 2);
xlabel('$Ap/\delta$', 'interpreter', 'latex');
ylabel('$\frac{\theta_{rms}}{(\rho_{\infty}/\rho_{SL}) \cdot M^2 + (\Delta T/T_{\infty})}$', 'Interpreter', 'Latex');
title('Normalized $\theta_{rms}$ vs $Ap$', 'interpreter', 'latex');
hleg = legend('Stitching Method', 'Experimental', 'Filter Model');
set(hleg, 'interpreter', 'latex');
% hold on;
% loglog(adam_model.St_d, adam_model.jitter, 'rx');
% xlim([0.05 10]);
% ylim([1e-6 1e-4]);
% %%
% delta           = 0.24;
% Ap              = 0:1e-3:20*delta;
% 
% jitter_rms      = zeros(1, length(Ap));
% for i = 1:length(Ap)
%     theta_modeled_filtered  = theta_modeled.*(Gst(Ap(i), St_d, delta)).^2;
%     jitter_rms(1, i) = psdToRms((theta_modeled_filtered), length(theta_modeled_filtered), 1);
% end
% 
% figure();
% semilogy(exp.Ap, exp.jitter, '-bx');
% hold on
% semilogy(stitch.Ap, stitch.jitter, '-rx');
% semilogy(Ap./delta, 8e-4*jitter_rms, '-gx');
% xlabel('$Ap/\delta$', 'interpreter', 'latex');
% 
% %%
% BLdata = load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/11-31/F1/F1_2.mat', 'ThX', 'ThY');
% fiveInch = BLdata.ThX(17, 32, :);
% deltaFiveInch = 0.0156;
% [Sxx, freq] = psdfun(fiveInch, length(fiveInch)/5, 40307);
% 
% figure()
% loglog((freq.*deltaFiveInch)./machToVel(0.2, 78.4), Sxx);
% 
% 
% Ap              = 0:1e-3:20*deltaFiveInch;  
% jitter_rms_fiveInch      = zeros(1, length(Ap));
% for i = 1:length(Ap)
%     theta_modeled_filtered_fiveInch  = Sxx.*(Gst(Ap(i), (freq.*deltaFiveInch)./machToVel(0.2, 78.4), deltaFiveInch)).^2;
%     jitter_rms_fiveInch(1, i) = psdToRms((theta_modeled_filtered_fiveInch), length(fiveInch)/5, 40307);
% end
% 
% figure();
% semilogy(exp.Ap, exp.jitter, '-bx');
% hold on
% semilogy(stitch.Ap, stitch.jitter, '-rx');
% semilogy(Ap./deltaFiveInch, 8e-4*jitter_rms_fiveInch, '-gx');
% xlabel('$Ap/\delta$', 'interpreter', 'latex');

%% 
function g = G(z)
% G Filter function.

%    g = (z == 0).*1 + (z > 0).*((3*(sin(pi.*z)-pi.*z.*cos(pi.*z)))./(pi.*z).^3);
   g = ((3*(sin(pi.*z)-pi.*z.*cos(pi.*z)))./(pi.*z).^3);
   g(z == 0) = 1;
   

end

function z = Zst(Ap, St, delta)
% Z z definition.

    z = (Ap./delta).*St*1.20;
end


function gst = Gst(Ap, St, delta)
% Gf Composite function.

    gst = G(Zst(Ap, St, delta));
end

%%
function z = Zf(Ap, f, Uc)
% Z z definition.

    z = (Ap.*f)./Uc;
end

function gf = Gf(Ap, f, Uc)
% Gf Composite function.

    gf = G(Zf(Ap, f, Uc));
end

%%
function theta = model(St, thetaPeak)
% Gf Composite function.

    theta = St./(1+(St/0.75).^(5/3));
    theta = theta.*thetaPeak;
    
end

function theta = modelf(f, thetaPeak)
% Gf Composite function.
    
    delta = 0.24;
    Uinf  = machToVel(0.4, 70);
    St    = (f.*delta)./Uinf;
    theta = St./(1+(St/0.75).^(5/3));
    theta = theta.*thetaPeak;
    
end