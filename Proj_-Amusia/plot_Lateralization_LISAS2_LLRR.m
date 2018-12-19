function plot_Lateralization
% taskN: [1:6] =L,W,S,C,V,T
% calIndex: 'mean','median'
%

load data2D.mat;

taskList = {'speechEar_rovGap',...
    'speechID_rovGap',...
    'phoneticDisc_rovGap',...
    'consDisc_rovGap',...
    'vowelDisc_rovGap',...    
    'toneDisc_rovGap'};

for i = 1:length(taskList)
    taskName = taskList{i};

    

 %1=LL 4=RR
 structureBoth(:,[2*i-1, 2*i]) = data2.(taskName).lateralization.LISAS(:,[1 4]);
 targetL(:,i) = data2.(taskName).lateralization.LISAS(:,1);
 targetR(:,i) = data2.(taskName).lateralization.LISAS(:,4);
 structureDif = targetL-targetR;
end
%% plot targetL-R in 6tasks (in total 6 conditions)
    lowRange =-0.4;
    highRange = 0.4;
    rangeGap =0.1;
    
labelY='Linear integrated speed-accuracy scores';
% params
columnN= size(structureDif,2);
titleName = ['Lateralization (Left ear - Right ear)'];
labelXtick = {'Location','Word','sllyable','Consonant','Vowel','Tone'};
rangeAxis = [0 columnN+1 lowRange highRange];
rangeY = [lowRange:rangeGap:highRange];
labelX = 'Condition';

% read data from different groups
group_tone1 = structureDif(1:8,1:6);
group_pure2 =structureDif(9:22,1:6);
group_control3 = structureDif(23:43,1:6);

% average group people
g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

% 2ste
s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

% plot  different groups
x=[ 1 : columnN ];
h1=figure;
% subplot(2,1,2);
errorbar(x,g1,s_g1,'s','color','k','LineWidth',1,'MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',13);hold on;
errorbar(x,g2,s_g2,'v','color','k','LineWidth',1,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerSize',13);hold on;
errorbar(x,g3,s_g3,'o','color','k','LineWidth',1,'MarkerFaceColor','w','MarkerSize',13);

% parameters

% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 

ylabel(labelY);
xlabel(labelX);
title(titleName);

 set(get(gca,'xlabeL'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');

set(gca,'XTick',1:columnN);
set(gca,'YTick',rangeY);

box off
set(gca,'xticklabel',labelXtick);
axis(rangeAxis)
grid off

line([0,7],[0 0]);
T=legend('Tone agnosics','Pure amusics','Controls','Location','southeast');
%% plot targetL/R in 6 tasks (in total: 12 conditions)
    lowRange =0.6;
    highRange = 2.4;
    rangeGap =0.3;
%labelY='Linear integrated speed-accuracy scores(LISAS)';
% params
columnN= size(structureBoth,2);
titleName = ['Lateralization (Target ear)'];
labelXtick = {'L','R'};
rangeAxis = [0 columnN+1 lowRange highRange];
rangeY = [lowRange:rangeGap:highRange];
labelX = 'Condition';

% read data from different groups
group_tone1 = structureBoth(1:8,1:12);
group_pure2 =structureBoth(9:22,1:12);
group_control3 = structureBoth(23:43,1:12);

% average group people
g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

% 2ste
s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

% plot  different groups
x=[ 1 : columnN ];
% 
% subplot(2,1,1);
figure;
errorbar(x,g1,s_g1,'s','color','k','LineWidth',1,'MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',13);hold on;
errorbar(x,g2,s_g2,'v','color','k','LineWidth',1,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerSize',13);hold on;
errorbar(x,g3,s_g3,'o','color','k','LineWidth',1,'MarkerFaceColor','w','MarkerSize',13);

% parameters

% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 

ylabel(labelY);
xlabel(labelX);
title(titleName);

 set(get(gca,'xlabeL'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');

set(gca,'XTick',1:columnN);
set(gca,'YTick',rangeY);

box off
set(gca,'xticklabel',labelXtick);
axis(rangeAxis)
grid off
T=legend('Tone agnosics','Pure amusics','Controls','Location','southeast');
end
