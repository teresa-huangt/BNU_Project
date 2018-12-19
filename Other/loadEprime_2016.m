
function loadEprime_add()
% 导出数据格式https://www.3tmri.nl/software/88-eprime-to-spm-using-matlab

% Example template script for creating SPM multiple conditions files.
% See: http://www.3tmri.nl/software/88-eprime-to-spm-using-matlab
%
% Note the triple question marks (???). You will have to insert experiment-specific details there...
%
% 2012-04-16 - initial version by Paul F.C. Groot
% 2012-09-21 - changed the way the input data is loaded: now support text-based conditions

outputdir = []; % specify output directory, or leave [] to save to same directory as input

%% import the CSV file that was created by exporting merged eprime edat-files (using E-DataAid)
% The easeast way would be to use the function csvread, but unfortunately that would now work when
% the csv-file contains columns with textual values. So, to be a bit more flexible we use the function
% textscan. The downside of using this function is that we have to specify the datatype of each column explicitly.

% The name of the comma-separated values file
% ??? Make sure this contains the input filename (incl path)
csvfile = 'Untitled.txt';% 'e579.txt'; 

% The number of header lines in the csv-file. This would be 1 if the file was 
% exported including columns names, or zero otherwise.
% ??? set this to the number of header lines that should be skipped
nHeaderLines = 1; 

% ??? define column parsing format: %d stands for a decimal value, %s for text (doc textscan)
csvformat = '%f %f %f %f %f'; 

fid = fopen(csvfile,'rt');
if fid~=-1
    T = textscan(fid, [csvformat '%*[^\n]'], 'Delimiter', ',','TreatAsEmpty',{'NULL','na'}, 'HeaderLines', nHeaderLines );
    % [sub,list,cres,res,RT] = textread('e579.txt','%d%s%d%d%d','delimiter', ',','emptyvalue', NaN);
else
    error('Cannot open %s\n',csvfile);
end
fclose(fid);

%% define the column numbers 
% ??? define a variable for each column index
% Tip: only export the required columns when using E-DataAid (and use E-Merge first to collect all info into one database)
COL_SUBJECT        = 1; % first column is subject number
COL_enACC        = 2; 
COL_enRT    = 3;
COL_reACC     = 4; 
COL_reRT  = 5; 

%% copy vectors to helper variables (for scripts readability)
% ??? each relevant (numerical) column is copied to a separate vector
subjects        = T{COL_SUBJECT};
enACC       = T{COL_enACC};
enRT     = T{COL_enRT};
reACC       = T{COL_reACC};
reRT          = T{COL_reRT};

%% get unique sorted subject, session and condition numbers (i.e. without duplicates)
subjectsU=unique(subjects);
%sessionsU=unique(sessions);

%% get numbers and display them
nSubjects = length(subjectsU);
%nSessions = length(sessionsU);

fprintf('Number of subjects:   %d\n',nSubjects);
%fprintf('Number of sessions:   %d\n',nSessions);


%% loop through subjects

for iSubject=1:nSubjects
    subject=subjectsU(iSubject); % pick the next subject from the list
	F0 = find(subjects(:,1)==subject); %每个被试编号对应的标记值
    enA = enACC(F0,:); 
    enR = enRT(F0,:);
    reA = reACC(F0,:);
    reR = reRT(F0,:);
    %
   
   %cal-meanACC 
     mean_enACCs=nanmean(enA)*100;
     mean_reACCs=nanmean(reA)*100;
      ACC(iSubject,2:3) =[ mean_enACCs,mean_reACCs];
   %cal-meanRT
    
    mean_enRTs = nanmean(enR(enR~=0));
     mean_reRTs = nanmean(reR(reR~=0));
     ResTime(iSubject,2:3) =[mean_enRTs mean_reRTs];
%      format long
%      ResTime
    %第一列保存被试编号
    ACC(iSubject,1) = subject;
    ResTime(iSubject,1) =  subject;
end
 %% save multiple conditions file per subject per session
            Fanjl.ACC = ACC;
            Fanjl.RT = ResTime;
            save Fanjl_2016_en+re  Fanjl
end
% 
% function [ACC] = cal_ACC(isCorrect)
% % sumCorrect =  nansum(isCorrect(:,1));
% % sumTotal = size(sumCorrect,1);
%  ACC =nanmean((isCorrect))*100;
% end