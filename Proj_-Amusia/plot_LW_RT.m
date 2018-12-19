function plot_LW_RT(taskN,calIndex) 
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
    highRange = 1.2;
    rangeGap = 0.1;
    
% CHECK N
if exist('N.mat', 'file')
    load N
end

N.(taskName).LW = nanmean(data2.(taskName).LW_mean.N);% location task中ST存在问题 若使用需要重新编码
save N N

% START
switch calIndex    
        case 'mean' %mean
        labelY='mean RT (s)';
        structureDir_LW = data2.(taskName).LW_mean.RT;
              
        case 'median' % median
        labelY='median RT (s)';
        structureDir_LW = data2.(taskName).LW_median.RT;

end


%% CV ('SCSV' ,'SCDV', 'DCSV', 'DCDV') figure RT 

% params
columnN= size(structureDir_LW,2);
titleName = ['TAIL-'  taskName '-LW'];
labelXtick = {'SLSW' , 'SLDW', 'DLSW', 'DLDW'};
rangeAxis = [0 columnN+1 lowRange highRange];
rangeY = [lowRange:rangeGap:highRange];
labelX = 'Condition';

% read data from different groups
group_tone1 = structureDir_LW(1:8,1:4);
group_pure2 =structureDir_LW(9:22,1:4);
group_control3 = structureDir_LW(23:43,1:4);

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
