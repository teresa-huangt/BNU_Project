%% plot hearing threshold level(HTL) :
%Right,Left, (R+L)

%NOTE:

%% INSERT
load data2B.mat;
% calibration (原程序中均-10，根据SPL/HL转换表进行调整)
% http://hearinglosshelp.com/blog/understanding-the-difference-between-sound-pressure-level-spl-and-hearing-level-hl-in-measuring-hearing-loss/
c = [-17,-3.5,2.5,1,-2,-6];
c = repmat(c,43,1);

%% L
left0 = data2.toneAudiometry(:,1:2:11);
left = left0+c;
meanleft = mean(left);
% by group
group_tone1 = left(1:8,:);
group_pure2 =left(9:22,:);
group_control3 = left(23:43,:);
% average group people
g1L=nanmean(group_tone1);
g2L=nanmean(group_pure2);
g3L=nanmean(group_control3);

%% R
right0 = data2.toneAudiometry(:,2:2:12);
right = right0+c;
meanright = mean(right);
% by group
group_tone1 = right(1:8,:);
group_pure2 =right(9:22,:);
group_control3 = right(23:43,:);
% average group people
g1R=nanmean(group_tone1);
g2R=nanmean(group_pure2);
g3R=nanmean(group_control3);

%% (L+R)/2
bothEar = (left + right)./2;
meanboth = mean(bothEar);
% by group
group_tone1 = bothEar(1:8,:);
group_pure2 =bothEar(9:22,:);
group_control3 = bothEar(23:43,:);
% average group people
g1=nanmean(group_tone1);
g2=nanmean(group_pure2);
g3=nanmean(group_control3);

% GAP
gapear = right - left;
% SAVE
% proj11_agnosia.meantoneAudiometry=bothEar;
%  save proj11_agnosia   proj11_agnosia
x=[ 1 2 3 4 5 6 ];
color_list={[0.3 0.3 0.3 ],[0.0 0.8 0.6],[0.0 0.4 0.6],[0.4 0.6 0.6]};

%% R+L EAR; GROUP MEAN

h2 = figure;

plot(x,g1,'o-','color','k','LineWidth',1,'MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',13);
hold on
plot(x,g2,'v--','color','k','LineWidth',1,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerSize',13);
hold on
plot(x,g3,'s-.','color','k','LineWidth',1,'MarkerFaceColor','w','MarkerSize',13);
hold on

T=legend('Tone agnosics','Pure amusics','Controls','Location','southwest');
set(T,'Fontsize',12); 
% line([0,7],[20 20]);
% line([0 7],[40 40]);
set(gca,'XTick',1:6);
set(gca,'Xticklabel',[250 500 1000 2000 4000 6000]);
% xlabel('Frequency (Hz)');
ylabel('Hearing Level (HL) in dB)');
title('Frequency in Hertz (Hz)');
 set(get(gca,'xlabeL'),'FontSize', 12, 'FontWeight', 'bold','FontName','Microsoft YaHei');
set(get(gca,'ylabel'),'FontSize', 14, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');
axis([0 7 -20 50]);
axis ij
set(gca,'YTick',[-20:10:50]);
%set(gca,'ydir','reverse')
grid on


%% R&L; GROUP MEAN
% L
h3= figure;
subplot(1,2,1);
plot(x,g1L,'o-','color','k','LineWidth',1,'MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',13);
hold on
plot(x,g2L,'v--','color','k','LineWidth',1,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerSize',13);
hold on
plot(x,g3L,'s-.','color','k','LineWidth',1,'MarkerFaceColor','w','MarkerSize',13);

T=legend('Tone agnosics','Pure amusics','Controls','Location','southwest');
set(T,'Fontsize',12); 
% line([0,7],[20 20]);
% line([0 7],[40 40]);
set(gca,'XTick',1:6);
set(gca,'Xticklabel',[250 500 1000 2000 4000 6000]);
xlabel('Frequency (Hz)');
ylabel('Hearing Level (HL) in dB)');
title('Left');
set(get(gca,'xlabeL'),'FontSize', 12, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 14, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');
axis([0 7 -20 50]);
axis ij
set(gca,'YTick',[-20:10:50]);
%set(gca,'ydir','reverse')
grid on

% R
subplot(1,2,2)
plot(x,g1R,'o-','color','k','LineWidth',1,'MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',13);
hold on
plot(x,g2R,'v--','color','k','LineWidth',1,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerSize',13);
hold on
plot(x,g3R,'s-.','color','k','LineWidth',1,'MarkerFaceColor','w','MarkerSize',13);


T=legend('Tone agnosics','Pure amusics','Controls','Location','southwest');
set(T,'Fontsize',12); 
% line([0,7],[20 20]);
% line([0 7],[40 40]);
set(gca,'XTick',1:6);
set(gca,'Xticklabel',[250 500 1000 2000 4000 6000]);
xlabel('Frequency (Hz)');
ylabel('Hearing Level (HL) in dB)');
title('Right');
 set(get(gca,'xlabeL'),'FontSize', 12, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 14, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');
axis([0 7 -20 50]);
axis ij
set(gca,'YTick',[-20:10:50]);
%set(gca,'ydir','reverse')
grid on