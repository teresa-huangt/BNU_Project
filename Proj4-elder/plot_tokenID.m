function plot_tokenID(groupN)
group1={'train'};
group2={'control'};
load proj4o_group.mat
switch groupN
    case 1
      group=group1
     case 2
      group=group2
    otherwise 
        msgbox('Group not exist, please recheck your input','warn');
end
ILD0pre = proj4o_group.(group).tokenID.ILD0(:,1:5);
ILD0post = proj4o_group.(group).tokenID.ILD0(:,6:10);
ILD3pre = proj4o_group.(group).tokenID.ILD3(:,1:5);
ILD3post =  proj4o_group.(group).tokenID.ILD3(:,6:10);
ILD6pre =  proj4o_group.(group).tokenID.ILD6(:,1:5);
ILD6post = proj4o_group.(group).tokenID.ILD6(:,6:10);
%%
fig1 = figure('units','normalized','color','w');
hold on; 
axis off
a(1)=axes('position',[0.1,0.55,0.27,0.27],'XTick',[-12,-9,-6,-3,0],'XTickLabel',[-12,-9,-6,-3,0]);
hold on;
a(2)=axes('position',[0.4,0.55,0.27,0.27],'XTick',[-12,-9,-6,-3,0],'XTickLabel',[-12,-9,-6,-3,0]);
a(3)=axes('position',[0.7,0.55,0.27,0.27],'XTick',[-12,-9,-6,-3,0],'XTickLabel',[-12,-9,-6,-3,0]);

a(4)=axes('position',[0.1,0.1,0.27,0.27],'XTick',[-12,-9,-6,-3,0],'XTickLabel',[-12,-9,-6,-3,0]);
a(5)=axes('position',[0.4,0.1,0.27,0.27],'XTick',[-12,-9,-6,-3,0],'XTickLabel',[-12,-9,-6,-3,0]);
a(6)=axes('position',[0.7,0.1,0.27,0.27],'XTick',[-12,-9,-6,-3,0],'XTickLabel',[-12,-9,-6,-3,0]);



% p0 = proj4_followup.tokenID.tokenID0ILD;
% p3 = proj4_followup.tokenID.tokenID3ILD;
% p6 = proj4_followup.tokenID.tokenID6ILD;

for n = 1:6%number of sub
    axes(a(n));
P1 = plot([-12,-9,-6,-3,0],ILD0pre(n,:),'-k^');
hold on;
P2 = plot([-12,-9,-6,-3,0],ILD3pre(n,:),'-g^');
P3 = plot([-12,-9,-6,-3,0],ILD6pre(n,:),'-b^');
set(P1,'MarkerFaceColor','k','MarkerSize',5,'LineWidth',1);
set(P2,'MarkerFaceColor','g','MarkerSize',5,'LineWidth',1);
set(P3,'MarkerFaceColor','b','MarkerSize',5,'LineWidth',1);
%title('Group 8p ')
xlabel('SNR');
ylabel('Corrent Percent')
hold on;
if n ==1
legend({'0ILD','3ILD','6ILD'},'Location','Northwest');
end


set(a(n),'XTick',[-12,-9,-6,-3,0]);
ylim([0,1]);
xlim([-12,0])
end
%saveas(fig1,'figures/tokenID_individual_pre')
%saveas(fig1,'figures_c/tokenID_individual_pre')
saveas(fig1,'figures_t/tokenID_individual_pre')
%%
fig2 = figure('units','normalized','color','w');
hold on;
axis off
a(1)=axes('position',[0.1,0.55,0.27,0.27],'XTick',[-12,-9,-6,-3,0],'XTickLabel',[-12,-9,-6,-3,0]);
hold on;
a(2)=axes('position',[0.4,0.55,0.27,0.27],'XTick',[-12,-9,-6,-3,0],'XTickLabel',[-12,-9,-6,-3,0]);
a(3)=axes('position',[0.7,0.55,0.27,0.27],'XTick',[-12,-9,-6,-3,0],'XTickLabel',[-12,-9,-6,-3,0]);

a(4)=axes('position',[0.1,0.1,0.27,0.27],'XTick',[-12,-9,-6,-3,0],'XTickLabel',[-12,-9,-6,-3,0]);
a(5)=axes('position',[0.4,0.1,0.27,0.27],'XTick',[-12,-9,-6,-3,0],'XTickLabel',[-12,-9,-6,-3,0]);
a(6)=axes('position',[0.7,0.1,0.27,0.27],'XTick',[-12,-9,-6,-3,0],'XTickLabel',[-12,-9,-6,-3,0]);


% p0 = proj4_followup.tokenID.tokenID0ILD;
% p3 = proj4_followup.tokenID.tokenID3ILD;
% p6 = proj4_followup.tokenID.tokenID6ILD;

for n = 1:6%
    axes(a(n));
P4 = plot([-12,-9,-6,-3,0],ILD0post(n,:),'-.k^');
hold on;
P5 = plot([-12,-9,-6,-3,0],ILD3post(n,:),'-.g^');
P6 = plot([-12,-9,-6,-3,0],ILD6post(n,:),'-.b^');
set(P4,'MarkerFaceColor','k','MarkerSize',5,'LineWidth',1);
set(P5,'MarkerFaceColor','g','MarkerSize',5,'LineWidth',1);
set(P6,'MarkerFaceColor','b','MarkerSize',5,'LineWidth',1);
%title('Group 8p ')
xlabel('SNR');
ylabel('Corrent Percent')
hold on;
if n ==1
legend({'0ILD','3ILD','6ILD'},'Location','Northwest');
end

set(a(n),'XTick',[-12,-9,-6,-3,0]);
ylim([0,1]);
xlim([-12,0])
end
%saveas(fig2,'figures_c/tokenID_individual_post')
saveas(fig2,'figures_t/tokenID_individual_post')


%%
fig3=figure( 'Units', 'normalized','position', [0.2,0.15, 0.65, 0.8],'color','w');

subplot(1,2,1,'XTick',[-12,-9,-6,-3,0]);
hold on;
set(gca,'FontSize',18);

P1 = errorbar([-12,-9,-6,-3,0],nanmean(ILD0pre),nanste(ILD0pre),'-k^');
hold on;
P2 = errorbar([-12,-9,-6,-3,0],nanmean(ILD3pre),nanste(ILD3pre),'-g^');
P3 = errorbar([-12,-9,-6,-3,0],nanmean(ILD6pre),nanste(ILD6pre),'-b^');
set(P1,'MarkerFaceColor','k','MarkerSize',5,'LineWidth',2);
set(P2,'MarkerFaceColor','g','MarkerSize',5,'LineWidth',2);
set(P3,'MarkerFaceColor','b','MarkerSize',5,'LineWidth',2);

title ('Pre')
xlabel('信噪比');
ylabel('正确率')
legend({'0ILD','3ILD','6ILD'},'Location','Northwest');

subplot(1,2,2,'XTick',[-12,-9,-6,-3,0]);
hold on;
set(gca,'FontSize',18);

P4 = errorbar([-12,-9,-6,-3,0],nanmean(ILD0post),nanste(ILD0post),'-.k^');
hold on;
P5 = errorbar([-12,-9,-6,-3,0],nanmean(ILD3post),nanste(ILD3post),'-.g^');
P6 = errorbar([-12,-9,-6,-3,0],nanmean(ILD6post),nanste(ILD6post),'-.b^');
set(P4,'MarkerFaceColor','k','MarkerSize',5,'LineWidth',2);
set(P5,'MarkerFaceColor','g','MarkerSize',5,'LineWidth',2);
set(P6,'MarkerFaceColor','b','MarkerSize',5,'LineWidth',2);

title ('Post')
xlabel('信噪比');
ylabel('正确率')
%legend({'0ILD','3ILD','6ILD'},'Location','Northwest');
%saveas(fig3,'figures_c/tokenID_group1')
saveas(fig3,'figures_t/tokenID_group1')
%%
fig4=figure( 'Units', 'normalized','position', [0.2,0.15, 0.65, 0.8],'color','w');

subplot(2,2,1,'XTick',[-12,-9,-6,-3,0]);
hold on;
set(gca,'FontSize',18);

P1 = errorbar([-12,-9,-6,-3,0],nanmean(ILD0pre),nanste(ILD0pre),'-k^');
hold on;
P2 = errorbar([-12,-9,-6,-3,0],nanmean(ILD0post),nanste(ILD0post),'-r^');
set(P1,'MarkerFaceColor','k','MarkerSize',5,'LineWidth',2);
set(P2,'MarkerFaceColor','r','MarkerSize',5,'LineWidth',2);
title ('0 dB')
xlabel('信噪比');
ylabel('正确率')
legend({'Pre','Post'},'Location','Northwest');
hold on;
subplot(2,2,2,'XTick',[-12,-9,-6,-3,0]);
hold on;
set(gca,'FontSize',18);

P1 = errorbar([-12,-9,-6,-3,0],nanmean(ILD3pre),nanste(ILD3pre),'-k^');
hold on;
P2 = errorbar([-12,-9,-6,-3,0],nanmean(ILD3post),nanste(ILD3post),'-r^');
set(P1,'MarkerFaceColor','k','MarkerSize',5,'LineWidth',2);
set(P2,'MarkerFaceColor','r','MarkerSize',5,'LineWidth',2);

title ('3 dB')
xlabel('信噪比');
ylabel('正确率')

subplot(2,2,3,'XTick',[-12,-9,-6,-3,0]);
hold on;
set(gca,'FontSize',18);

P1 = errorbar([-12,-9,-6,-3,0],nanmean(ILD6pre),nanste(ILD6pre),'-k^');
hold on;
P2 = errorbar([-12,-9,-6,-3,0],nanmean(ILD6post),nanste(ILD6post),'-r^');
set(P1,'MarkerFaceColor','k','MarkerSize',5,'LineWidth',2);
set(P2,'MarkerFaceColor','r','MarkerSize',5,'LineWidth',2);

title ('6 dB')
xlabel('信噪比');
ylabel('正确率')
%legend({'0ILD','3ILD','6ILD'},'Location','Northwest');
%saveas(fig4,'figures_c/tokenID_group2')
saveas(fig4,'figures_t/tokenID_group2')


%%
fig5=figure( 'Units', 'normalized','position', [0.2,0.15, 0.65, 0.8],'color','w');

subplot(2,2,1,'XTick',[-12,-9,-6,-3,0]);
hold on;
set(gca,'FontSize',18);

P1 = errorbar([-12,-9,-6,-3,0],nanmean(ILD3pre - ILD0pre),nanste(ILD3pre - ILD0pre),'-k^');
hold on;
P2 = errorbar([-12,-9,-6,-3,0],nanmean(ILD3post - ILD0post),nanste(ILD3post - ILD0post),'-r^');
%P3 = plot([-12,-9,-6,-3,0],nanmean(ILD6pre),'-b^');
set(P1,'MarkerFaceColor','k','MarkerSize',5,'LineWidth',2);
set(P2,'MarkerFaceColor','r','MarkerSize',5,'LineWidth',2);
%set(P3,'MarkerFaceColor','b','MarkerSize',5,'LineWidth',2);

title ('3-0')
xlabel('信噪比');
ylabel('正确率')
legend({'Pre','Post'},'Location','Northwest');

subplot(2,2,2,'XTick',[-12,-9,-6,-3,0]);
hold on;
set(gca,'FontSize',18);

P1 = errorbar([-12,-9,-6,-3,0],nanmean(ILD6pre - ILD0pre),nanste(ILD6pre - ILD0pre),'-k^');
hold on;
P2 = errorbar([-12,-9,-6,-3,0],nanmean(ILD6post - ILD0post),nanste(ILD6post - ILD0post),'-r^');
%P3 = plot([-12,-9,-6,-3,0],nanmean(ILD6pre),'-b^');
set(P1,'MarkerFaceColor','k','MarkerSize',5,'LineWidth',2);
set(P2,'MarkerFaceColor','r','MarkerSize',5,'LineWidth',2);
%set(P3,'MarkerFaceColor','b','MarkerSize',5,'LineWidth',2);

title ('6-0')
xlabel('信噪比');
ylabel('正确率')
%legend({'Pre','Post'},'Location','Northwest');

subplot(2,2,3,'XTick',[-12,-9,-6,-3,0]);
hold on;
set(gca,'FontSize',18);

P1 = errorbar([-12,-9,-6,-3,0],nanmean(ILD3post - ILD0post-(ILD3pre - ILD0pre)),nanste(ILD3post - ILD0post-(ILD3pre - ILD0pre)),'-k^');
hold on;
%P2 = errorbar([-12,-9,-6,-3,0],nanmean(ILD3post - ILD0post),nanste(ILD3post - ILD0post),'-r^');
%P3 = plot([-12,-9,-6,-3,0],nanmean(ILD6pre),'-b^');
set(P1,'MarkerFaceColor','k','MarkerSize',5,'LineWidth',2);
%set(P2,'MarkerFaceColor','b','MarkerSize',5,'LineWidth',2);
%set(P3,'MarkerFaceColor','b','MarkerSize',5,'LineWidth',2);

title ('3-0')
xlabel('信噪比');
ylabel('正确率')
legend({'Post-pre'},'Location','Northwest');


subplot(2,2,4,'XTick',[-12,-9,-6,-3,0]);
hold on;
set(gca,'FontSize',18);

P1 = errorbar([-12,-9,-6,-3,0],nanmean(ILD6post - ILD0post-(ILD6pre - ILD0pre)),nanste(ILD6post - ILD0post-(ILD6pre - ILD0pre)),'-k^');
hold on;
%P2 = errorbar([-12,-9,-6,-3,0],nanmean(ILD3post - ILD0post),nanste(ILD3post - ILD0post),'-r^');
%P3 = plot([-12,-9,-6,-3,0],nanmean(ILD6pre),'-b^');
set(P1,'MarkerFaceColor','k','MarkerSize',5,'LineWidth',2);
%set(P2,'MarkerFaceColor','b','MarkerSize',5,'LineWidth',2);
%set(P3,'MarkerFaceColor','b','MarkerSize',5,'LineWidth',2);

title ('6-0')
xlabel('信噪比');
ylabel('正确率')
%legend({'Post-pre'},'Location','Northwest');

%saveas(fig5,'figures_c/tokenID_group_SRM')
saveas(fig5,'figures_t/tokenID_group_SRM')







