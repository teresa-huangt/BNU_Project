%%  plot_agnosia_SpeechTAIL 
% 
% 1.1 Tone 
% 1.2 Consonant 
% 1.3 Vowel 
% 1.4 Phoneme /sllyable
% 1.5 Word 
% 1.6 Location
%
% NOTE: change code for deleting 2-007 or not!!

load data2B.mat;


%% figure RT
% group_tone1 = data2.summary([1:5,8],1:2:12); %delete 2-0007
group_tone1 = data2.summaryLISAS(1:8,[1:5]);
group_pure2 = data2.summaryLISAS(9:22,[1:5]);
group_control3 = data2.summaryLISAS(23:43,[1:5]);

g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

s_g1=nanste(group_tone1);
s_g2=nanste(group_pure2);
s_g3=nanste(group_control3);

x=[ 1 : 5 ];
h1=figure;
errorbar(x,g1,s_g1,'s','color','k','LineWidth',1,'MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',13);hold on;
errorbar(x,g2,s_g2,'v','color','k','LineWidth',1,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerSize',13);hold on;
errorbar(x,g3,s_g3,'o','color','k','LineWidth',1,'MarkerFaceColor','w','MarkerSize',13);


% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
ylabel('Linear integrated speed-accuracy scores(LISAS)');
xlabel('Condition');
title('Speech Classification ');


 set(get(gca,'xlabeL'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 10, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');
set(gca,'XTick',1:5);
set(gca,'YTick',0.6:0.2:1.8);
% set(gca,'xticklabel',{'Tone','Consonant','Vowel','sllyable','Word','Location'});
%change order in accordance with paper(RAM)
box off
set(gca,'xticklabel',{'Location','Word','sllyable','Consonant','Vowel'});%,'Tone'
%set(get(gca,'xticklabel'),'FontSize', 18, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
axis([0 6 0.6 1.8])
grid off
%axis off
T=legend('Tone agnosics','Pure amusics','Controls','Location','northeast');
% %% figure Error Rate
% group_tone1 = data2.summary([1:5,8],2:2:12).*100; %delete 2-0007
% %group_tone1 = data2.summary(1:8,2:2:12).*100;
% group_pure2 = data2.summary(9:22,2:2:12).*100;
% group_control3 = data2.summary(23:43,2:2:12).*100;
% 
% g1=nanmean(group_tone1);
% g2=nanmean(group_pure2);
% g3=nanmean(group_control3);
% 
% s_g1=nanste(group_tone1);
% s_g2=nanste(group_pure2);
% s_g3=nanste(group_control3);
% 
% x=[ 1 : 6 ];
% h2=figure;
% errorbar(x,g1,s_g1,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);hold on;
% errorbar(x,g2,s_g2,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',[0.3 0.3 0.3 ],'MarkerSize',10);hold on;
% errorbar(x,g3,s_g3,'cs','color',[0.3 0.3 0.3  ],'LineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',10);
% 
% T=legend('tone-agnosia','pure-amusia','control');
% set(T,'Fontsize',12); 
% ylabel('Error Rate (%)');
% xlabel('Condition');
% title('SpeechTAIL ');
% 
% 
% set(get(gca,'xlabeL'),'FontSize', 14, 'FontWeight', 'Bold','FontName','Microsoft YaHei');
% set(get(gca,'ylabel'),'FontSize', 16, 'FontWeight', 'bold','FontName','Consolas');%Helvetica
% set(get(gca,'title'),'FontSize', 16, 'FontWeight', 'normal','FontName','Consolas');
% 
% set(gca,'XTick',1:6);
% % set(gca,'xticklabel',{'Tone','Consonant','Vowel','sllyable','Word','Location'});
% %change order in accordance with paper(RAM)
% box off
% set(gca,'xticklabel',{'Location','Word','sllyable','Consonant','Vowel','Tone'});
% axis([0 7 0 20])
% grid on

