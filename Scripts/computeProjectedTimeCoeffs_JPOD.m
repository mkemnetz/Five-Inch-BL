%% Zero
h = waitbar(0,'Zero','Name','Projecting POD Modes...',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');

WF  = data.zero.phase;
NN  = size(WF, 3);
a_n_zero = zeros(size(WF, 3), size(POD_Modes, 3));
for t = 1:NN
    if getappdata(h,'canceling')
        break;
    end
    if (mod(t, 1000)==0)
        waitbar(t/NN,h)
    end
    
    WF_t = WF(:, :, t);
    WF_t = WF_t(:);    
    for n = 1:size(POD_Modes, 3)
        POD_n = POD_Modes(:, :, n);
        POD_n = POD_n(:);
        a_n_zero(t, n) = sum(dot(WF_t, POD_n'));
    end
end
delete(h);

%% One
h = waitbar(0,'One','Name','Projecting POD Modes...',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
        
WF  = data.one.phase;
NN  = size(WF, 3);
a_n_one = zeros(size(WF, 3), size(POD_Modes, 3));
for t = 1:NN
    if getappdata(h,'canceling')
        break;
    end
    if (mod(t, 1000)==0)
        waitbar(t/NN,h)
    end
    
    WF_t = WF(:, :, t);
    WF_t = WF_t(:);
    for n = 1:size(POD_Modes, 3)
        POD_n = POD_Modes(:, :, n);
        POD_n = POD_n(:);
        a_n_one(t, n) = sum(dot(WF_t, POD_n'));
    end
end
delete(h);

%% Two
h = waitbar(0,'Two','Name','Projecting POD Modes...',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
        
WF  = data.two.phase;
NN  = size(WF, 3);
a_n_two = zeros(size(WF, 3), size(POD_Modes, 3));
for t = 1:NN
    if getappdata(h,'canceling')
        break;
    end
    if (mod(t, 1000)==0)
        waitbar(t/NN,h)
    end
    
    WF_t = WF(:, :, t);
    WF_t = WF_t(:);
    for n = 1:size(POD_Modes, 3)
        POD_n = POD_Modes(:, :, n);
        POD_n = POD_n(:);
        a_n_two(t, n) = sum(dot(WF_t, POD_n'));
    end
end
delete(h);

%% Three
h = waitbar(0,'Three','Name','Projecting POD Modes...',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
        
WF  = data.three.phase;
NN  = size(WF, 3);
a_n_three = zeros(size(WF, 3), size(POD_Modes, 3));
for t = 1:NN
    if getappdata(h,'canceling')
        break;
    end
    if (mod(t, 1000)==0)
        waitbar(t/NN,h)
    end
    
    WF_t = WF(:, :, t);
    WF_t = WF_t(:);
    for n = 1:size(POD_Modes, 3)
        POD_n = POD_Modes(:, :, n);
        POD_n = POD_n(:);
        a_n_three(t, n) = sum(dot(WF_t, POD_n'));
    end
end
delete(h);

%% Four
h = waitbar(0,'Four','Name','Projecting POD Modes...',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
        
WF  = data.four.phase;
NN  = size(WF, 3);
a_n_four = zeros(size(WF, 3), size(POD_Modes, 3));
for t = 1:NN
    if getappdata(h,'canceling')
        break;
    end
    if (mod(t, 1000)==0)
        waitbar(t/NN,h)
    end
    
    WF_t = WF(:, :, t);
    WF_t = WF_t(:);
    for n = 1:size(POD_Modes, 3)
        POD_n = POD_Modes(:, :, n);
        POD_n = POD_n(:);
        a_n_four(t, n) = sum(dot(WF_t, POD_n'));
    end
end
delete(h);