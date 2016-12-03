%%
M_inf = 0.2;
T_t   = 78.4;
fsamp = 40300;

%%
params.N    = 1000;
params.fine = 200;
[ dataZeroPOD.x,  dataZeroPOD.y,   dataZeroPOD.phase ] = refineWF2( WF_zero,  data.zero.x,  data.zero.y,  params);
[ dataOnePOD.x,   dataOnePOD.y,   dataOnePOD.phase   ] = refineWF2( WF_one,   data.one.x,   data.one.y,   params);
[ dataTwoPOD.x,   dataTwoPOD.y,   dataTwoPOD.phase   ] = refineWF2( WF_two,   data.two.x,   data.two.y,   params);
[ dataThreePOD.x, dataThreePOD.y, dataThreePOD.phase ] = refineWF2( WF_three, data.three.x, data.three.y, params);
[ dataFourPOD.x,  dataFourPOD.y,  dataFourPOD.phase  ] = refineWF2( WF_four,  data.four.x,  data.four.y,  params);

%%
phase_L_POD  = dataZeroPOD.phase;
phase_R1_POD = dataOnePOD.phase;
phase_R2_POD = dataTwoPOD.phase;
phase_R3_POD = dataThreePOD.phase;
phase_R4_POD = dataFourPOD.phase;

%%
OPDrms = zeros(1, params.N);
for i = 1:params.N
    temp1 = reshape( phase_L_POD(:, :, i)   , 1, numel(phase_L_POD(:, :, i)));
    OPDrms(i) = rms(temp1);
end

OPDrms = mean(OPDrms);


%%
e2_1_POD         = zeros(2, 100);
e2_2_POD         = zeros(2, 100);
e2_3_POD         = zeros(2, 100);
e2_4_POD         = zeros(2, 100);
N                = params.N;
for i = 1:100
    delay       = i;
    
    error1 = zeros(1, N-delay);
    error2 = zeros(1, N-delay);
    error3 = zeros(1, N-delay);
    error4 = zeros(1, N-delay);
    index = 1;
    for k = 1:N-delay
        A = phase_L_POD(:, :, k);
        B1 = phase_R1_POD(:, :, k+delay);
        B2 = phase_R2_POD(:, :, k+delay);
        B3 = phase_R3_POD(:, :, k+delay);
        B4 = phase_R4_POD(:, :, k+delay);

%         diff  = abs(A-B);
%         temp  = reshape(diff, 1, numel(diff));
% 
%         error(index) = rms(temp)./OPDrms;
        diff1  = A-B1;
        diff2  = A-B2;
        diff3  = A-B3;
        diff4  = A-B4;
        temp1  = reshape(diff1, 1, numel(diff1));
        temp2  = reshape(diff2, 1, numel(diff2));
        temp3  = reshape(diff3, 1, numel(diff3));
        temp4  = reshape(diff4, 1, numel(diff4));

        error1(index) = std(temp1)./OPDrms;
        error2(index) = std(temp2)./OPDrms;
        error3(index) = std(temp3)./OPDrms;
        error4(index) = std(temp4)./OPDrms;

        index = index+1;
    end
    e2_1_POD(2, i) = mean(error1(1, :));
    e2_1_POD(1, i) = (1*0.0156)/(i*machToVel(M_inf, T_t)*(1/fsamp));
    
    e2_2_POD(2, i) = mean(error2(1, :));
    e2_2_POD(1, i) = (2*0.0156)/(i*machToVel(M_inf, T_t)*(1/fsamp));
    
    e2_3_POD(2, i) = mean(error3(1, :));
    e2_3_POD(1, i) = (3*0.0156)/(i*machToVel(M_inf, T_t)*(1/fsamp));
    
    e2_4_POD(2, i) = mean(error4(1, :));
    e2_4_POD(1, i) = (4*0.0156)/(i*machToVel(M_inf, T_t)*(1/fsamp));
end

%%
s = sprintf('first %i modes', NumberOfModes);
figure();
set(gcf,'units','centimeters','position',[0 0 1.2*8 8]);
plot(e2_1_POD(1, :), e2_1_POD(2, :)); 
hold on;
plot(e2_2_POD(1, :), e2_2_POD(2, :)); 
plot(e2_3_POD(1, :), e2_3_POD(2, :)); 
plot(e2_4_POD(1, :), e2_4_POD(2, :)); 
axis([0.4 1.4 0 1.5]); 
title(['Error vs. $Uc/U_\infty$, ' s], 'interpreter', 'latex'); 
xlabel('$Uc/U_\infty$', 'interpreter', 'latex'); 
ylabel('$\Sigma(U_c)$', 'interpreter', 'latex'); 
hleg = legend('$1 \delta$', '$2 \delta$', '$3 \delta$', '$4 \delta$');
hleg.Interpreter  = 'latex';
hleg.Location     = 'southwest';
hleg.Title.String = 'Separation'; 
grid on;
grid minor;

%%
s = sprintf('with first %i modes', NumberOfModes);
figure();
set(gcf,'units','centimeters','position',[0 0 1.2*8 8]);
plot(e2_3(1, :), e2_3(2, :)); 
hold on;
plot(e2_3_POD(1, :), e2_3_POD(2, :)); 
axis([0.4 1.4 0 1.5]); 
% title('Error vs. $Uc/U_\infty$', 'interpreter', 'latex'); 
xlabel('$Uc/U_\infty$', 'interpreter', 'latex'); 
ylabel('Global Error, $\Sigma(U_c)$', 'interpreter', 'latex'); 
hleg = legend('with all modes', s);
hleg.Interpreter  = 'latex';
hleg.Location     = 'southwest';
grid on;
grid minor;

