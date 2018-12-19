
load data2D.mat;

taskList = {'speechEar_rovGap',...
    'speechID_rovGap',...
    'phoneticDisc_rovGap',...
    'consDisc_rovGap',...
    'vowelDisc_rovGap',...    
    'toneDisc_rovGap'};
fieldList = {'CV_mean','CV_median','ST_mean','ST_median','LW_mean','LW_median'};

for i =1% 1: length(taskList)
    taskName = taskList{i};
    for j=3 %1: length(fieldList)
        fieldName = fieldList{j};
        RT = data2.(taskName).(fieldName).RT;
        RTms = RT.*1000;
        ER = data2.(taskName).(fieldName).ER;
        CR = 1-ER;
        IES = RTms./CR;
        data2.(taskName).(fieldName).IES=IES;
    end
end

save data2D data2


%% location task CV-SD
load data2D.mat;
RT = data2.speechEar_rovGap.congruency_mean.CV(:,[1 2]);
RTms = RT.*1000;
ER = data2.speechEar_rovGap.congruency_mean.CVER(:,[1 2]);
CR = 1-ER;
IES = RTms./CR;
data2.speechEar_rovGap.congruency_mean.CVIES=IES;
save data2D data2

%% location yask L-SD

load data2D.mat;
RT = data2.speechEar_rovGap.constancy_mean.ear(:,[1 2]);
RTms = RT.*1000;
ER = data2.speechEar_rovGap.constancy_mean.ear(:,[3 4]);
CR = 1-ER;
IES = RTms./CR;
data2.speechEar_rovGap.constancy_mean.earIES=IES;
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
        RT = data2.(taskName).(fieldName).W(:,[1 2]);
        RTms = RT.*1000;
        ER = data2.(taskName).(fieldName).W(:,[3 4]);
        CR = 1-ER;
        IES = RTms./CR;
        data2.(taskName).(fieldName).WIES=IES;

end
save data2D data2
%% consonant task V-SD
load data2D.mat;
RT = data2.consDisc_rovGap.constancy_mean.V(:,[1 2]);
RTms = RT.*1000;
ER = data2.consDisc_rovGap.constancy_mean.V(:,[3 4]);
CR = 1-ER;
IES = RTms./CR;
data2.consDisc_rovGap.constancy_mean.VIES=IES;
save data2D data2


