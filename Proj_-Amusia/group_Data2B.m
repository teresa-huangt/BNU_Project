% calculate group data in data2; run only once
% need to do data correction first if applicable (run recalP if needed; only for old data)
% NOTE:
% change ST in location task (change_L_ST.m)
%
clear all;
close all;
taskList = {'speechEar_rovGap',...
    'speechID_rovGap',...
    'phoneticDisc_rovGap',...
    'consDisc_rovGap',...
    'vowelDisc_rovGap',...    
    'toneDisc_rovGap'};
% taskOrder = [4,3,2,1, 5,6];
% taskList = taskList(taskOrder);
% shortL={'Location', 'Word', 'Syllable',  'C', 'V', 'Tone'};
if exist('data2D.mat', 'file')
    load data2D
end
% there is some learning from block 1 to 2 so use only block 1 when look at
% all subjects

% cutoff = 3; % a fixed cutoff level may cut off a lot of trials for slower participants; for example, cutoff of 3s cut some subjects 20 trials
% try relative ones (in unit of std): norminv(0.98,0,1) = 2.05; so 2 std
% should cut about 2% data
lowCut = 0.2; highCut = 3; 
% %% get fileList
% cfolder = pwd;% cd(cfolder);
% datadir='../data2/';
% cd(datadir);
% a=dir('*.mat');
% fileList = {a.name};
% data2.fileList = fileList';
%  cd(cfolder);

%% STEP1£º
% %  collect mean 
% 
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_meanRT(taskName, lowCut,highCut); %
%     data2.(taskName).mean = A;
% end
% data2.meanHeader = {'meanRT', 'errorrate', 'valid RT trials', 'lowCut number', 'highCut number', 'medianRT','highCut ratio','S-RT','S-ER'};
% save data2D data2

%% STEP2£º
% %collect phonemeLevel-CVT meanRT
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_phonemeLevel_CVT_meanRT(taskName, lowCut,highCut); %
%     data2.(taskName).CVT_mean = A;
% end
% 
% %% collect phonemeLevel-CVT medianRT
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_phonemeLevel_CVT_medianRT(taskName, lowCut,highCut); %
%     data2.(taskName).CVT_median = A;
% end

%% STEP3£º
% % collect phonemeLevel-CV meanRT
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_CV_meanRT(taskName, lowCut,highCut); %
%     data2.(taskName).CV_mean = A;
% end
% 
% % collect phonemeLevel-CV medianRT
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_CV_medianRT(taskName, lowCut,highCut); %
%     data2.(taskName).CV_median = A;
% end


%% STEP4£ºST
% % collect syllableLevel-ST meanRT
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_ST_meanRT(taskName, lowCut,highCut); %
%     data2.(taskName).ST_mean = A;
% end
% 
% % collect syllableLevel-ST medianRT
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_ST_medianRT(taskName, lowCut,highCut); %
%     data2.(taskName).ST_median = A;
% end

%% STEP5£ºconstancy £¨sc/dc;sv/dc;....T,S,L£©
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_constancy_mean(taskName, lowCut,highCut); %
%     data2.(taskName).constancy_mean = A;
% end

%% STEP6£ºLW
% % collect syllableLevel-ST meanRT
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_LW_meanRT(taskName, lowCut,highCut); %
%     data2.(taskName).LW_mean = A;
% end
% 
% % collect syllableLevel-ST medianRT
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_LW_medianRT(taskName, lowCut,highCut); %
%     data2.(taskName).LW_median = A;
% end

%% STEP7£ºCONGRUENCY 
% % collect ST,CV congruency mean
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_congruency_mean(taskName, lowCut,highCut); %
%     data2.(taskName).congruency_mean = A;
% end

%% STEP8: CHANGE L -ST
% 
% for i = 1
%     taskName = taskList{i};
%     A=cal_ST_meanRT_L(taskName, lowCut,highCut); %
%     data2.(taskName).ST_mean = A;
% end




%% STEP9£º get lateralization data (MEAN)
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_lateralization(taskName, lowCut,highCut); %
%     data2.(taskName).lateralization = A;
% end
% 
% %% cal_SW_meanRT_W
% for i = 2
%     taskName = taskList{i};
%     A=cal_SW_meanRT_W(taskName, lowCut,highCut); %
%     data2.(taskName).SW = A;
% end


%% cal__Clateralization %consonant information(same/different) and lateralization information(L/R).
for i = 1:6
    taskName = taskList{i};
    A=cal_L_Clateralization(taskName, lowCut,highCut); %
    data2.(taskName).Clateralization = A;
end

% %% test if C/V variation matters
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_CVmedian(taskName, lowCut,highCut); %
%     data2.(taskName).DiffSyl = A;
% end
% %% test difference between same and different words
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_Wordmedian(taskName, lowCut,highCut); %
%     data2.(taskName).wordSD = A;
% end
% %% test if stimulus (character) matters
% for i = 1:6
%     taskName = taskList{i};
%     A=cal_character_medianRT(taskName, lowCut,highCut); %
%     data2.(taskName).cueID = A;
% end
% %
save data2D data2