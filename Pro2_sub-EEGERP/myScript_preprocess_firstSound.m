% TRY to change for adapting our data 

% MY Script
% for practice
% Huang Ting
% Updated 2017/09/12
% analyse first sound
%
% Note:  1, pre-process
%            2, 手动操作：差值坏导剔除坏段
%            3, run ICA
%            4, 手动操作：剔除相应成分
%            5, average(ERPLAB)
% Reference :
% http://erpinfo.org/erplab/erplab-documentation/documentation-archive-for-previous-versions/v3.x-documentation/scripting/Example4.html
% 
% Appendix:
%
% 手动剔除坏导，剔除坏段，%sub-001_Chan_elist_lpfilt_hpfilt_ref_bins_epochs_reject.set
% 脚本再进行ICA分析     %sub-001_Chan_elist_lpfilt_hpfilt_ref_bins_epochs_reject_ica.set
% 手动根据ICA结果剔除成分   %sub-001_Chan_elist_lpfilt_hpfilt_ref_bins_epochs_reject_icarej.set

% Starting with a clean state  
clear all
clc

% Relaunching EEGlab GUI
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% Initialize the ALLERP structure and CURRENTERP
ALLERP = buildERPstruct([]);
CURRENTERP = 0;

% Parameters (This defines the set of subjects)
% % TAIL tone exp2
% subject_list = {'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007','sub-008',...
%                         'sub-009','sub-010','sub-011','sub-012','sub-013','sub-014','sub-015','sub-016',...
%                          'sub-017','sub-018','sub-019','sub-020'};

% % exp5 tail word
% subject_list = {'test004','test005','test006','test007','test008','test009','test010','test011','test012','test013','test014','test015','test016new',...
%                            'test017','test018','test019','test020','test021','test022','test023'};


 % exp3 tial vowel
subject_list = {'project3-1','project3-2','project3-3','project3-4','project3-5','project3-5-TRUE','project3-6',...
                         'project3-7','project3-8','project3-9','project3-10','project3-11','project3-12',...
                         'project3-13','project3-14','project3-15','project3-16','project3-17',...
                         'project3-18','project3-19','project3-20'}

% Path to the parent folder, which contains the data folders for all

% %Exp_TAIL_word
%  parentfolder = 'D:/Work_D/EXP5-TAIL-word/data_deletebadchannel/'; %www： use '/' not ' \' (misunderstand)

% % Exp_TAIL_tone
% parentfolder = 'D:/Work_D/EXP2-TAIL-tone/data_deletebadchannel/';

% exp3_tail_vowel
parentfolder = 'D:/Work_D/EXP3-TAIL-vowel/data_deletebadchannel/';



cd(parentfolder);
numsubjects  = length(subject_list); % number of subjects

% Set the save_everything variable to 1 to save all of the intermediate files to the hard drive
% Set to 0 to save only the initial and final dataset and ERPset for each subject
save_everything  = 0;

% Set the plot_PDFs variable to 1 to create PDF files with the waveforms
% for each subject (set to 0 if you don't want to create the PDF files).
plot_PDFs = 0;

% Preprocess  (Loop through all subjects)
for s=2:7%numsubjects
    
        % Path to the folder containing the current subject's data
        subject = subject_list{s};
        subjectfolder = [parentfolder subject '/'];
        
        %fprintf('\n\n\n*** Processing subject %d (%s) ***\n\n\n', s, subject);
        fprintf('\n\n\n*** Processing subject %s ("total :"%d) ***\n\n\n', subject ,numsubjects);
        
        % Check to make sure the dataset file exists
        % Initial filename = path plus Subject# plus _EEG.set
        sname = [subjectfolder subject '.cnt'];
        if exist(sname, 'file')<=0

                fprintf('\n *** WARNING: %s does not exist *** \n', sname);
                fprintf('\n *** Skip all processing for this subject *** \n\n');

        else 
                
        %
        % Load original dataset
        %
        fprintf('\n\n\n**** %s: Loading dataset ****\n\n\n', subject);     
        EEG = pop_loadcnt( sname , 'dataformat', 'auto', 'memmapfile', '');        
        %
        % Add the channel locations
        % We're assuming the file 'standard-10-5-cap385.elp' is somewhere
        % in the path.  This can be copied from
        % 'F:\\Work\\MATLAB-box\\eeglab13_5_4b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp' inside the eeglab folder
        %
        % Changing the path for the electrode locations file :
        %         The last little thing you need to fix is the location of the file used to add the electrode locations, standard-10-5-cap385.elp. 
        %          In our script so far, we've used the full path to the file, which we've gotten from the EEGLAB history. 
        %          This file is probably located in the EEGLAB folder, and if you upgrade to a new version of EEGLAB, this folder will have a different name, and the script will stop working properly.  
        %          To avoid this, we can just rid of the path information that precedes the standard-10-5-cap385.elp filename.  
        %          As long as the folder that contains this file is in your Matlab path, EEGLAB will be able to find the file.  To make this change, just edit the line with the pop_chanedit() command so that it looks like this:   
        %EEG=pop_chanedit(EEG, 'lookup','F:\\Work\\MATLAB-box\\eeglab13_5_4b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp');
        fprintf('\n\n\n**** %s: Adding channel location info ****\n\n\n', subject);
        EEG=pop_chanedit(EEG, 'lookup','standard-10-5-cap385.elp');
        % Save dataset with _Chan suffix instead of _EEG
        EEG.setname = [subject '_Chan']; % name for the dataset menu
        
        if (save_everything)
            EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', subjectfolder);
        end

        %
        % Create EVENTLIST and save (pop_editeventlist adds _elist suffix)
        %     
        fprintf('\n\n\n**** %s: Creating eventlist ****\n\n\n', subject);
        EEG  = pop_creabasiceventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' } ,'Warning', 'off'); %'Warning', 'on'% GUI: 04-Aug-2016 16:33:51
        % EEG = pop_creabasiceventlist(EEG, '', {'boundary'}, {-99}, 1);%eg:3c
        EEG.setname = [EEG.setname '_elist']; % name for the dataset menu
 
        if (save_everything)
            EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', subjectfolder);
        end
        
        %
        % Filtering ERP. 
        %
        % Lowpass cutoff at 30 Hz;
        % 
        fprintf('\n\n\n**** %s: Low-pass filtering ERP at30 Hz ****\n\n\n', subject);                          
        EEG  = pop_basicfilter( EEG,  1:62 , 'Cutoff', 30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  2, 'RemoveDC', 'on' );
        EEG.setname = [EEG.setname '_lpfilt'];
        if (save_everything)
            EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', subjectfolder);              
        end
        
        % 
        % High-pass filter the EEG
        % Channels = 1 to 66; High-pass cutoff at 0.1 Hz;
        % No lowpass filter; Order of the filter = 2.
        % Type of filter = "Butterworth"; Remove DC offset; Filter
        % "between" boundary events
        %
        fprintf('\n\n\n**** %s: High-pass filtering EEG at 0.1 Hz ****\n\n\n', subject);              
        EEG  = pop_basicfilter( EEG,  1:62 , 'Cutoff', 0.1, 'Design', 'butter', 'Filter', 'highpass', 'Order',  2, 'RemoveDC', 'on' );
        EEG.setname = [EEG.setname '_hpfilt'];
        if (save_everything)
            EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', subjectfolder);              
        end
        
        %
        % Use Channel operations to insert a bipolar EOG channel
        % and re-reference to the average of the earlobes
        % Equations are stored in 'chanops_reref_biveog.txt', which
        % must be in the home directory for the experiment.
        % Save output with _ref suffix.
        %
        % NOTE: 参考电极（http://52brain.com/thread-14051-1-1.html）
        %
        %   function in eeglab 
        %EEG = pop_reref( EEG, []); 
        %   function in erplab
        %EEG = pop_eegchanoperator(EEG, [parentfolder 'chanops_reref_biveog.txt']);
        EEG = pop_eegchanoperator(EEG, [parentfolder 'chanops_reref_biveog_avg.txt']); % 全脑平均
        EEG.setname = [EEG.setname '_ref'];
        if (save_everything)
            EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', subjectfolder);
        end       
        
        
        %
        % Use Binlister to sort the bins and save with _bins suffix
        % We are assuming that 'binlister_demo_1.txt' is present in the
        % home folder.
        %       
        % Putting the bin descriptor file in the parent folder :
        %      The next thing you need to fix is the location of the bin descriptor file, 'binlister_demo_1.txt'.  In our script so far, we've assumed that this file is in the S1 folder.  
        %      You will use the same bin descriptor file for every subject, so it doesn't make sense to have a separate copy in every subject's folder. 
        %      Instead, you should put it in the parent folder (the folder that contains the S1 folder and the folders for all the other subjects). 
        %      After you've done this, you will need to make some changes to your script so that it looks in the right place for this file.
        % EEG  = pop_binlister( EEG , 'BDF', 'C:\Users\lenovo\Desktop\eegPractice\Test_Data\binlister_demo_1.txt', 'IndexEL',  1, 'SendEL2', 'EEG', 'Voutput', 'EEG' ); % GUI: 04-Aug-2016 16:37:14
        
        fprintf('\n\n\n**** %s: Running BinLister ****\n\n\n', subject);  
        EEG  = pop_binlister( EEG , 'BDF', [parentfolder 'binlister_demo_2first.txt'], 'IndexEL',  1, 'SendEL2', 'EEG', 'Voutput', 'EEG' ); %ddd与教程不同% GUI: 04-Aug-2016 16:37:14
        EEG.setname = [EEG.setname '_bins'];
        if (save_everything)
            EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', subjectfolder);
        end

        %
        % Extracts bin-based epochs (200 ms pre-stim, 800 ms post-stim. 
        % Baseline correction by pre-stim window)
        % Then save with _epochs suffix
        % 
        fprintf('\n\n\n**** %s: Bin-based epoching ****\n\n\n', subject);
        
        %
        % Add the channel locations again？
        fprintf('\n\n\n**** %s: Adding channel location info again****\n\n\n', subject);
        EEG=pop_chanedit(EEG, 'lookup','standard-10-5-cap385.elp');
        
        
        %EEG = pop_epochbin( EEG , [-200.0  800.0],  'pre'); % GUI: 04-Aug-2016 16:39:47
        EEG = pop_epochbin( EEG , [-200.0  1000.0],  'pre');
        EEG.setname = ['refM_firstS_' EEG.setname '_epochs'];
        if (1)
            EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', subjectfolder);
        end   
       
        
        %
        % 以上处理保存后，手动剔除坏导，剔除坏段，%sub-001_Chan_elist_lpfilt_hpfilt_ref_bins_epochs_reject.set
        % 再进行ICA分析     %sub-001_Chan_elist_lpfilt_hpfilt_ref_bins_epochs_reject_ica.set
        % 根据ICA结果剔除成分   %sub-001_Chan_elist_lpfilt_hpfilt_ref_bins_epochs_reject_icarej.set
        %

        % save in EEGlab structure ,but these data don't average within one subject
        %
        [ALLEEG EEG CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

 
        if (plot_PDFs)
            pop_ploterps(ERP, [1 2], 1:62, 'Style', 'Matlab');
            %pop_fig2pdf([subjectfolder subject '.pdf']);
        end
 
    end % end of the "if/else" statement that makes sure the file exists        

end  % end of looping through all subjects

fprintf('\n\n\n**** FINISHED ****\n\n\n');
