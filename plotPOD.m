podplot = figure;
subplot(2,2,1);
imagesc(POD_Modes(:,:,1));
%     axis equal;
    axis tight;
% title(['Mode 1, Energy = ' num2str(energy(1))]);

subplot(2,2,2);
imagesc(POD_Modes(:,:,2));
%     axis equal;
    axis tight;
%     axis off;
% title(['Mode 2, Energy = ' num2str(energy(2))]);

% subplot(2,2,3);
% loglog(freq,apsds(:,1));
% grid on;
% xlabel('Frequency (kHz)');
% ylabel('Amplitude Spectra');
% xlim([10^-2, 10]);
% ylim([1,10^5]);
% 
% subplot(2,2,4);
% loglog(freq,apsds(:,2));
% grid on;
% xlabel('Frequency (kHz)');
% ylabel('Amplitude Spectra');
% xlim([10^-2, 10]);
% ylim([1,10^5]);

%%
close all;

N = 20;
% for i = 1:N
%     figure(i); 
%     surf(POD_Modes(:,:,i), 'EdgeColor', 'none');
%     view(2);
%     colormap jet;
% end

figure();

for i = 1:N
    subplot(5,4,i);
    surf(POD_Modes(:,:,i), 'EdgeColor', 'none');
    view(2);
    colormap jet;
%     axis equal;
    axis tight;
%     axis off;
    title(['Mode: ' num2str(i)]);

end

cum_energy = cumsum(energy);

figure()
plot(1:30, cum_energy(1:30));
xlim([1 30]);
ylim([0 1]);
title('Cumulative Energy');
xlabel('Number of modes');
