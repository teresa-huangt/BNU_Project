function plot_Clateralization(taskN) 
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

for i = taskN
    taskName = taskList{i};
    figure;
%     xlabel = taskName(1:end-7);

    
% % CHECK N
% if exist('N.mat', 'file')
%     load N
% end
% 
% N.(taskName).LW = nanmean(data2.(taskName).LW_mean.N);% location task中ST存在问题 若使用需要重新编码
% save N N

% % START
% switch calIndex    
%         case 'mean' %mean
%         labelY='LISAS-mean';
%         structureDir = data2.(taskName).LW_mean.LISAS;
%               
%         case 'median' % median
%         labelY='LISAS-median';
%         structureDir = data2.(taskName).LW_median.LISAS;
% 
% end
 labelY='Linear integrated speed-accuracy scores';
 structureDir = data2.(taskName).Clateralization.LISAS;
left = data2.(taskName).Clateralization.LISAS(:,[1 3]);
right = data2.(taskName).Clateralization.LISAS(:,[2 4]);
structureDif = left-right;
%% subplot1
    lowRange =0.8;
    highRange = 3.2;
    rangeGap =0.4;
% params
columnN= size(structureDir,2);
titleName = [ 'Consonant&Lateralization'];
labelXtick = {'CS-targetL','CS-targetR',  'CD-targetL', 'CD-targetR'};
rangeAxis = [0 columnN+1 lowRange highRange];
rangeY = [lowRange:rangeGap:highRange];
labelX = taskName;

% read data from different groups
group_tone1 = structureDir(1:8,1:4);
group_pure2 =structureDir(9:22,1:4);
group_control3 = structureDir(23:43,1:4);

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
figure;%subplot(2,1,1);
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
set(get(gca,'ylabel'),'FontSize', 10, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');

set(gca,'XTick',1:columnN);
set(gca,'YTick',rangeY);

box off
set(gca,'xticklabel',labelXtick);
axis(rangeAxis)
grid on
T=legend('Tone agnosics','Pure amusics','Controls','Location','northeast');

%% subplot2
    lowRange =-0.4;
    highRange = 0.4;
    rangeGap =0.2;
% params
columnN= size(structureDif,2);
titleName = [ 'Lateralization (Left ear - Right ear)'];
labelXtick = {'ConsonantSame','ConsonantDifferent'};
rangeAxis = [0 columnN+1 lowRange highRange];
rangeY = [lowRange:rangeGap:highRange];
labelX = taskName;

% read data from different groups
group_tone1 = structureDif(1:8,1:2);
group_pure2 =structureDif(9:22,1:2);
group_control3 = structureDif(23:43,1:2);

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
figure;%subplot(2,1,2);
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
set(get(gca,'ylabel'),'FontSize', 10, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');

set(gca,'XTick',1:columnN);
set(gca,'YTick',rangeY);

box off
set(gca,'xticklabel',labelXtick);
axis(rangeAxis)
grid on
T=legend('Tone agnosics','Pure amusics','Controls','Location','northeast');
line([0 3],[ 0 0]);
end
end
