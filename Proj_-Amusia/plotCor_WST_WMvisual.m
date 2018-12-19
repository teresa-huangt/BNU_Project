% %% plot cor bet W-IES WITH WM control FD
% 
% load data2B.mat;
% w = data2.summaryIES(:,2);
% wmV=data2.WM.sum(:,2);
% plot_corr_group3(w,wmV,'o', 'TAIL-word-IES','WorkingMemory-visual')
% 
% %%  DL WM 
% figure;
% 
% load data2D.mat;
% w = data2.speechEar_rovGap.constancy_mean.earIES(:,2);
% load data2B.mat;
% wmV=data2.WM.sum(:,2);
% plot_corr_group3(w,wmV,'o', 'TAIL-location-DL-IES','WorkingMemory-visual')

%% word task: SSDT and WM-visual
figure;

%
load data2D.mat;
structureDir_ST = data2.speechID_rovGap.ST_mean.LISAS(:,2);
group_tone1 = structureDir_ST(1:8,1);
group_pure2 =structureDir_ST(9:22,1);
group_control3 = structureDir_ST(23:43,1);
load data2B.mat;
wmV=data2.WM.sum(:,2);
group_tone11 = wmV(1:8,1);
group_pure22 =wmV(9:22,1);
group_control33 = wmV(23:43,1);

%
subplot(1,3,1);
plot_corr_group3(group_tone1,group_tone11,'g1', 'Word-SSDT','WorkingMemory-visual','Correlation ',14); hold on;
plot_corr_group3(group_pure2,group_pure22, 'g2','Word-SSDT','WorkingMemory-visual','Correlation ',14); hold on;
plot_corr_group3(group_control3,group_control33,'g3', 'Word-SSDT','WorkingMemory-visual','Correlation',14);
legend('Tone agnosics','Pure amusics','Controls','Location','northeast');
 set(get(gca,'xlabeL'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 10, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');
plot_regressionline(structureDir_ST,wmV);


%
subplot(1,3,2);
plot_corr_group3(group_tone1,group_tone11,'g1', 'Word-SSDT','WorkingMemory-visual','Correlation ',14); hold on;
plot_corr_group3(group_pure2,group_pure22, 'g2','Word-SSDT','WorkingMemory-visual','Correlation ',14); 
legend('Tone agnosics','Pure amusics','Location','northeast');
 set(get(gca,'xlabeL'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 10, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');
plot_regressionline(structureDir_ST(1:22,:),wmV(1:22,:));
%
subplot(1,3,3);
plot_corr_group3(group_control3,group_control33,'g3', 'Word-SSDT','WorkingMemory-visual','Correlation',14);
legend('Controls','Location','northeast');
 set(get(gca,'xlabeL'),'FontSize', 13, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'ylabel'),'FontSize', 10, 'FontWeight', 'normal','FontName','Verdana');
set(get(gca,'title'),'FontSize', 15, 'FontWeight', 'normal','FontName','Microsoft YaHei');
plot_regressionline(structureDir_ST(23:43,:),wmV(23:43,:));
