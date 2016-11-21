% clear all
close all

%%
params.N    = 1000;
params.fine = 200;
[ dataZero.x,  dataZero.y,   dataZero.phase ] = refineWF2( data.zero.phase,  data.zero.x,  data.zero.y,  params);
[ dataOne.x,   dataOne.y,   dataOne.phase   ] = refineWF2( data.one.phase,   data.one.x,   data.one.y,   params);
[ dataTwo.x,   dataTwo.y,   dataTwo.phase   ] = refineWF2( data.two.phase,   data.two.x,   data.two.y,   params);
[ dataThree.x, dataThree.y, dataThree.phase ] = refineWF2( data.three.phase, data.three.x, data.three.y, params);
[ dataFour.x,  dataFour.y,  dataFour.phase  ] = refineWF2( data.four.phase,  data.four.x,  data.four.y,  params);

%%
phase_L = dataZero.phase;
phase_R1 = dataOne.phase;
phase_R2 = dataTwo.phase;
phase_R3 = dataThree.phase;
phase_R4 = dataFour.phase;
%%
OPDrms = zeros(1, params.N);
for i = 1:params.N
    temp1 = reshape( phase_L(:, :, i)   , 1, numel(phase_L(:, :, i)));
    OPDrms(i) = rms(temp1);
end

OPDrms = mean(OPDrms);


%%
e2_1         = zeros(2, 100);
e2_2         = zeros(2, 100);
e2_3         = zeros(2, 100);
e2_4         = zeros(2, 100);
N            = params.N;
for i = 1:100
    delay       = i;
    
    error1 = zeros(1, N-delay);
    error2 = zeros(1, N-delay);
    error3 = zeros(1, N-delay);
    error4 = zeros(1, N-delay);
    index = 1;
    for k = 1:N-delay
        A = phase_L(:, :, k);
        B1 = phase_R1(:, :, k+delay);
        B2 = phase_R2(:, :, k+delay);
        B3 = phase_R3(:, :, k+delay);
        B4 = phase_R4(:, :, k+delay);

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
    e2_1(2, i) = mean(error1(1, :));
    e2_1(1, i) = (1*0.0156)/(i*machToVel(0.3, 75.3)*(1/40000));
    
    e2_2(2, i) = mean(error2(1, :));
    e2_2(1, i) = (2*0.0156)/(i*machToVel(0.3, 75.3)*(1/40000));
    
    e2_3(2, i) = mean(error3(1, :));
    e2_3(1, i) = (3*0.0156)/(i*machToVel(0.3, 75.3)*(1/40000));
    
    e2_4(2, i) = mean(error4(1, :));
    e2_4(1, i) = (4*0.0156)/(i*machToVel(0.3, 75.3)*(1/40000));
end
%%
figure();
set(gcf,'units','centimeters','position',[0 0 1.2*8 8]);
plot(e2_1(1, :), e2_1(2, :)); 
hold on;
plot(e2_2(1, :), e2_2(2, :)); 
plot(e2_3(1, :), e2_3(2, :)); 
plot(e2_4(1, :), e2_4(2, :)); 
axis([0.4 1.4 0 1.5]); 
title('Error vs. $Uc/U_\infty$', 'interpreter', 'latex'); 
xlabel('$Uc/U_\infty$', 'interpreter', 'latex'); 
ylabel('$\Sigma(U_c)$', 'interpreter', 'latex'); 
hleg = legend('$1 \delta$', '$2 \delta$', '$3 \delta$', '$4 \delta$');
hleg.Interpreter  = 'latex';
hleg.Location     = 'southwest';
hleg.Title.String = 'Separation'; 
% set(hleg, 'interpreter', 'latex', 'location', 'southwest', 'title', 'test');
% v = get(hleg,'title');
% set(v,'string','Legend Title');
grid on;
grid minor;

%%
