%%  plot_agnosia_SpeechTAIL 
% 
% 1.1 Tone 
% RT/ER/IES

load data2B.mat;


%% figure IES
    lowRange =800;
    highRange = 1800;
    rangeGap = 200;
    
group_tone1 = data2.summaryIES(1:8,6);
group_pure2 = data2.summaryIES(9:22,6);
group_control3 = data2.summaryIES(23:43,6);

L = length(data2.summaryIES);

g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

x=[3,7:11 ];
h1=figure;
hold on;
errorbar(x,repmat(g1,1,6),repmat(s_g1,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',15);hold on;
errorbar(x,repmat(g2,1,6),repmat(s_g2,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',15);hold on;
errorbar(x,repmat(g3,1,6),repmat(s_g3,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',15);

% xlim([0,6])
% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
ylabel('IES');
%xlabel('Condition');
%title('TAIL-TONE-IES ');


set(get(gca,'xlabeL'),'FontSize', 14, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
%set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'bold','FontName','Consolas');%Helvetica
set(get(gca,'title'),'FontSize', 16, 'FontWeight', 'normal','FontName','Consolas');

set(gca,'XTick',3);
set(gca,'YTick',lowRange:rangeGap:highRange);
% set(gca,'xticklabel',{'Tone','Consonant','Vowel','sllyable','Word','Location'});
%change order in accordance with paper(RAM)
box off
set(gca,'xticklabel',{'TAIL Tone','',''});%,'Tone'
%set(get(gca,'xticklabel'),'FontSize', 18, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
axis([0 6 lowRange highRange])
% pp = get(gcf, 'position');
% pp(3) = pp(3)/2;
% set(gcf, 'position', pp)
%grid on

%% plot RT ER
    lowRange =0.8;
    highRange = 1.4;
    rangeGap = 0.2;
    
group_tone1 = data2.summary(1:8,11);
group_pure2 = data2.summary(9:22,11);
group_control3 = data2.summary(23:43,11);

g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

x=[3,7:11 ];
h1=figure;
hold on;
errorbar(x,repmat(g1,1,6),repmat(s_g1,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',15);hold on;
errorbar(x,repmat(g2,1,6),repmat(s_g2,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',15);hold on;
errorbar(x,repmat(g3,1,6),repmat(s_g3,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',15);

% xlim([0,6])
% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
ylabel('RT (s)');
%xlabel('Condition');
%title('TAIL-TONE-IES ');


set(get(gca,'xlabeL'),'FontSize', 14, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
%set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'bold','FontName','Consolas');%Helvetica
set(get(gca,'title'),'FontSize', 16, 'FontWeight', 'normal','FontName','Consolas');

set(gca,'XTick',3);
set(gca,'YTick',lowRange:rangeGap:highRange);
% set(gca,'xticklabel',{'Tone','Consonant','Vowel','sllyable','Word','Location'});
%change order in accordance with paper(RAM)
box off
set(gca,'xticklabel',{'TAIL Tone','',''});%,'Tone'
%set(get(gca,'xticklabel'),'FontSize', 18, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
axis([0 6 lowRange highRange])
% pp = get(gcf, 'position');
% pp(3) = pp(3)/2;
% set(gcf, 'position', pp)
%grid on
 

%% ER
lowRange =2;
    highRange = 22;
    rangeGap = 4;
    
group_tone1 = data2.summary(1:8,12)*100;
group_pure2 = data2.summary(9:22,12)*100;
group_control3 = data2.summary(23:43,12)*100;

g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

x=[3,7:11 ];
h1=figure;
hold on;
errorbar(x,repmat(g1,1,6),repmat(s_g1,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',15);hold on;
errorbar(x,repmat(g2,1,6),repmat(s_g2,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',15);hold on;
errorbar(x,repmat(g3,1,6),repmat(s_g3,1,6),'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',15);

% xlim([0,6])
% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
ylabel('Error Rate (%)');
%xlabel('Condition');
%title('TAIL-TONE-IES ');


set(get(gca,'xlabeL'),'FontSize', 14, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
%set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'bold','FontName','Consolas');%Helvetica
set(get(gca,'title'),'FontSize', 16, 'FontWeight', 'normal','FontName','Consolas');

set(gca,'XTick',3);
set(gca,'YTick',lowRange:rangeGap:highRange);
% set(gca,'xticklabel',{'Tone','Consonant','Vowel','sllyable','Word','Location'});
%change order in accordance with paper(RAM)
box off
set(gca,'xticklabel',{'TAIL Tone','',''});%,'Tone'
%set(get(gca,'xticklabel'),'FontSize', 18, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
axis([0 6 lowRange highRange])
% pp = get(gcf, 'position');
% pp(3) = pp(3)/2;
% set(gcf, 'position', pp)
%grid on
