function plot_phonemeLevel_CVT_ER(taskN) 
% taskN: [1:6] =L,W,S,C,V,T
% 
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
    highRange = 0.45;
    rangeGap = 0.1;
    

% CVT
structureDir_CVTst = data2.(taskName).CVT_mean.ERst;
structureDir_CVTdt = data2.(taskName).CVT_mean.ERdt;



% %% CVT (st£º'SCSV' ,'SCDV', 'DCSV', 'DCDV'; st£º'SCSV','SCDV','DCSV','DCDV') figure RT 
 
labelY='Error Rate';
columnN= size(structureDir_CVTst,2);
labelX = 'Condition';
titleName = ['TAIL-'  taskName '-CVTsameTone'];
rangeY = [lowRange:rangeGap:highRange];
rangeAxis = [0 columnN+1 lowRange highRange];
labelXtick = {'SCSV' ,'SCDV', 'DCSV', 'DCDV'};

% CVT-same tone(SCSV SCDV DCSV DCDV) figure RT
group_tone1 = structureDir_CVTst(1:8,1:4);
group_pure2 = structureDir_CVTst(9:22,1:4);
group_control3 = structureDir_CVTst(23:43,1:4);

g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

x=[ 1 : columnN ];
h1=figure;
errorbar(x,g1,s_g1,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);hold on;
errorbar(x,g2,s_g2,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',10);hold on;
errorbar(x,g3,s_g3,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',10);


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


%% CVT-different tone(SCSV SCDV DCSV DCDV) figure RT

titleName = ['TAIL-'  taskName '-CVTdifferentTone'];

group_tone1 = structureDir_CVTdt(1:8,1:4);
group_pure2 = structureDir_CVTdt(9:22,1:4);
group_control3 = structureDir_CVTdt(23:43,1:4);

g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

x=[ 1 : columnN ];
h1=figure;
errorbar(x,g1,s_g1,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);hold on;
errorbar(x,g2,s_g2,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',10);hold on;
errorbar(x,g3,s_g3,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',10);


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


% %% --------------------------------------------------------------------------------------------------------------------------
% %% CV ('SCSV' ,'SCDV', 'DCSV', 'DCDV') figure RT 
% 
% columnN= size(structureDir_CV,2);
% titleName = ['TAIL-'  taskName '-CV'];
% labelXtick = {'SCSV' ,'SCDV', 'DCSV', 'DCDV'};
% rangeAxis = [0 columnN+1 lowRange highRange];
% 
% % read data from different groups
% group_tone1 = structureDir_CV(1:8,1:4);
% group_pure2 =structureDir_CV(9:22,1:4);
% group_control3 = structureDir_CV(23:43,1:4);
% 
% % average group people
% g1=nanmean(group_tone1);
% g2=nanmean(group_pure2);
% g3=nanmean(group_control3);
% 
% % 2ste
% s_g1=nanste(group_tone1);
% s_g2=nanste(group_pure2);
% s_g3=nanste(group_control3);
% 
% % plot  different groups
% x=[ 1 : columnN ];
% h1=figure;
% errorbar(x,g1,s_g1,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);hold on;
% errorbar(x,g2,s_g2,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',10);hold on;
% errorbar(x,g3,s_g3,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',10);
% 
% % parameters
% 
% % T=legend('tone-agnosia','pure-amusia','control');
% % set(T,'Fontsize',12); 
% 
% ylabel(labelY);
% xlabel(labelX);
% title(titleName);
% 
% set(get(gca,'xlabeL'),'FontSize', 14, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
% set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'bold','FontName','Consolas');%Helvetica
% set(get(gca,'title'),'FontSize', 16, 'FontWeight', 'normal','FontName','Consolas');
% 
% set(gca,'XTick',1:columnN);
% set(gca,'YTick',rangeY);
% 
% box off
% set(gca,'xticklabel',labelXtick);
% axis(rangeAxis)
% grid on
% 
% %% CV-SD 1 & 234
% columnN= size(structureDir_CV_SD,2);
% titleName = ['TAIL-'  taskName '-CV-SD '];
% labelXtick = {'CV-S','CV-D'};
% rangeAxis = [0 columnN+1 lowRange highRange];
% 
% sum = structureDir_CV_SD;
% 
% group_tone1 = sum(1:8,1:2);
% group_pure2 =sum(9:22,1:2);
% group_control3 = sum(23:43,1:2);
% 
% g1=nanmean(group_tone1);
% g2=nanmean(group_pure2);
% g3=nanmean(group_control3);
% 
% s_g1=nanste(group_tone1);
% s_g2=nanste(group_pure2);
% s_g3=nanste(group_control3);
% 
% x=[ 1 : columnN ];
% h1=figure;
% errorbar(x,g1,s_g1,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);hold on;
% errorbar(x,g2,s_g2,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',10);hold on;
% errorbar(x,g3,s_g3,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',10);
% 
% 
% % T=legend('tone-agnosia','pure-amusia','control');
% % set(T,'Fontsize',12); 
% ylabel(labelY);
% xlabel(labelX);
% title(titleName);
% 
% 
% set(get(gca,'xlabeL'),'FontSize', 14, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
% set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'bold','FontName','Consolas');%Helvetica
% set(get(gca,'title'),'FontSize', 16, 'FontWeight', 'normal','FontName','Consolas');
% 
% set(gca,'XTick',1:columnN);
% set(gca,'YTick',rangeY);
% 
% box off
% set(gca,'xticklabel',labelXtick);
% axis(rangeAxis)
% grid on
% 
% %% CV-CONGRUENT 14 & 23
% 
% columnN= size(structureDir_CV_CONGRUENT,2);
% titleName = ['TAIL-'  taskName '-CV-CONGRUENT '];
% labelXtick = {'CV-congruent','CV-incongruent'};
% rangeAxis = [0 columnN+1 lowRange highRange];
% 
% sum = structureDir_CV_CONGRUENT;
% 
% group_tone1 = sum(1:8,1:2);
% group_pure2 =sum(9:22,1:2);
% group_control3 = sum(23:43,1:2);
% 
% g1=nanmean(group_tone1);
% g2=nanmean(group_pure2);
% g3=nanmean(group_control3);
% 
% s_g1=nanste(group_tone1);
% s_g2=nanste(group_pure2);
% s_g3=nanste(group_control3);
% 
% x=[ 1 : columnN ];
% h1=figure;
% errorbar(x,g1,s_g1,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);hold on;
% errorbar(x,g2,s_g2,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',10);hold on;
% errorbar(x,g3,s_g3,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',10);
% 
% 
% % T=legend('tone-agnosia','pure-amusia','control');
% % set(T,'Fontsize',12); 
% ylabel(labelY);
% xlabel(labelX);
% title(titleName);
% 
% 
% set(get(gca,'xlabeL'),'FontSize', 14, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
% set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'bold','FontName','Consolas');%Helvetica
% set(get(gca,'title'),'FontSize', 16, 'FontWeight', 'normal','FontName','Consolas');
% 
% set(gca,'XTick',1:columnN);
% set(gca,'YTick',rangeY);
% 
% box off
% set(gca,'xticklabel',labelXtick);
% axis(rangeAxis)
% grid on
% %% --------------------------------------------------------------------------------------------------------------------------
% %% ST ('SSST' ,'SSDT', 'DSST', 'DSDT') figure RT 
% columnN= size(structureDir_ST,2);
% titleName = ['TAIL-'  taskName '-ST'];
% labelXtick = {'SSST' ,'SSDT', 'DSST', 'DSDT'};
% rangeAxis = [0 columnN+1 lowRange highRange];
% 
% % read data from different groups
% group_tone1 = structureDir_ST(1:8,1:4);
% group_pure2 =structureDir_ST(9:22,1:4);
% group_control3 = structureDir_ST(23:43,1:4);
% 
% % average group people
% g1=nanmean(group_tone1);
% g2=nanmean(group_pure2);
% g3=nanmean(group_control3);
% 
% % 2ste
% s_g1=nanste(group_tone1);
% s_g2=nanste(group_pure2);
% s_g3=nanste(group_control3);
% 
% % plot  different groups
% x=[ 1 : columnN ];
% h1=figure;
% errorbar(x,g1,s_g1,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);hold on;
% errorbar(x,g2,s_g2,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',10);hold on;
% errorbar(x,g3,s_g3,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',10);
% 
% % parameters
% 
% % T=legend('tone-agnosia','pure-amusia','control');
% % set(T,'Fontsize',12); 
% 
% ylabel(labelY);
% xlabel(labelX);
% title(titleName);
% 
% set(get(gca,'xlabeL'),'FontSize', 14, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
% set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'bold','FontName','Consolas');%Helvetica
% set(get(gca,'title'),'FontSize', 16, 'FontWeight', 'normal','FontName','Consolas');
% 
% set(gca,'XTick',1:columnN);
% set(gca,'YTick',rangeY);
% 
% box off
% set(gca,'xticklabel',labelXtick);
% axis(rangeAxis)
% grid on
% 
% %% ST-SD 1 & 234
% columnN= size(structureDir_ST_SD,2);
% titleName = ['TAIL-'  taskName '-ST-SD '];
% labelXtick = {'ST-S','ST-D'};
% rangeAxis = [0 columnN+1 lowRange highRange];
% 
% sum = structureDir_ST_SD;
% 
% group_tone1 = sum(1:8,1:2);
% group_pure2 =sum(9:22,1:2);
% group_control3 = sum(23:43,1:2);
% 
% g1=nanmean(group_tone1);
% g2=nanmean(group_pure2);
% g3=nanmean(group_control3);
% 
% s_g1=nanste(group_tone1);
% s_g2=nanste(group_pure2);
% s_g3=nanste(group_control3);
% 
% x=[ 1 : columnN ];
% h1=figure;
% errorbar(x,g1,s_g1,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);hold on;
% errorbar(x,g2,s_g2,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',10);hold on;
% errorbar(x,g3,s_g3,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',10);
% 
% 
% % T=legend('tone-agnosia','pure-amusia','control');
% % set(T,'Fontsize',12); 
% ylabel(labelY);
% xlabel(labelX);
% title(titleName);
% 
% 
% set(get(gca,'xlabeL'),'FontSize', 14, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
% set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'bold','FontName','Consolas');%Helvetica
% set(get(gca,'title'),'FontSize', 16, 'FontWeight', 'normal','FontName','Consolas');
% 
% set(gca,'XTick',1:columnN);
% set(gca,'YTick',rangeY);
% 
% box off
% set(gca,'xticklabel',labelXtick);
% axis(rangeAxis)
% grid on
% 
% %% ST-CONGRUENT 14 & 23
% 
% columnN= size(structureDir_ST_CONGRUENT,2);
% titleName = ['TAIL-'  taskName '-ST-CONGRUENT '];
% labelXtick = {'ST-congruent','ST-incongruent'};
% rangeAxis = [0 columnN+1 lowRange highRange];
% 
% sum = structureDir_ST_CONGRUENT;
% 
% group_tone1 = sum(1:8,1:2);
% group_pure2 =sum(9:22,1:2);
% group_control3 = sum(23:43,1:2);
% 
% g1=nanmean(group_tone1);
% g2=nanmean(group_pure2);
% g3=nanmean(group_control3);
% 
% s_g1=nanste(group_tone1);
% s_g2=nanste(group_pure2);
% s_g3=nanste(group_control3);
% 
% x=[ 1 : columnN ];
% h1=figure;
% errorbar(x,g1,s_g1,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);hold on;
% errorbar(x,g2,s_g2,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',10);hold on;
% errorbar(x,g3,s_g3,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',10);
% 
% 
% % T=legend('tone-agnosia','pure-amusia','control');
% % set(T,'Fontsize',12); 
% ylabel(labelY);
% xlabel(labelX);
% title(titleName);
% 
% 
% set(get(gca,'xlabeL'),'FontSize', 14, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
% set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'bold','FontName','Consolas');%Helvetica
% set(get(gca,'title'),'FontSize', 16, 'FontWeight', 'normal','FontName','Consolas');
% 
% set(gca,'XTick',1:columnN);
% set(gca,'YTick',rangeY);
% 
% box off
% set(gca,'xticklabel',labelXtick);
% axis(rangeAxis)
% grid on
end
end
