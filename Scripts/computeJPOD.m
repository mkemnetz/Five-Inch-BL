%%
JPOD = cat(3, cat(3, cat(3, data.zero.phase, data.one.phase), data.two.phase), data.three.phase);
[ POD_Modes, Time_Coeff, energy ] = computePOD( JPOD );

%%
cumEnergy = cumsum(energy);

figure();
set(gcf,'units','centimeters','position',[0 0 1.2*8 8]);
plot(1:Nmodes_plot, energy(1:Nmodes_plot), '-o');
hold on;
plot(1:Nmodes_plot, cumEnergy(1:Nmodes_plot), '-o');
xlabel('Mode Number', 'interpreter', 'latex'); 
hleg = legend('Normalized Eigenvalues', 'Cumulative Eigenvalues');
hleg.Interpreter  = 'latex';
hleg.Location     = 'southeast';
grid on;
grid minor;


