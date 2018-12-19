%%  plot_phoneme level 
% 
% CVT:
% tone(2)*consonant(2)*vowel(2)
%
% NOTE: change code for deleting 2-007 or not!!

load data2B.mat;


%% FD threshold
    lowRange =0.3;
    highRange = 1.2;
    rangeGap = 0.2;

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
subplot(2,2,1);
errorbar(x,repmat(g1,1,6),repmat(s_g1,1,6),'s','color','k','LineWidth',1,'MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',13);hold on;
errorbar(x,repmat(g2,1,6),repmat(s_g2,1,6),'v','color','k','LineWidth',1,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerSize',13);hold on;
errorbar(x,repmat(g3,1,6),repmat(s_g3,1,6),'o','color','k','LineWidth',1,'MarkerFaceColor','w','MarkerSize',13);


ylabel('Threshold (log10)');
%xlabel('Condition');
%title('Frequency discrimination ');


 set(get(gca,'xlabeL'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');
set(gca,'XTick',3);
set(gca,'YTick',lowRange:rangeGap:highRange);
% set(gca,'xticklabel',{'Tone','Consonant','Vowel','sllyable','Word','Location'});
%change order in accordance with paper(RAM)
box off
set(gca,'xticklabel',{'Frequency discrimination','',''});%,'Tone'
%set(get(gca,'xticklabel'),'FontSize', 18, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
axis([0 6 lowRange highRange])
%grid on
T=legend('Tone agnosics','Pure amusics','Controls','Location','northeast');
%% tone test (RT ER IES)
%% figure IES
    lowRange =1;
    highRange = 2.4;
    rangeGap = 0.3;
    
% group_tone1 = data2.summaryIES(1:8,6)./1000;
% group_pure2 = data2.summaryIES(9:22,6)./1000;
% group_control3 = data2.summaryIES(23:43,6)./1000;

group_tone1 = data2.summaryLISAS(1:8,6);
group_pure2 = data2.summaryLISAS(9:22,6);
group_control3 = data2.summaryLISAS(23:43,6);


L = length(data2.summaryIES);

g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

x=[3,7:11 ];
subplot(2,2,2);
hold on;
errorbar(x,repmat(g1,1,6),repmat(s_g1,1,6),'s','color','k','LineWidth',1,'MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',13);hold on;
errorbar(x,repmat(g2,1,6),repmat(s_g2,1,6),'v','color','k','LineWidth',1,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerSize',13);hold on;
errorbar(x,repmat(g3,1,6),repmat(s_g3,1,6),'o','color','k','LineWidth',1,'MarkerFaceColor','w','MarkerSize',13);

% xlim([0,6])
% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
ylabel('LISAS');
%xlabel('Condition');
%title('TAIL-TONE-IES ');
T=legend('Tone agnosics','Pure amusics','Controls','Location','northeast');

 set(get(gca,'xlabeL'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');

set(gca,'XTick',3);
set(gca,'YTick',lowRange:rangeGap:highRange);
% set(gca,'xticklabel',{'Tone','Consonant','Vowel','sllyable','Word','Location'});
%change order in accordance with paper(RAM)
box off
set(gca,'xticklabel',{'Tone Classification','',''});%,'Tone'
%set(get(gca,'xticklabel'),'FontSize', 18, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
axis([0 6 lowRange highRange])
% pp = get(gcf, 'position');
% pp(3) = pp(3)/2;
% set(gcf, 'position', pp)
%grid on

%% plot RT ER
    lowRange =0.8;
    highRange = 1.4;
    rangeGap = 0.1;
    
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
subplot(2,2,3);
hold on;
errorbar(x,repmat(g1,1,6),repmat(s_g1,1,6),'s','color','k','LineWidth',1,'MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',13);hold on;
errorbar(x,repmat(g2,1,6),repmat(s_g2,1,6),'v','color','k','LineWidth',1,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerSize',13);hold on;
errorbar(x,repmat(g3,1,6),repmat(s_g3,1,6),'o','color','k','LineWidth',1,'MarkerFaceColor','w','MarkerSize',13);

% xlim([0,6])
T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
ylabel('RT (s)');
%xlabel('Condition');
%title('TAIL-TONE-IES ');


 set(get(gca,'xlabeL'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');

set(gca,'XTick',3);
set(gca,'YTick',lowRange:rangeGap:highRange);
% set(gca,'xticklabel',{'Tone','Consonant','Vowel','sllyable','Word','Location'});
%change order in accordance with paper(RAM)
box off
set(gca,'xticklabel',{'Tone Classification','',''});%,'Tone'
%set(get(gca,'xticklabel'),'FontSize', 18, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
axis([0 6 lowRange highRange])
% pp = get(gcf, 'position');
% pp(3) = pp(3)/2;
% set(gcf, 'position', pp)
%grid on
 

%% ER
lowRange =0;
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
subplot(2,2,4);
hold on;
errorbar(x,repmat(g1,1,6),repmat(s_g1,1,6),'s','color','k','LineWidth',1,'MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',13);hold on;
errorbar(x,repmat(g2,1,6),repmat(s_g2,1,6),'v','color','k','LineWidth',1,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerSize',13);hold on;
errorbar(x,repmat(g3,1,6),repmat(s_g3,1,6),'o','color','k','LineWidth',1,'MarkerFaceColor','w','MarkerSize',13);

% xlim([0,6])
T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
ylabel('Error Rate (%)');
%xlabel('Condition');
%title('TAIL-TONE-IES ');


 set(get(gca,'xlabeL'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');

set(gca,'XTick',3);
set(gca,'YTick',lowRange:rangeGap:highRange);
% set(gca,'xticklabel',{'Tone','Consonant','Vowel','sllyable','Word','Location'});
%change order in accordance with paper(RAM)
box off
set(gca,'xticklabel',{'Tone Classification','',''});%,'Tone'
%set(get(gca,'xticklabel'),'FontSize', 18, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
axis([0 6 lowRange highRange])
% pp = get(gcf, 'position');
% pp(3) = pp(3)/2;
% set(gcf, 'position', pp)
%grid on
