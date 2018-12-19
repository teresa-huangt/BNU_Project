function plot_phonemeLevel_CV_ER(taskN) 
% taskN: [1:6] =L,W,S,C,V,T
% calIndex: 'mean','median'
%
% CVT:
% consonant(2)*vowel(2)*tone(2)
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
    lowRange =0;
    highRange = 0.15;
    rangeGap = 0.05;
    
% % CHECK N
% if exist('N.mat', 'file')
%     load N
% end
% 
% N.(taskName).CV = nanmean(data2.(taskName).CV_mean.N);
% save N N

% START
% CV
structureDir_CV = data2.(taskName).CV_mean.ER;
              


%% CV ('SCSV' ,'SCDV', 'DCSV', 'DCDV') figure ERR RATE 

% params
columnN= size(structureDir_CV,2);
labelY='Error Rate';
labelX = 'Condition';
titleName = ['TAIL-'  taskName '-CV'];
rangeY = [lowRange:rangeGap:highRange];
rangeAxis = [0 columnN+1 lowRange highRange];
labelXtick = {'SCSV' ,'SCDV', 'DCSV', 'DCDV'};

% read data from different groups
group_tone1 = structureDir_CV(1:8,1:4);
group_pure2 =structureDir_CV(9:22,1:4);
group_control3 = structureDir_CV(23:43,1:4);

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
errorbar(x,g1,s_g1,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);hold on;
errorbar(x,g2,s_g2,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',10);hold on;
errorbar(x,g3,s_g3,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',10);

% parameters

% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 

ylabel(labelY);
xlabel(labelX);
title(titleName);

set(get(gca,'xlabeL'),'FontSize', 14, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'bold','FontName','Consolas');%Helvetica
set(get(gca,'title'),'FontSize', 16, 'FontWeight', 'normal','FontName','Consolas');

set(gca,'XTick',1:columnN);
set(gca,'YTick',rangeY);

box off
set(gca,'xticklabel',labelXtick);
axis(rangeAxis)
grid on


end
end
