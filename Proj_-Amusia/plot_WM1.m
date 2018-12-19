%% plot WM-Auditory,WM-Visual
 load data2B.mat
lowRange =0.4;
    highRange = 1.6;
    rangeGap = 0.2;

group_tone1 = data2.group_otherTasks(1:8,2);
group_pure2 = data2.group_otherTasks(9:22,2);
group_control3 = data2.group_otherTasks(23:43,2);

g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

x=[ 3, 7:11 ];
figure;
subplot(1,3,1);
errorbar(x,repmat(g1,1,6),repmat(s_g1,1,6),'s','color','k','LineWidth',1,'MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',13);hold on;
errorbar(x,repmat(g2,1,6),repmat(s_g2,1,6),'v','color','k','LineWidth',1,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerSize',13);hold on;
errorbar(x,repmat(g3,1,6),repmat(s_g3,1,6),'o','color','k','LineWidth',1,'MarkerFaceColor','w','MarkerSize',13);


% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
% xlim([0,6])
% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
ylabel('Score');
%xlabel('Condition');
%title('TAIL-TONE-IES ');


 set(get(gca,'xlabeL'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');

set(gca,'XTick',[3]);
set(gca,'YTick',lowRange:rangeGap:highRange);
% set(gca,'xticklabel',{'Tone','Consonant','Vowel','sllyable','Word','Location'});
%change order in accordance with paper(RAM)
box off
set(gca,'xticklabel',{'WM-auditory','',''});%,'Tone'
%set(get(gca,'xticklabel'),'FontSize', 18, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
axis([0 6 lowRange highRange])
% pp = get(gcf, 'position');
% pp(3) = pp(3)/2;
% set(gcf, 'position', pp)
%grid on
T=legend('Tone agnosics','Pure amusics','Controls','Location','northeast');
set(T,'Fontsize',9); 

%%
lowRange =0.6;
    highRange = 1.8;
    rangeGap = 0.2;

group_tone1 = data2.group_otherTasks(1:8,3);
group_pure2 = data2.group_otherTasks(9:22,3);
group_control3 = data2.group_otherTasks(23:43,3);

g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

x=[ 3, 7:11 ];

subplot(1,3,2);
errorbar(x,repmat(g1,1,6),repmat(s_g1,1,6),'s','color','k','LineWidth',1,'MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',13);hold on;
errorbar(x,repmat(g2,1,6),repmat(s_g2,1,6),'v','color','k','LineWidth',1,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerSize',13);hold on;
errorbar(x,repmat(g3,1,6),repmat(s_g3,1,6),'o','color','k','LineWidth',1,'MarkerFaceColor','w','MarkerSize',13);


% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
% xlim([0,6])
% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
ylabel('Score');
%xlabel('Condition');
%title('TAIL-TONE-IES ');


 set(get(gca,'xlabeL'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');

set(gca,'XTick',[3]);
set(gca,'YTick',lowRange:rangeGap:highRange);
% set(gca,'xticklabel',{'Tone','Consonant','Vowel','sllyable','Word','Location'});
%change order in accordance with paper(RAM)
box off
set(gca,'xticklabel',{'WM-visual','',''});%,'Tone'
%set(get(gca,'xticklabel'),'FontSize', 18, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
axis([0 6 lowRange highRange])
T=legend('Tone agnosics','Pure amusics','Controls','Location','northeast');
set(T,'Fontsize',9); 
% pp = get(gcf, 'position');
% pp(3) = pp(3)/2;
% set(gcf, 'position', pp)
%grid on

%% digit Span
%% plot digitSpan
lowRange =9;
    highRange = 15;
    rangeGap = 1;
group_tone1 = data2.group_otherTasks(1:8,4);
group_pure2 = data2.group_otherTasks(9:22,4);
group_control3 = data2.group_otherTasks(23:43,4);

g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

x=[ 3, 7:11 ];

subplot(1,3,3);
errorbar(x,repmat(g1,1,6),repmat(s_g1,1,6),'s','color','k','LineWidth',1,'MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',13);hold on;
errorbar(x,repmat(g2,1,6),repmat(s_g2,1,6),'v','color','k','LineWidth',1,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerSize',13);hold on;
errorbar(x,repmat(g3,1,6),repmat(s_g3,1,6),'o','color','k','LineWidth',1,'MarkerFaceColor','w','MarkerSize',13);



T=legend('Tone agnosics','Pure amusics','Controls','Location','northeast');
set(T,'Fontsize',9); 
ylabel('Score');
% xlabel('Condition');
% title('Backward digit span');

 set(get(gca,'xlabeL'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');

set(gca,'XTick',[3]);
set(gca,'YTick',lowRange:rangeGap:highRange);

box off
set(gca,'xticklabel',{'DigitSpan'});
axis([0 6 lowRange highRange])
grid off
