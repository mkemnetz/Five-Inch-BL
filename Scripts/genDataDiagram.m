%%
close all

figure(); 
set(gcf,'units','centimeters','position',[0 0 1.2*8 8]);
surf(x_Final_m(:, :, 1), y_Final_m(:, :, 1), phase_Final_m(:, :, 1), 'EdgeColor', 'none'); 
view(2); 
colormap jet; 
daspect([1/2, 1, 1]);
pbaspect([210.8976, 125, 4.6205]);

% figure(); 
% set(gcf,'units','centimeters','position',[0 0 1.2*8 8]);
% surf(x_Final_m(:, :, 1), y_Final_m(:, :, 1), phase_Final_m(:, :, 1), 'EdgeColor', 'none'); 
% view(2); 
% colormap jet; 
% axis equal;
% 
% figure(); 
% set(gcf,'units','centimeters','position',[0 0 1.2*8 8]);
% surf(x_Final_m(:, :, 1), y_Final_m(:, :, 1), phase_Final_m(:, :, 1), 'EdgeColor', 'none'); 
% view(2); 
% colormap jet; 
% daspect([1, 1, 1]);
% p = pbaspect;
