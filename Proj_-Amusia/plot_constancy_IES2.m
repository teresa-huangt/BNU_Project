function plot_constancy_IES(taskN,index) 
% 
% index:E,C,V,T,S
%
% NOTE:!!! 
% -currently used in C,V task about constancy C.V
% -add L
% -only mean

load data2D.mat;

taskList = {'speechEar_rovGap',...
    'speechID_rovGap',...
    'phoneticDisc_rovGap',...
    'consDisc_rovGap',...
    'vowelDisc_rovGap',...    
    'toneDisc_rovGap'};

for i = taskN
    taskName = taskList{i};
    lowRange =600;
    highRange = 1200;
    rangeGap = 200;
    
% CHECK N
% location task中ST存在问题 若使用需要重新编码


% START
switch index    
        case 'C' %mean
        structureDir = data2.(taskName).constancy_mean.CIES(:,[1 2]);
        titleName = ['TAIL-'  taskName '-C'];   
        labelXtick = {'SC', 'DC'};
        case 'V' 
        structureDir = data2.(taskName).constancy_mean.VIES(:,[1 2]);
        titleName = ['TAIL-'  taskName '-V'];
        labelXtick = {'SV', 'DV'};
        case 'L' 
        structureDir = data2.(taskName).constancy_mean.earIES(:,[1 2]);
        titleName = ['TAIL-'  taskName '-L'];
        labelXtick = {'SL', 'DL'};
                case 'W' 
        structureDir = data2.(taskName).constancy_mean.WIES(:,[1 2]);
        titleName = ['TAIL-'  taskName '-W'];
        labelXtick = {'SW', 'DW'};
end


%% CV ('SCSV' ,'SCDV', 'DCSV', 'DCDV') figure RT 

% params
labelY='IES';
columnN= size(structureDir,2);
rangeAxis = [0 columnN+1 lowRange highRange];
rangeY = [lowRange:rangeGap:highRange];
labelX = 'Condition';

% read data from different groups
group_tone1 = structureDir(1:8,:);
group_pure2 =structureDir(9:22,:);
group_control3 = structureDir(23:43,:);

% average group people
g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

% 2ste
s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

% plot  different groups
x=[ 2 4 7:10 ];
h1=figure;
errorbar(x,repmat(g1,1,3),repmat(s_g1,1,3),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',15);hold on;
errorbar(x,repmat(g2,1,3),repmat(s_g2,1,3),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',15);hold on;
errorbar(x,repmat(g3,1,3),repmat(s_g3,1,3),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',15);


% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
% xlim([0,6])
% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
ylabel('IES');
%xlabel('Condition');
title('TAIL-Location-L ');


set(get(gca,'xlabeL'),'FontSize', 14, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
%set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'bold','FontName','Consolas');%Helvetica
set(get(gca,'title'),'FontSize', 16, 'FontWeight', 'normal','FontName','Consolas');

set(gca,'XTick',[2 4]);
set(gca,'YTick',lowRange:rangeGap:highRange);
% set(gca,'xticklabel',{'Tone','Consonant','Vowel','sllyable','Word','Location'});
%change order in accordance with paper(RAM)
box off
set(gca,'xticklabel',{'SL','DL'});%,'Tone'
%set(get(gca,'xticklabel'),'FontSize', 18, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
axis([0 6 lowRange highRange])
% pp = get(gcf, 'position');
% pp(3) = pp(3)/2;
% set(gcf, 'position', pp)
%grid on


end
end
