%% plot WM-Auditory,WM-Visual
lowRange =0.4;
    highRange = 2;
    rangeGap = 0.4;

group_tone1 = data2.group_otherTasks(1:8,2:3);
group_pure2 = data2.group_otherTasks(9:22,2:3);
group_control3 = data2.group_otherTasks(23:43,2:3);

g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

x=[ 1 3  7:16];
h1=figure;
errorbar(x,repmat(g1,1,6),repmat(s_g1,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',15);hold on;
errorbar(x,repmat(g2,1,6),repmat(s_g2,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',15);hold on;
errorbar(x,repmat(g3,1,6),repmat(s_g3,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',15);


% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
% xlim([0,6])
% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
ylabel('Score');
%xlabel('Condition');
%title('TAIL-TONE-IES ');


set(get(gca,'xlabeL'),'FontSize', 14, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
%set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'bold','FontName','Consolas');%Helvetica
set(get(gca,'title'),'FontSize', 16, 'FontWeight', 'normal','FontName','Consolas');

set(gca,'XTick',[1 3]);
set(gca,'YTick',lowRange:rangeGap:highRange);
% set(gca,'xticklabel',{'Tone','Consonant','Vowel','sllyable','Word','Location'});
%change order in accordance with paper(RAM)
box off
set(gca,'xticklabel',{'WM-auditory','WM-visual'});%,'Tone'
%set(get(gca,'xticklabel'),'FontSize', 18, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
axis([0 4 lowRange highRange])
% pp = get(gcf, 'position');
% pp(3) = pp(3)/2;
% set(gcf, 'position', pp)
%grid on