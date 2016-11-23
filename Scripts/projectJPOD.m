%%
N = NumberOfModes;

%% Zero
s = sprintf('Summing up first %i modes...\n', N);
h = waitbar(0,'Zero','Name',s,...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
        
WF      = data.zero.phase;
NN      = size(WF, 3);
WFzero  = zeros(size(POD_Modes, 1), size(POD_Modes, 2), size(POD_Modes, 3));
WF_zero = zeros(size(POD_Modes, 1), size(POD_Modes, 2), NN);
for t = 1:NN
    if getappdata(h,'canceling')
        break;
    end
    if (mod(t, 1000)==0)
        waitbar(t/NN,h)
    end
    for n = 1:N
        WFzero(:, :, n) = a_n_zero(t, n).*POD_Modes(:, :, n);
    end
    WFzero           = mean(WFzero, 3);
    WF_zero(:, :, t) = WFzero;
end
delete(h);

%% One
% WFone = zeros(size(POD_Modes, 1), size(POD_Modes, 2), size(POD_Modes, 3));
% for n = 1:20
%     WFone(:, :, n) = a_n_one(1, n).*POD_Modes(:, :, n);
% end
% 
% WFone  = mean(WFone, 3);
s = sprintf('Summing up first %i modes...\n', N);
h = waitbar(0,'One','Name',s,...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
        
WF      = data.one.phase;
NN      = size(WF, 3);
WFone  = zeros(size(POD_Modes, 1), size(POD_Modes, 2), size(POD_Modes, 3));
WF_one = zeros(size(POD_Modes, 1), size(POD_Modes, 2), NN);
for t = 1:NN
    if getappdata(h,'canceling')
        break;
    end
    if (mod(t, 1000)==0)
        waitbar(t/NN,h)
    end
    for n = 1:N
        WFone(:, :, n) = a_n_one(t, n).*POD_Modes(:, :, n);
    end
    WFone           = mean(WFone, 3);
    WF_one(:, :, t) = WFone;
end
delete(h);

%% Two
% WFtwo = zeros(size(POD_Modes, 1), size(POD_Modes, 2), size(POD_Modes, 3));
% for n = 1:20
%     WFtwo(:, :, n) = a_n_two(1, n).*POD_Modes(:, :, n);
% end
% 
% WFtwo  = mean(WFtwo, 3);
s = sprintf('Summing up first %i modes...\n', N);
h = waitbar(0,'Two','Name',s,...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
        
WF      = data.two.phase;
NN      = size(WF, 3);
WFtwo  = zeros(size(POD_Modes, 1), size(POD_Modes, 2), size(POD_Modes, 3));
WF_two = zeros(size(POD_Modes, 1), size(POD_Modes, 2), NN);
for t = 1:NN
    if getappdata(h,'canceling')
        break;
    end
    if (mod(t, 1000)==0)
        waitbar(t/NN,h)
    end
    for n = 1:N
        WFtwo(:, :, n) = a_n_two(t, n).*POD_Modes(:, :, n);
    end
    WFtwo           = mean(WFtwo, 3);
    WF_two(:, :, t) = WFtwo;
end
delete(h);

%% Three
% WFthree = zeros(size(POD_Modes, 1), size(POD_Modes, 2), size(POD_Modes, 3));
% for n = 1:20
%     WFthree(:, :, n) = a_n_three(1, n).*POD_Modes(:, :, n);
% end
% 
% WFthree  = mean(WFthree, 3);
s = sprintf('Summing up first %i modes...\n', N);
h = waitbar(0,'Three','Name',s,...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
        
WF      = data.three.phase;
NN      = size(WF, 3);
WFthree  = zeros(size(POD_Modes, 1), size(POD_Modes, 2), size(POD_Modes, 3));
WF_three = zeros(size(POD_Modes, 1), size(POD_Modes, 2), NN);
for t = 1:NN
    if getappdata(h,'canceling')
        break;
    end
    if (mod(t, 1000)==0)
        waitbar(t/NN,h)
    end
    for n = 1:N
        WFthree(:, :, n) = a_n_three(t, n).*POD_Modes(:, :, n);
    end
    WFthree           = mean(WFthree, 3);
    WF_three(:, :, t) = WFthree;
end
delete(h);

%% Four
% WFfour = zeros(size(POD_Modes, 1), size(POD_Modes, 2), size(POD_Modes, 3));
% for n = 1:20
%     WFfour(:, :, n) = a_n_four(1, n).*POD_Modes(:, :, n);
% end
% 
% WFfour  = mean(WFfour, 3);
s = sprintf('Summing up first %i modes...\n', N);
h = waitbar(0,'Four','Name',s,...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
        
WF      = data.four.phase;
NN      = size(WF, 3);
WFfour  = zeros(size(POD_Modes, 1), size(POD_Modes, 2), size(POD_Modes, 3));
WF_four = zeros(size(POD_Modes, 1), size(POD_Modes, 2), NN);
for t = 1:NN
    if getappdata(h,'canceling')
        break;
    end
    if (mod(t, 1000)==0)
        waitbar(t/NN,h)
    end
    for n = 1:N
        WFfour(:, :, n) = a_n_four(t, n).*POD_Modes(:, :, n);
    end
    WFfour           = mean(WFfour, 3);
    WF_four(:, :, t) = WFfour;
end
delete(h);