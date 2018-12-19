%plot hearing threshold level(HTL) :1.(R+L)/2 for Insert 
%                                   2. air-bone gap

%% INSERT
load proj4o_group.mat;
T=proj4o_group.train.HearingThresL;
C=proj4o_group.control.HearingThresL;


T_insert=T(:,1:6)+T(:,7:12);
T_insert=T_insert./2;
mean_T_insert=mean(T_insert);
C_insert=C(:,1:6)+C(:,7:12);
C_insert=C_insert./2;
mean_C_insert=mean(C_insert);

x=[ 1 2 3 4 5 6 ];
color_list={[0.3 0.3 0.3 ],[0.0 0.8 0.6],[0.0 0.4 0.6],[0.4 0.6 0.6]};
%train group
h1=figure;
subplot(1,2,1);
    % plot the mean of hearing level
    plot(x,mean_T_insert,'o-','color',[0.6, 0.00, 0.2],'LineWidth',1.5,'MarkerFaceColor',[0.6, 0.00, 0.2],'MarkerSize',3);
    hold on
    % plot the individual hearing level
[rows,cols]=size(T);
subNumT=rows;
for n1=1:subNumT
    plot(x,T_insert(n1,:),'o-','color',[0.4, 0.6+n1*0.03, 0.6],'LineWidth',0.5,'MarkerFaceColor',[0.4, 0.6+n1*0.03, 0.6],'MarkerSize',3);
    hold on
end

line([0 7],[20 20]);
line([0 7],[40 40]);
set(gca,'XTick',1:6);
set(gca,'Xticklabel',[250 500 1000 2000 4000 8000]);
title('Train');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');
%control group
subplot(1,2,2);
    % plot the mean of hearing level
    plot(x,mean_C_insert,'o-','color',[0.6, 0.00, 0.2],'LineWidth',1.5,'MarkerFaceColor',[0.6, 0.00, 0.2],'MarkerSize',3);
    hold on
    % plot the individual hearing level

[rows,cols]=size(C);
subNumC=rows;
for n2=1:subNumC
    plot(x,C_insert(n2,:),'o-','color',color_list{1},'LineWidth',0.5,'MarkerFaceColor',color_list{1},'MarkerSize',3);
    hold on
end
line([0,7],[20 20]);
line([0 7],[40 40]);
set(gca,'XTick',1:6);
set(gca,'Xticklabel',[250 500 1000 2000 4000 8000]);
xlabel('Frequency in Hertz');
ylabel('Hearing Level in dB');
title('Control');
 set(get(gca,'xlabeL'),'FontSize', 12, 'FontWeight', 'bold','FontName','Microsoft YaHei');
set(get(gca,'ylabel'),'FontSize', 17, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');
%% air-bone gap

T_gap=(T(:,1:6)-T(:,13:18))+(T(:,7:12)-T(:,19:24));
T_gap=T_gap./2;
C_gap=(C(:,1:6)-C(:,13:18))+(C(:,7:12)-C(:,19:24));
C_gap=C_gap./2;

x=[ 1 2 3 4 5 6 ];
color_list={[0.3 0.3 0.3 ],[0.0 0.8 0.6],[0.0 0.4 0.6],[0.4 0.6 0.6]};
%train group
h2=figure;
subplot(2,1,1);
for n1=1:11
    plot(x,T_gap(n1,:),'o-','color',[0.4, 0.6+n1*0.03, 0.6],'LineWidth',0.5,'MarkerFaceColor',[0.4, 0.6+n1*0.03, 0.6],'MarkerSize',3);
    hold on
end
line([0 7],[15 15]);

set(gca,'XTick',1:6);
set(gca,'Xticklabel',[250 500 1000 2000 4000 8000]);
title('Train');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');
%control group
subplot(2,1,2);
for n2=1:11
    plot(x,C_gap(n2,:),'o-','color',color_list{1},'LineWidth',0.5,'MarkerFaceColor',color_list{1},'MarkerSize',3);
    hold on
end
line([0,7],[15 15]);

set(gca,'XTick',1:6);
set(gca,'Xticklabel',[250 500 1000 2000 4000 8000]);
xlabel('Frequency in Hertz');
ylabel('Air-Bone Gap in dB');
title('Control');
 set(get(gca,'xlabeL'),'FontSize', 12, 'FontWeight', 'bold','FontName','Microsoft YaHei');
set(get(gca,'ylabel'),'FontSize', 17, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');