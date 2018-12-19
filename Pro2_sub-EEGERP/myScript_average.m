% AVERAGE
% UPDATE: HUANGT 2017/09/05

% Starting with a clean state  
clear all
clc

% Relaunching EEGlab GUI
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% Initialize the ALLERP structure and CURRENTERP
ALLERP = buildERPstruct([]);
CURRENTERP = 0;

% Parameters (This defines the set of subjects)

% % exp2 tone
% subject_list = {'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007','sub-008',...
%     'sub-009','sub-010','sub-011','sub-012','sub-013','sub-014','sub-015','sub-016',...
%     'sub-017','sub-018','sub-019','sub-020'};

% exp5 tail word
subject_list = {'test004','test005','test006','test007','test008','test009','test010','test011','test012','test013','test014','test015','test016new',...
                           'test017','test018','test019','test020','test021','test022','test023'};

% %  exp3 tial vowel
% subject_list = {'project3-1','project3-2','project3-3','project3-4','project3-5','project3-6',...
%                          'project3-7','project3-8','project3-9','project3-10','project3-11','project3-12',...
%                          'project3-13','project3-14','project3-15','project3-16','project3-17',...
%                          'project3-18','project3-19','project3-20'}

                       
% number of subjects
numsubjects  =length(subject_list);

for s=1:numsubjects
    
%     % Exp_TAIL_tone
%     parentfolder = 'D:/Work_D/EXP2-TAIL-tone/data_deletebadchannel/';

    %Exp_TAIL_word
    parentfolder = 'D:/Work_D/EXP5-TAIL-word/data_deletebadchannel/'; %www： use '/' not ' \' (misunderstand)

%     % exp3_tail_vowel
%     parentfolder = 'D:/Work_D/EXP3-TAIL-vowel/data_deletebadchannel/';

    cd(parentfolder);
    
    % Path to the folder containing the current subject's data
    subject = subject_list{s};
    subjectfolder = [parentfolder subject '/'];
    
    %fprintf('\n\n\n*** Processing subject %d (%s) ***\n\n\n', s, subject);
    fprintf('\n\n\n*** Processing subject %s ("total :"%d) ***\n\n\n', subject ,numsubjects);
    
    % Check to make sure the dataset file exists
    % Initial filename = path plus Subject# plus _EEG.set
    appendix =  '_Chan_elist_lpfilt_hpfilt_ref_bins_epochs_reject_icarej';   
    
%     appendix =  '_Chan_elist_lpfilt_hpfilt_ref_bins_epochs_reject';   %???20171103
%     appendix =  '_Chan_elist_lpfilt_hpfilt_ref_bins_epochs'; 
    
      % 1
     sname = [subjectfolder 'refM_firstS_'  subject  appendix '.set'];
     sub_sname = ['refM_firstS_'  subject  appendix '.set'];
     
%      % 2
%      sname = [subjectfolder subject  appendix '.set'];
%      sub_sname = [subject  appendix '.set'];

%      %2- ref mean
%       sname = [subjectfolder 'refM' subject  appendix '.set'];
%      sub_sname = ['refM' subject  appendix '.set'];
 
    if exist(sname, 'file')<=0
        
        fprintf('\n *** WARNING: %s does not exist *** \n', sname);
        fprintf('\n *** Skip all processing for this subject *** \n\n');
        
    else
        
        %
        % Load original dataset
        %
        EEG= pop_loadset('filename',sub_sname,'filepath',subjectfolder);
        
        
        %
        % Averaging. Only good trials.  Include standard deviation.  Save to disk.
        %
        % 重新load手动处理后的数据
        fprintf('\n\n\n**** %s: Averaging ****\n\n\n', subject);
        ERP = pop_averager( EEG, 'Criterion', 'good', 'SEM', 'on'); %叠加所有trial
        
        %1
        ERP.erpname = ['refM_firstS_' subject '_ERPs'];  % name for erpset menu
        
%         %2
% %         ERP.erpname = [subject '_ERPs2'];  % name for erpset menu
%         ERP.erpname = ['refM' subject '_ERPs'];   
        

        pop_savemyerp(ERP, 'erpname', ERP.erpname, 'filename', [ERP.erpname '.erp'], 'filepath', subjectfolder, 'warning', 'off');
        
        
        %
        % Bin Operations. Create a difference wave and save with _diff suffix
        % Do this on the unfiltered data, so first reload unfiltered file？？
        %
        % Then do a second round of bin operations and save with _plus suffix
        %
        fprintf('\n\n\n**** %s: Bin Operations (two passes) ****\n\n\n', subject);
        
        %1
        fname = ['refM_firstS_' subject '_ERPs.erp']; 

%         %2
% %         fname = [subject '_ERPs2.erp'];  % Re-create filename for unfiltered ERP
%         fname = ['refM' subject '_ERPs.erp'];        
        

        ERP = pop_loaderp( 'filename', fname, 'filepath', subjectfolder );   % Load the file  % 注释掉一个for循环（itc 改变的数据结构）
        % Now make the difference wave, directly specifying the
        % equation that modifies the existing ERPset
        %         ERP = pop_binoperator( ERP, {'b5= b2+b1 label Same Syllable wave' });
        %         %ERP.erpname = [ERP.erpname '_diff'];  % name for erpset menu %?上一个name有'_30Hz'后缀，这次用的是lowpass30之前的数据
        %          ERP.erpname = [ERP.erpname '_sameSyllable'];
        %         if (save_everything)
        %             pop_savemyerp(ERP, 'erpname', ERP.erpname, 'filename', [ERP.erpname '.erp'], 'filepath', subjectfolder, 'warning', 'on');
        %         end
        
        %
        % Now we will do bin operations using a set of equations
        % stored in the file 'bin_equations.txt', which must be in
        % the home folder for the experiment
        %
        % NOTE: 提前写好，或像上面部分写法
        
        %1
        ERP = pop_binoperator( ERP, [parentfolder 'bin_equations_first.txt']);

%         %2
%         ERP = pop_binoperator( ERP, [parentfolder 'bin_equations.txt']);
        
        

        ERP.erpname = [ERP.erpname '_plus'];  % name for erpset menu
        pop_savemyerp(ERP, 'erpname', ERP.erpname, 'filename', [ERP.erpname '.erp'], 'filepath', subjectfolder, 'warning', 'off');
        
        % Save this final ERP in the ALLERP structure.  This is not
        % necessary unless you want to see the ERPs in the GUI or if you
        % want to access them with another function (e.g., pop_gaverager)
        CURRENTERP = CURRENTERP + 1;
        ALLERP(CURRENTERP) = ERP; %

    end
    
end

%% GRAND AVERAGE
%
% Make a grand average. The final ERP from each subject was saved in
% ALLERP, and we have nsubj subjects, so the indices of the ERPs to be averaged
% together are 1:nsubj
% We'll also create a filtered version and save it
%
ERP = pop_gaverager( ALLERP , 'Criterion', 100, 'ERPindex', [1:numsubjects] ); %'Criterion', 100 is left over from a previous version
ERP.erpname = 'grand_avg_exp5word_firstS_refM';  % name for erpset menu
ERP = pop_savemyerp(ERP, 'filename', [ERP.erpname '.erp'], 'filepath', parentfolder, 'warning', 'off');
CURRENTERP = CURRENTERP + 1; % next to the last subject's  line
ALLERP(CURRENTERP) = ERP;

ERP = pop_filterp( ERP,1:62 , 'Cutoff',30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',2 );% initial value 30；test 20 for less curl
ERP.erpname = [ERP.erpname '_30Hz'];  % name for erpset menu
ERP = pop_savemyerp(ERP, 'filename', [ERP.erpname '.erp'], 'filepath', parentfolder, 'warning', 'off');
CURRENTERP = CURRENTERP + 1; 
ALLERP(CURRENTERP) = ERP; 
 
fprintf('\n\n\n**** FINISHED ****\n\n\n');