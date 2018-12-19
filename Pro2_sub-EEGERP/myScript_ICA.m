% ICA
% UPDATE: HUANGT 2017/09/05

% Starting with a clean state  
clear all
clc

% Relaunching EEGlab GUI
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% Parameters (This defines the set of subjects)
% 
% % exp2 tail tone
% subject_list = {'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007','sub-008',...
%     'sub-009','sub-010','sub-011','sub-012','sub-013','sub-014','sub-015','sub-016',...
%     'sub-017','sub-018','sub-019','sub-020'};

% exp5 tail word
subject_list = {'test004','test005','test006','test007','test008','test009','test010','test011','test012','test013','test014','test015','test016new',...
                           'test017','test018','test019','test020','test021','test022','test023'};
                
%  % exp3 tial vowel
% subject_list = {'project3-1','project3-2','project3-3','project3-4','project3-5','project3-6',...
%                          'project3-7','project3-8','project3-9','project3-10','project3-11','project3-12',...
%                          'project3-13','project3-14','project3-15','project3-16','project3-17',...
%                          'project3-18','project3-19','project3-20'}


numsubjects  = length(subject_list); % number of subjects

for s=2:length(subject_list)
    
    %Exp_TAIL_word
    parentfolder = 'D:/Work_D/EXP5-TAIL-word/data_deletebadchannel/'; %www： use '/' not ' \' (misunderstand)
%     
%     % Exp_TAIL_tone
%     parentfolder = 'D:/Work_D/EXP2-TAIL-tone/data_deletebadchannel/';

% % exp3_tail_vowel
% parentfolder = 'D:/Work_D/EXP3-TAIL-vowel/data_deletebadchannel/';

    
    cd(parentfolder);
    
    % Path to the folder containing the current subject's data
    subject = subject_list{s};
    subjectfolder = [parentfolder subject '/'];
    
    %fprintf('\n\n\n*** Processing subject %d (%s) ***\n\n\n', s, subject);
    fprintf('\n\n\n*** Processing subject %s ("total :"%d) ***\n\n\n', subject ,numsubjects);
    
    % Check to make sure the dataset file exists
    % Initial filename = path plus Subject# plus _EEG.set
    appendix =  '_Chan_elist_lpfilt_hpfilt_ref_bins_epochs_reject';
    
    % 1
     sname = [subjectfolder 'refM_firstS_'  subject  appendix '.set'];
     sub_sname = ['refM_firstS_'  subject  appendix '.set'];
     
%      % 2
%      sname = [subjectfolder 'refM' subject  appendix '.set'];
%      sub_sname = ['refM'  subject  appendix '.set'];
     
     
    if exist(sname, 'file')<=0
        
        fprintf('\n *** WARNING: %s does not exist *** \n', sname);
        fprintf('\n *** Skip all processing for this subject *** \n\n');
        
    else
        
        %
        % Load original dataset
        %
        %         subject=strcat('test',num2str(i,'%03d'),'_preprocess','.set')
        %         subjectfolder='/Users/apple/Desktop/EEG/dataexp3/';
        % EEG = pop_loadset('filename','sub-001_Chan_elist_lpfilt_hpfilt_ref_bins_epochs_reject.set','filepath','D:\\Work_D\\EXP2-TAIL-tone\\data_deletebadchannel\\sub-001\\');  
        EEG= pop_loadset('filename',sub_sname,'filepath',subjectfolder);
        %EEG = pop_runica(EEG, 'pca',XXX,'interupt','on');% XXX<= 导数-插值坏导数
        %注意： 若进行批处理跑ICA，XXX<=导数-最大插值坏导数
        EEG = pop_runica(EEG, 'pca',35,'interupt','on');
        
        % 1
        subjectPreproICA = ['refM_firstS_' subject  appendix '_ica' ];

%         % 2
%         subjectPreproICA = ['refM' subject  appendix '_ica' ];

        EEG = pop_saveset( EEG, 'filename',subjectPreproICA,'filepath', subjectfolder);
        EEG = eeg_checkset( EEG );
    end
    
end
warndlg('warning string','warning dialog name')