%%  plot_phoneme level 
% 
% CVT:
% tone(2)*consonant(2)*vowel(2)
%
% NOTE: change code for deleting 2-007 or not!!

load data2B.mat;


%% FD threshold
    lowRange =0.2;
    highRange = 1.2;
    rangeGap = 0.2;
%group_tone1 = data2.summary([1:5,8],1:2:12); %delete 2-0007
group_tone1 = data2.FDgroup2(1:8,3);
group_pure2 = data2.FDgroup2(9:22,3);
group_control3 = data2.FDgroup2(23:43,3);

g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

x=[ 3,7:11 ];
h1=figure;
errorbar(x,repmat(g1,1,6),repmat(s_g1,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',15);hold on;
errorbar(x,repmat(g2,1,6),repmat(s_g2,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',15);hold on;
errorbar(x,repmat(g3,1,6),repmat(s_g3,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',15);


ylabel('Threshold (log10)');
%xlabel('Condition');
%title('Frequency discrimination ');


set(get(gca,'xlabeL'),'FontSize', 14, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
%set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'bold','FontName','Consolas');%Helvetica
set(get(gca,'title'),'FontSize', 16, 'FontWeight', 'normal','FontName','Consolas');

set(gca,'XTick',3);
set(gca,'YTick',lowRange:rangeGap:highRange);
% set(gca,'xticklabel',{'Tone','Consonant','Vowel','sllyable','Word','Location'});
%change order in accordance with paper(RAM)
box off
set(gca,'xticklabel',{'Frequency discrimination','',''});%,'Tone'
%set(get(gca,'xticklabel'),'FontSize', 18, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
axis([0 6 lowRange highRange])
% pp = get(gcf, 'position');
% pp(3) = pp(3)/2;
% set(gcf, 'position', pp)
%grid on

