% Copy  *.cnt  from source folder to target folder (one *.cnt file in one new folder named same as the cnt file name)  :
% Step:
% 1. Comfirm the number of file in soure folder and record their file name;
% 2. Creat new folder in target path,the number of these folders = the number of files in source path, and folder name = file name
% 3. Copy
% Aim:
% apply to script for analysing ERP
%
% Update 09/23/2016 huangt
%

% clear
clear;clc;
% set path
sourcePath = 'D:/Work_D/EXP3-TAIL-vowel/data_deletebadchannel/';
targetPath = 'D:/Work_D/EXP3-TAIL-vowel/data_deletebadchannel/';

% 
dirOutput=dir(fullfile(sourcePath,'*.cnt'));
%fileNames={dirOutput.name}';
%
for i=1:length(dirOutput)
    % get name
    tmpFileName = dirOutput(i).name; %ע��(i)��λ��
    tmpFolderName = strrep(tmpFileName,'.cnt','');
    % creat new target folder
    transPathName = sprintf('%s%s',targetPath, tmpFolderName);
     if ~exist(transPathName,'dir');
         mkdir(transPathName);
     else
         rmdir(transPathName);                                                 
         mkdir(transPathName);
     end
    %��ԭ�ļ������ҵ�xxx.bmp�ļ����ڽ���ļ����н���ͬ��.bmp�ļ�,��Ҫ���Ǽ��������\\
    srcPathName = sprintf('%s%s',sourcePath,tmpFileName);
    tarPathName = sprintf('%s/',transPathName);
    % copy
    copyfile(srcPathName,tarPathName);
    
end
