clear all
close all

%%
load('/Volumes/LaCie/MATLAB/Research/Boundary Layer Analysis/Streamwise Split/Data/Processed/Kemnetz/FiltWF1-2_52mm/combined_filtered.mat')
% load('/Volumes/LaCie/MATLAB/Research/Boundary Layer Analysis/Streamwise Split/Data/Processed/Kemnetz/FiltWF1-2_52mm/combined.mat');
% load('/Volumes/LaCie/MATLAB/Research/Boundary Layer Analysis/Streamwise Split/Data/Processed/Kemnetz/FiltWF1-4_52mm/combined-4.mat')

[m, n, t]        = size(smallerPhase_L);
smallerPhase_L   = squeeze(mat2cell(smallerPhase_L, m, n, ones(1,t)))';

[m, n, t]        = size(smallerPhase_R);
smallerPhase_R   = squeeze(mat2cell(smallerPhase_R, m, n, ones(1,t)))';

%%
Stitch_params
%%
[phase_L] = refineWF_2( smallerPhase_L, [2, 20, 2, 19], params);
[phase_R] = refineWF_2( smallerPhase_R, [2, 20, 2, 19], params);

%%
OPDrms = zeros(1, params.N);
for i = 1:params.N
    temp = reshape( phase_L{i}   , 1, numel(phase_L{i}));
    OPDrms(i) = rms(temp);
end

OPDrms = mean(OPDrms);


%%
e2         = zeros(2, 100);
N          = params.N;
for i = 1:100
    delay       = i;
    
    error = zeros(1, N-delay);
    index = 1;
    for k = 1:N-delay
        A = phase_L{k};
        B = phase_R{k+delay};

%         diff  = abs(A-B);
%         temp  = reshape(diff, 1, numel(diff));
% 
%         error(index) = rms(temp)./OPDrms;
        diff  = A-B;
        temp  = reshape(diff, 1, numel(diff));

        error(index) = std(temp)./OPDrms;

        index = index+1;
    end
    e2(2, i) = mean(error(1, :));
    e2(1, i) = (3.32*0.0156)/(i*machToVel(0.6135, 75)*(1/77064));
end
%%
figure();  
plot(e2(1, :), e2(2, :)); 
axis([0.6 1.2 0.90 1.35]); 
title('Error vs. $Uc/U_\infty$', 'interpreter', 'latex'); 
xlabel('$Uc/U_\infty$', 'interpreter', 'latex'); 
ylabel('$\frac{\epsilon}{OPD_{rms}}$', 'interpreter', 'latex'); 
grid on;

%%
clearvars -except e2
load('/Volumes/LaCie/MATLAB/Research/Boundary Layer Analysis/Streamwise Split/Data/Processed/Kemnetz/FiltWF1-2_52mm/combined.mat');

%%
[m, n, t]        = size(smallerPhase_L);
smallerPhase_L   = squeeze(mat2cell(smallerPhase_L, m, n, ones(1,t)))';

[m, n, t]        = size(smallerPhase_R);
smallerPhase_R   = squeeze(mat2cell(smallerPhase_R, m, n, ones(1,t)))';

%%
Stitch_params
%%
[phase_L] = refineWF_2( smallerPhase_L, [2, 20, 2, 19], params);
[phase_R] = refineWF_2( smallerPhase_R, [2, 20, 2, 19], params);

%%
OPDrms = zeros(1, params.N);
for i = 1:params.N
    temp = reshape( phase_L{i}   , 1, numel(phase_L{i}));
    OPDrms(i) = rms(temp);
end

OPDrms = mean(OPDrms);


%%
e3         = zeros(2, 100);
N          = params.N;
for i = 1:100
    delay       = i;
    
    error = zeros(1, N-delay);
    index = 1;
    for k = 1:N-delay
        A = phase_L{k};
        B = phase_R{k+delay};

%         diff  = abs(A-B);
%         temp  = reshape(diff, 1, numel(diff));
% 
%         error(index) = rms(temp)./OPDrms;
        diff  = A-B;
        temp  = reshape(diff, 1, numel(diff));

        error(index) = std(temp)./OPDrms;

        index = index+1;
    end
    e3(2, i) = mean(error(1, :));
    e3(1, i) = (3.32*0.0156)/(i*machToVel(0.6135, 75)*(1/77064));
end

%%
figure(); 
set(gcf,'units','centimeters','position',[0 0 1.2*8 8]);
plot(e2(1, :), e2(2, :)); 
% hold on
% plot(e3(1, :), e3(2, :)); 
axis([0.7 1.2 0.50 2.5]); 
title('Error vs. $Uc/U_\infty$', 'interpreter', 'latex'); 
xlabel('$Uc/U_\infty$', 'interpreter', 'latex'); 
ylabel('$\frac{\epsilon}{OPD_{rms}}$', 'interpreter', 'latex'); 
grid on;
grid minor;

% legend('Filtered', 'Unfiltered');
% %%
% e3         = zeros(2, 100);
% N          = params.N;
% for i = 1:100
%     delay       = i;
%     
%     error = zeros(1, N-delay);
%     index = 1;
%     for k = 1:N-delay
%         A = smallerPhase_L{k};
%         B = smallerPhase_R{k+delay};
% 
% %         diff  = abs(A-B);
% %         temp  = reshape(diff, 1, numel(diff));
% % 
% %         error(index) = rms(temp)./OPDrms;
%         diff  = A-B;
%         temp  = reshape(diff, 1, numel(diff));
% 
%         error(index) = std(temp)./OPDrms;
% 
%         index = index+1;
%     end
%     e3(2, i) = mean(error(1, :));
%     e3(1, i) = (3.32*0.0156)/(i*machToVel(0.6135, 75)*(1/77064));
% end
