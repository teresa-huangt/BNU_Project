function dataSave(subID,booth, results, colHeaders, condition)
% function dataSave(subID,booth, results, colHeaders, condition)
% 12/7/2010, YXZ: modified to speed up data saving; save individually for
% each participant insead of for all participants as 'proj17_X_XXX.mat'
% 23/7/2010: YXZ: save structure as the uniform name of 'OP'; 
%%
%    subID='17-0-Temp';condition='FDfixed1000Hz'; %for testing
varName = ['proj' subID]; 
path='../data/';

data=[path varName '.mat'];

%%
fileN = 0; % assume 0 files unless otherwise
if exist(data, 'file')
    load(data);
    if exist('OP', 'var')
        if isfield(OP, condition)
            fileN = length(fieldnames(OP.(condition))); % number of files already written for that condition
        end
    end
end

%% compose current file name

fileN = fileN + 1;
koo = num2str(fileN);
if fileN < 10
    filerow = ['_00' koo];
elseif 9<fileN<100
    filerow = ['_0' koo];
else
    filerow = ['_' koo];
end
F=['F' filerow];
fileName = [path subID condition filerow '.txt'];
% boothNames = {'small', 'adult', 'paediatric', 'yuxuan(testing)'};
% boothName = boothNames{booth};

%% check if the file name already exists; never overwrite a file

if exist(fileName, 'file')
    fileName=[path subID condition filerow '.tem']; % for convenience, assign a temporary file name
    msgbox('check: the file name exists!', 'Warning', 'warn');
    F = [F '_tem']; %also not overwrite .mat 
end

%%
% open the file to write
fID=fopen(fileName,'w');
%write the header
fprintf(fID, '%s\n', ['SID = ' subID]);
fprintf(fID,'%s', ['Booth= ' booth]);
fprintf(fID, '\n%s', ['file name = ' fileName]);
T = fix(clock);
timeString = datestr(T);
fprintf(fID, '\n%s\n', ['This file is written at ' timeString]);
fprintf(fID, '%6.0f', T);
fprintf(fID, '\n%s\n\n', ['This file is generated by Matlab program (condition): ' condition]);

% colHeaders =  { 'trialN', 'baseFreq', 'signalFreq', 'deltaF', 'trackN', ...
%     'signalInterval', 'responseInterval',  'isCorrect', 'responseLatency'};%scoring info
for i=1:length(colHeaders)
    fprintf(fID, '%s\t', colHeaders{i});
end
%%
% trialN = results{1};
% for j=1:length(trialN) %a new row for each trial
%     fprintf(fID,'\n%4.0f\t', j);  %get a new line for each row and write trial number
%     for i=2:size(results,2) %for variable 2 to end
%         Woo=results{i}(j); %pull the variable out 
%         fprintf(fID,'%8.4f\t', Woo);
%     end
% end
%%
fclose(fID);
 fprintf('%s\n', ['Data saved in' fileName]); 
%% write data to matlab variable for each sub (e.g. proj17_1_001.mat)

X=cell2struct(results,colHeaders,2);
X.condition=condition;
X.date = T;
X.booth = booth;
% X.numeric = results;
OP.(condition).(F)=X;
save(data,'OP');

end
