%cal_frequency
% https://bishoptechbits.blogspot.tw/2010/07/simplified-introduction-to-time.html
% 四条件
% eg: D:\Work_D\EXP5-TAIL-word\data_deletebadchannel\test004\refMtest004_ERPs_allTr.erp
function cal_frequency_allTask_B_noLpass(exp)

switch exp
    % Exp2-tone
    case 'tone'
        
        subject_list = {'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007','sub-008',...
            'sub-009','sub-010','sub-011','sub-012','sub-013','sub-014','sub-015','sub-016',...
            'sub-017','sub-018','sub-019','sub-020'};
        parentfolder = 'D:/Work_D/EXP2-TAIL-tone/data_deletebadchannel/'
        cd(parentfolder);
        
        % % Exp5-word
    case 'word'
        subject_list = {'test004','test005','test006','test007','test008','test009','test010','test011','test012','test013','test014','test015','test016new',...
            'test017','test018','test019','test020','test021','test022','test023'};
        parentfolder = 'D:/Work_D/EXP5-TAIL-word/data_deletebadchannel/'
        cd(parentfolder);
        
        % Exp3-vowel (差值AF34后再做：解决-统计分析用不到这两点，地形图改正即可)
    case 'vowel'
        subject_list = {'project3-1','project3-2','project3-3','project3-4','project3-5','project3-6',...
            'project3-7','project3-8','project3-9','project3-10','project3-11','project3-12',...
            'project3-13','project3-14','project3-15','project3-16','project3-17',...
            'project3-18','project3-19','project3-20'}
        parentfolder = 'D:/Work_D/EXP3-TAIL-vowel/data_deletebadchannel/'
        cd(parentfolder);
end

% number of subjects
subjectNumber  =length(subject_list);

% open eeglab first
%eeglab;


% Input frequncncy analysis parameters
% Cycles
% cycles set at zero, just repeats the FFT analysis;
% different values specified for the number of cycles in each Morlet wavelet
% As the number of cycles increases, note that the analysis of lower frequencies drops out.
% If you try the analysis with cycles set to 10, you will see that the analysis only covers the frequency range from 40 to 50 Hz,
% and so misses the 20 Hz increase completely.
cycles = 0;

% Pad ratio
% adding is literally that – it involves adding zeros to your signal to make it longer, which improves frequency resolution.
pr= 16;

% Extract signal


for  s = 1%:subjectNumber;

    % load data Second sound
    subject = subject_list{s};
    subjectfolder = [parentfolder subject '/'];
    appendix =  '_ERPs_allTr';  
    %sname = [subjectfolder subject  appendix '.erp'];
    sname = [subjectfolder 'refM_noLpass' subject  appendix '.erp'];
    sub_sname = ['refM_noLpass' subject  appendix '.erp'];
     ERP = pop_loaderp( 'filename', sub_sname, 'filepath', subjectfolder );
    
    % Extract base information
    frames = ERP.pnts; % Number of timepoints per trial
    timemin = ERP.xmin; % in seconds
    timemax = ERP.xmax; % in seconds
    duration = [timemin timemax+0.001]; % in seconds
    durationMillisecond =duration*1000; % in milliseconds
    srate = ERP.srate; %Sampling rate (Hz)


    
    for i = 1:4
        mysignal = ERP.bintri(i);
        mysignal = squeeze(mysignal.alltrial);
   %'maxfreq' (default=50)
    [ersp,itc,powbase,times,freqs,erspboot,itcboot]=...
        newtimef(mysignal,frames,durationMillisecond,srate, cycles,'plotersp','on','plotitc','on','padratio',pr);
    
    % frequency index
    theta_index=find(freqs>=4&freqs<=8);
    alpha_index=find(freqs>8&freqs<=12);
    beta_index=find(freqs>12&freqs<=30);
    gamma_index=find(freqs>30&freqs<=49);
    
    % fre
    theta_fre = freqs(theta_index);
    alpha_fre = freqs(alpha_index);
    beta_fre = freqs(beta_index);
    gamma_fre = freqs(gamma_index);
    
    % itc
    theta_itc = itc(theta_index',:);
    alpha_itc = itc(alpha_index',:);
    beta_itc = itc(beta_index',:);
    gamma_itc = itc(gamma_index',:);
    
    % ersp
    theta_ersp = ersp(theta_index',:);
    alpha_ersp = ersp(alpha_index',:);
    beta_ersp = ersp(beta_index',:);
    gamma_ersp = ersp(gamma_index',:);
    
    % save
    ALLFRE(i).theta_ersp(:,:,s) = theta_ersp;
    ALLFRE(i).alpha_ersp(:,:,s) = alpha_ersp;
    ALLFRE(i).beta_ersp(:,:,s) = beta_ersp;
    ALLFRE(i).gamma_ersp(:,:,s) = gamma_ersp;
    
    ALLFRE(i).theta_itc(:,:,s) = theta_itc;
    ALLFRE(i).alpha_itc(:,:,s) = alpha_itc;
    ALLFRE(i).beta_itc(:,:,s) = beta_itc;
    ALLFRE(i).gamma_itc(:,:,s) = gamma_itc;
    
    ALLFRE(i).theta_fre(:,:,s) = theta_fre;
    ALLFRE(i).alpha_fre(:,:,s) = alpha_fre;
    ALLFRE(i).beta_fre(:,:,s) = beta_fre;
    ALLFRE(i).gamma_fre(:,:,s) = gamma_fre;
    
    ALLFRE(i).time = times;
%     ALLFRE(i).freqs= freqs;
    
    end
    %save abc
end


% save ALLFRE4condition_noLpass ALLFRE
end