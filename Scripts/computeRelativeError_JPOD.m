%%
totalModes  = 558;
searchRange1 = 4:15;
searchRange2 = 4:24;
searchRange3 = 11:31;
searchRange4 = 18:38;
separation1  = 1;
separation2  = 2;
separation3  = 3;
separation4  = 4;

M_inf = 0.2;
T_t   = 78.4;
fsamp = 40300;

%%
modeNumber = 1;

s = sprintf('Mode Number: %i', modeNumber);
figure(); 
set(gcf,'units','centimeters','position',[0 0 1.2*8 8]);
plot([1:200], a_n_zero(1:200, modeNumber), [1:200], a_n_one([1:200]+7, modeNumber)); 
xlabel('$t$', 'interpreter', 'latex'); 
ylabel('$a_n$', 'interpreter', 'latex'); 
hleg = legend('$a_n^0 $', '$a_n^1$');
hleg.Interpreter  = 'latex';
hleg.Location     = 'southwest';
hleg.Title.String = s; 

%%
epsilon1 = zeros(length(0:100), length(1:totalModes));
epsilon2 = zeros(length(0:100), length(1:totalModes));
epsilon3 = zeros(length(0:100), length(1:totalModes));
epsilon4 = zeros(length(0:100), length(1:totalModes));

lambda_n = zeros(1, length(1:totalModes));
for tau = 1:100
   for n = 1:totalModes
       aZero  = a_n_zero(1:end-100, n);
       aOne   = a_n_one(1+tau:end-100+tau, n);
       aTwo   = a_n_two(1+tau:end-100+tau, n);
       aThree = a_n_three(1+tau:end-100+tau, n);
       aFour  = a_n_four(1+tau:end-100+tau, n);
       
       num1 = (1/length(aZero))*sum((aZero - aOne).^2);
       num2 = (1/length(aZero))*sum((aZero - aTwo).^2);
       num3 = (1/length(aZero))*sum((aZero - aThree).^2);
       num4 = (1/length(aZero))*sum((aZero - aFour).^2);
       
       lambdaZero  = sqrt((1/length(aZero))*sum(aZero.^2));
       lambdaOne   = sqrt((1/length(aOne))*sum(aOne.^2));
       lambdaTwo   = sqrt((1/length(aTwo))*sum(aTwo.^2));
       lambdaThree = sqrt((1/length(aThree))*sum(aThree.^2));
       lambdaFour  = sqrt((1/length(aFour))*sum(aFour.^2));
       
       den1 = lambdaZero*lambdaOne;
       den2 = lambdaZero*lambdaTwo;
       den3 = lambdaZero*lambdaThree;
       den4 = lambdaZero*lambdaFour;
       
       epsilon1(tau, n) = num1/den1;
       epsilon2(tau, n) = num2/den2;
       epsilon3(tau, n) = num3/den3;
       epsilon4(tau, n) = num4/den4;
       
   end
end

%%
figure();
plot(epsilon1(9, :));
title('Error');

%%
minError1 = zeros(3, length(1:totalModes));
minError2 = zeros(3, length(1:totalModes));
minError3 = zeros(3, length(1:totalModes));
minError4 = zeros(3, length(1:totalModes));

for k = 1:totalModes
    [minError1(2,k),minError1(1,k)]  = min(epsilon1(searchRange1, k));
    [minError2(2,k),minError2(1,k)]  = min(epsilon2(searchRange2, k));
    [minError3(2,k),minError3(1,k)]  = min(epsilon3(searchRange3, k));
    [minError4(2,k),minError4(1,k)]  = min(epsilon4(searchRange4, k));
    
    index1 = searchRange1;
    index2 = searchRange2;
    index3 = searchRange3;
    index4 = searchRange4;
    
    xpeak1 = index1(minError1(1,k));
    xpeak2 = index2(minError2(1,k));
    xpeak3 = index3(minError3(1,k));
    xpeak4 = index4(minError4(1,k));
    
    minError1(1,k) = xpeak1;
    minError2(1,k) = xpeak2;
    minError3(1,k) = xpeak3;
    minError4(1,k) = xpeak4;
    
    x1 = xpeak1-2:xpeak1+2;
    x2 = xpeak2-2:xpeak2+2;
    x3 = xpeak3-2:xpeak3+2;
    x4 = xpeak4-2:xpeak4+2;
    
    y1 = epsilon1(x1, k)';
    y2 = epsilon2(x2, k)';
    y3 = epsilon3(x3, k)';
    y4 = epsilon4(x4, k)';
    
    [p1, ~, mu1] = polyfit(x1, y1, 2);
    [p2, ~, mu2] = polyfit(x2, y2, 2);
    [p3, ~, mu3] = polyfit(x3, y3, 2);
    [p4, ~, mu4] = polyfit(x4, y4, 2);
    
    x1 = xpeak1-2:0.01:xpeak1+2;
    x2 = xpeak2-2:0.01:xpeak2+2;
    x3 = xpeak3-2:0.01:xpeak3+2;
    x4 = xpeak4-2:0.01:xpeak4+2;
    
    y1 = polyval(p1,x1, [], mu1);
    y2 = polyval(p2,x2, [], mu2);
    y3 = polyval(p3,x3, [], mu3);
    y4 = polyval(p4,x4, [], mu4);
    
    [~,index1] = min(y1, [], 2);
    [~,index2] = min(y2, [], 2);
    [~,index3] = min(y3, [], 2);
    [~,index4] = min(y4, [], 2);
    
    xpeak1 = x1(index1);
    xpeak2 = x2(index2);
    xpeak3 = x3(index3);
    xpeak4 = x4(index4);
    
    minError1(3, k) = (separation1*0.0156)/(xpeak1*machToVel(M_inf, T_t)*(1/fsamp));
    minError2(3, k) = (separation2*0.0156)/(xpeak2*machToVel(M_inf, T_t)*(1/fsamp));
    minError3(3, k) = (separation3*0.0156)/(xpeak3*machToVel(M_inf, T_t)*(1/fsamp));
    minError4(3, k) = (separation4*0.0156)/(xpeak4*machToVel(M_inf, T_t)*(1/fsamp));
     
%     minError(1,k) = (3.32*0.0156)/(minError(1,k)*machToVel(0.6135, 75)*(1/77064));
end

%%
figure()
set(gcf,'units','centimeters','position',[0 0 1.2*8 8]);
plot([1:totalModes],minError1(3, :))
hold on;
plot([1:totalModes],minError2(3, :))
plot([1:totalModes],minError3(3, :))
plot([1:totalModes],minError4(3, :))


axis([3 100 0.8 1.03]);
grid on;
grid minor;
% ax = gca;
% ax.YTick = 0.85:0.025:1;

title('Mode Number vs. $Uc/U_\infty$', 'interpreter', 'latex'); 
xlabel('Mode Number', 'interpreter', 'latex'); 
ylabel('$Uc/U_\infty$', 'interpreter', 'latex'); 
hleg = legend('$1 \delta$', '$2 \delta$', '$3 \delta$', '$4 \delta$');
hleg.Interpreter  = 'latex';
hleg.Location     = 'northwest';
hleg.Title.String = 'Separation'; 
grid on;
grid minor;

% title('Minimum Error (Varrying Uc)')

% figure()
% histogram(minError(1, :))

%%
Uc1 = mean(minError1(3, 1:100));
Uc2 = mean(minError2(3, 1:100));
Uc3 = mean(minError3(3, 1:100));
Uc4 = mean(minError4(3, 1:100));

tau1 = round(((Uc1/(separation1*0.0156))*(machToVel(M_inf, T_t)*(1/fsamp)))^(-1));
tau2 = round(((Uc2/(separation2*0.0156))*(machToVel(M_inf, T_t)*(1/fsamp)))^(-1));
tau3 = round(((Uc4/(separation3*0.0156))*(machToVel(M_inf, T_t)*(1/fsamp)))^(-1));
tau4 = round(((Uc4/(separation4*0.0156))*(machToVel(M_inf, T_t)*(1/fsamp)))^(-1));

NModes = 150;
figure()
set(gcf,'units','centimeters','position',[0 0 1.2*8 8]);
plot(1:NModes, epsilon1(tau1, 1:NModes))
hold on;
plot(1:NModes, epsilon2(tau2, 1:NModes))
plot(1:NModes, epsilon3(tau3, 1:NModes))
plot(1:NModes, epsilon4(tau4, 1:NModes))

s1 = sprintf('= %0.3f $', Uc1); 
s2 = sprintf('= %0.3f $', Uc2); 
s3 = sprintf('= %0.3f $', Uc3); 
s4 = sprintf('= %0.3f $', Uc4);
titleString = sprintf('first %i modes', NModes);

title(['Minimum Relative for Fixed $Uc/U_\infty$, ' titleString], 'interpreter', 'latex'); 
xlabel('Mode Number', 'interpreter', 'latex'); 
ylabel('Min Relative Error, $\epsilon_n$', 'interpreter', 'latex'); 
hleg = legend(['$1 \delta$, $\frac{Uc}{U_\infty} ' s1], ['$2 \delta$, $\frac{Uc}{U_\infty} ' s2], ['$3 \delta$, $\frac{Uc}{U_\infty} ' s3], ['$4 \delta$, $\frac{Uc}{U_\infty} ' s4]);
hleg.Interpreter  = 'latex';
hleg.Location     = 'northeast';
hleg.Title.String = 'Separation'; 
grid on;
grid minor;

%%
NModes = 25;
figure()
set(gcf,'units','centimeters','position',[0 0 1.2*8 8]);
plot(1:NModes, epsilon1(tau1, 1:NModes))
hold on;
plot(1:NModes, epsilon2(tau2, 1:NModes))
plot(1:NModes, epsilon3(tau3, 1:NModes))
plot(1:NModes, epsilon4(tau4, 1:NModes))

s1 = sprintf('= %0.3f $', Uc1); 
s2 = sprintf('= %0.3f $', Uc2); 
s3 = sprintf('= %0.3f $', Uc3); 
s4 = sprintf('= %0.3f $', Uc4); 
titleString = sprintf('first %i modes', NModes);

title(['Minimum Relative for Fixed $Uc/U_\infty$, ' titleString], 'interpreter', 'latex'); 
xlabel('Mode Number', 'interpreter', 'latex'); 
ylabel('Min Relative Error, $\epsilon_n$', 'interpreter', 'latex'); 
hleg = legend(['$1 \delta$, $\frac{Uc}{U_\infty} ' s1], ['$2 \delta$, $\frac{Uc}{U_\infty} ' s2], ['$3 \delta$, $\frac{Uc}{U_\infty} ' s3], ['$4 \delta$, $\frac{Uc}{U_\infty} ' s4]);
hleg.Interpreter  = 'latex';
hleg.Location     = 'northeast';
hleg.Title.String = 'Separation'; 
grid on;
grid minor;


