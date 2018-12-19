function plot_ST_LISAS(taskN,calIndex) 
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
    lowRange =0.6;
    highRange = 1.8;
    rangeGap =0.2;
    
% % CHECK N
% if exist('N.mat', 'file')
%     load N
% end
% 
% N.(taskName).ST = nanmean(data2.(taskName).ST_mean.N);% location task中ST存在问题 若使用需要重新编码
% save N N

% START
switch calIndex    
        case 'mean' %mean
        labelY='Linear integrated speed-accuracy scores(LISAS)';
        % CV
        structureDir_ST = data2.(taskName).ST_mean.LISAS;
              
        case 'median' % median
        labelY='LISAS-median';
        % CV
        structureDir_ST = data2.(taskName).ST_median.LISAS;

end


%% CV ('SCSV' ,'SCDV', 'DCSV', 'DCDV') figure RT 

% params
columnN= size(structureDir_ST,2);
titleName = ['TAIL-'  taskName '-ST'];
labelXtick = {'SSST', 'SSDT', 'DSST', 'DSDT'};
rangeAxis = [0 columnN+1 lowRange highRange];
rangeY = [lowRange:rangeGap:highRange];
labelX = 'Condition';

% read data from different groups
group_tone1 = structureDir_ST(1:8,1:4);
group_pure2 =structureDir_ST(9:22,1:4);
group_control3 = structureDir_ST(23:43,1:4);

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
grid off
T=legend('Tone agnosics','Pure amusics','Controls','Location','northeast');

end
end
