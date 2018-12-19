
load data2D.mat;

taskList = {'speechEar_rovGap',...
    'speechID_rovGap',...
    'phoneticDisc_rovGap',...
    'consDisc_rovGap',...
    'vowelDisc_rovGap',...
    'toneDisc_rovGap'};
fieldList = {'CV_mean','CV_median','ST_mean','ST_median','LW_mean','LW_median'};

for i =1: length(taskList)
    taskName = taskList{i};
    for j=1: length(fieldList)
        fieldName = fieldList{j};
        
        %  exact data matrix
        RTmatrix = data2.(taskName).(fieldName).RT;%RTms = RT.*1000;
        ERmatrix = data2.(taskName).(fieldName).ER;
        sRTmatrix = nanstd(RTmatrix);
        sERmatrix = nanstd(ERmatrix);
        [sub,con] = size(RTmatrix);
        LISAS = nan(sub,con);
        
        % cal LISAS
        for i = 1:con
            for j = 1:sub
                RT = RTmatrix(j,i);
                ER = ERmatrix(j,i);
                sRT = sRTmatrix(i);
                sER = sERmatrix(i);
                LISAS(j,i) = RT+(sRT/sER)*ER;
                
            end
        end
        
        % save
        data2.(taskName).(fieldName).LISAS=LISAS;
    end
end

save data2D data2




%% location task CV-SD
load data2D.mat;

% exact data matrix
RTmatrix = data2.speechEar_rovGap.congruency_mean.CV(:,[1 2]);
ERmatrix = data2.speechEar_rovGap.congruency_mean.CVER(:,[1 2]);
sRTmatrix = std(RTmatrix);
sERmatrix = std(ERmatrix);
[sub,con] = size(RTmatrix);
LISAS = nan(sub,con);

% cal LISAS
for i = 1:con
    for j = 1:sub
        RT = RTmatrix(j,i);
        ER = ERmatrix(j,i);
        sRT = sRTmatrix(i);
        sER = sERmatrix(i);
        LISAS(j,i) = RT+(sRT/sER)*ER;
        
    end
end
data2.speechEar_rovGap.congruency_mean.CVLISAS=LISAS;
save data2D data2

%% location yask L-SD

load data2D.mat;
% RT = data2.speechEar_rovGap.constancy_mean.ear(:,[1 2]);
% ER = data2.speechEar_rovGap.constancy_mean.ear(:,[3 4]);

% exact data matrix
RTmatrix = data2.speechEar_rovGap.constancy_mean.ear(:,[1 2]);
ERmatrix = data2.speechEar_rovGap.constancy_mean.ear(:,[3 4]);
sRTmatrix = std(RTmatrix);
sERmatrix = std(ERmatrix);
[sub,con] = size(RTmatrix);
LISAS = nan(sub,con);

% cal LISAS
for i = 1:con
    for j = 1:sub
        RT = RTmatrix(j,i);
        ER = ERmatrix(j,i);
        sRT = sRTmatrix(i);
        sER = sERmatrix(i);
        LISAS(j,i) = RT+(sRT/sER)*ER;
        
    end
end

data2.speechEar_rovGap.constancy_mean.earLISAS=LISAS;
save data2D data2

%% W-SD
load data2D.mat;

taskList = {'speechEar_rovGap',...
    'speechID_rovGap',...
    'phoneticDisc_rovGap',...
    'consDisc_rovGap',...
    'vowelDisc_rovGap',...
    'toneDisc_rovGap'};
fieldList = {'constancy_mean'};

for i =1: length(taskList)
    taskName = taskList{i};
    fieldName = fieldList{1};
    
    %     RT = data2.(taskName).(fieldName).W(:,[1 2]);
    %     ER = data2.(taskName).(fieldName).W(:,[3 4]);
    
    %  exact data matrix
    RTmatrix = data2.(taskName).(fieldName).W(:,[1 2]);
    ERmatrix = data2.(taskName).(fieldName).W(:,[3 4]);
    sRTmatrix = std(RTmatrix);
    sERmatrix = std(ERmatrix);
    
    [sub,con] = size(RTmatrix);
    LISAS = nan(sub,con);
    
    % cal LISAS
    for i = 1:con
        for j = 1:sub
            RT = RTmatrix(j,i);
            ER = ERmatrix(j,i);
            sRT = sRTmatrix(i);
            sER = sERmatrix(i);
            LISAS(j,i) = RT+(sRT/sER)*ER;
            
        end
    end
    
    data2.(taskName).(fieldName).WLISAS=LISAS;
    
end
save data2D data2
%% consonant task V-SD
load data2D.mat;
% RT = data2.consDisc_rovGap.constancy_mean.V(:,[1 2]);
% ER = data2.consDisc_rovGap.constancy_mean.V(:,[3 4]);

%  exact data matrix
RTmatrix = data2.consDisc_rovGap.constancy_mean.V(:,[1 2]);
ERmatrix = data2.consDisc_rovGap.constancy_mean.V(:,[3 4]);
sRTmatrix = std(RTmatrix);
sERmatrix = std(ERmatrix);

[sub,con] = size(RTmatrix);
LISAS = nan(sub,con);

% cal LISAS
for i = 1:con
    for j = 1:sub
        RT = RTmatrix(j,i);
        ER = ERmatrix(j,i);
        sRT = sRTmatrix(i);
        sER = sERmatrix(i);
        LISAS(j,i) = RT+(sRT/sER)*ER;
        
    end
end

data2.consDisc_rovGap.constancy_mean.VLISAS=LISAS;
save data2D data2

%%  cal Location task lateriation 

load data2D.mat;

taskList = {'speechEar_rovGap',...
    'speechID_rovGap',...
    'phoneticDisc_rovGap',...
    'consDisc_rovGap',...
    'vowelDisc_rovGap',...
    'toneDisc_rovGap'};
fieldList = {'lateralization'};

for i =1: length(taskList)
    taskName = taskList{i};
    fieldName = fieldList{1};

    %  exact data matrix
    RTmatrix = data2.(taskName).(fieldName).RT;
    ERmatrix = data2.(taskName).(fieldName).ER;
    sRTmatrix = nanstd(RTmatrix);
    sERmatrix = nanstd(ERmatrix);
    
    [sub,con] = size(RTmatrix);
    LISAS = nan(sub,con);
    
    % cal LISAS
    for i = 1:con
        for j = 1:sub
            RT = RTmatrix(j,i);
            ER = ERmatrix(j,i);
            sRT = sRTmatrix(i);
            sER = sERmatrix(i);
            LISAS(j,i) = RT+(sRT/sER)*ER;
            
        end
    end
    
    data2.(taskName).(fieldName).LISAS=LISAS;
    
end
save data2D data2


%% word task SW -CONG
load data2D.mat;

%  exact data matrix
RTmatrix = data2.speechID_rovGap.SW.RT;
ERmatrix = data2.speechID_rovGap.SW.ER;
sRTmatrix = std(RTmatrix);
sERmatrix = std(ERmatrix);

[sub,con] = size(RTmatrix);
LISAS = nan(sub,con);

% cal LISAS
for i = 1:con
    for j = 1:sub
        RT = RTmatrix(j,i);
        ER = ERmatrix(j,i);
        sRT = sRTmatrix(i);
        sER = sERmatrix(i);
        LISAS(j,i) = RT+(sRT/sER)*ER;
        
    end
end

data2.speechID_rovGap.SW.LISAS=LISAS;
save data2D data2

%% word task ST congrurncy
load data2D.mat;
%  exact data matrix
RTmatrix =data2.speechID_rovGap.congruency_mean.ST ;
ERmatrix = data2.speechID_rovGap.congruency_mean.STER;
sRTmatrix = nanstd(RTmatrix);
sERmatrix = nanstd(ERmatrix);

[sub,con] = size(RTmatrix);
LISAS = nan(sub,con);

% cal LISAS
for i = 1:con
    for j = 1:sub
        RT = RTmatrix(j,i);
        ER = ERmatrix(j,i);
        sRT = sRTmatrix(i);
        sER = sERmatrix(i);
        LISAS(j,i) = RT+(sRT/sER)*ER;
        
    end
end

data2.speechID_rovGap.congruency_mean.STLISAS=LISAS;
save data2D data2


%% LOCATION TASK C-SD constancy
load data2D.mat;
%  exact data matrix
RTmatrix =data2.speechEar_rovGap.constancy_mean.C(:,[ 1 2]);
ERmatrix = data2.speechEar_rovGap.constancy_mean.C(:,[ 3 4]);
sRTmatrix = nanstd(RTmatrix);
sERmatrix = nanstd(ERmatrix);

[sub,con] = size(RTmatrix);
LISAS = nan(sub,con);

% cal LISAS
for i = 1:con
    for j = 1:sub
        RT = RTmatrix(j,i);
        ER = ERmatrix(j,i);
        sRT = sRTmatrix(i);
        sER = sERmatrix(i);
        LISAS(j,i) = RT+(sRT/sER)*ER;
        
    end
end

data2.speechEar_rovGap.constancy_mean.CLISAS=LISAS;
save data2D data2


%% cal__Clateralization
taskList = {'speechEar_rovGap',...
    'speechID_rovGap',...
    'phoneticDisc_rovGap',...
    'consDisc_rovGap',...
    'vowelDisc_rovGap',...
    'toneDisc_rovGap'};
fieldList = {'Clateralization'};

load data2D.mat;
for i =1: length(taskList)
    taskName = taskList{i};
    fieldName = fieldList{1};
%  exact data matrix
RTmatrix =data2.(taskName).(fieldName).RT;
ERmatrix = data2.(taskName).(fieldName).ER;
sRTmatrix = nanstd(RTmatrix);
sERmatrix = nanstd(ERmatrix);

[sub,con] = size(RTmatrix);
LISAS = nan(sub,con);

% cal LISAS
for i = 1:con
    for j = 1:sub
        RT = RTmatrix(j,i);
        ER = ERmatrix(j,i);
        sRT = sRTmatrix(i);
        sER = sERmatrix(i);
        LISAS(j,i) = RT+(sRT/sER)*ER;
        
    end
end

data2.(taskName).(fieldName).LISAS=LISAS;
end
save data2D data2
