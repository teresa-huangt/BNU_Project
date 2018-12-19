function  group_control_cor(groupN)
% group 3 serial  tasks + Auditory threshold level
%
% Task1: Speech TAIL (fix_gap  short term) + @补测 roving +长版word
%  real  order  :  {'speechEar_rovGap' , 'speechID_rovGap', 'phoneticDisc_rovGap', 'consDisc_rovGap', 'vowelDisc_rovGap', 'toneDisc_rovGap'};
% 1.1 Tone
% 1.2 Consonant
% 1.3 Vowel
% 1.4 Phoneme /sllyable
% 1.5 Word
% 1.6 Location
% Update: 2017/10/12 using ZXY's script in 'analyses1_ref_ZXY' folder
%
% Task2:  Frequency  discrimination
% 2.1 FD_fixed_1k
% 2.2 FD_roved_1k
%
% Task3: Working memory
% 3.1 Tone N-back
%     - 2-back
%     - 3-back
% 3.2 Vision(shape) N-back
%     - 2-back
%     - 3-back
% 3.3 digitSpan (A+B)
%
%

% NOTE :
%
%

%% Paras
% set path
path = 'F:/Work/Speech_amusia/allGroup_data/';
% FieldList
% change order in accordance with paper(RAM)
fieldList_speechTAIL = {'speechEar_rovGap' , 'speechID_rovGap', 'phoneticDisc_rovGap', 'consDisc_rovGap', 'vowelDisc_rovGap', 'toneDisc_rovGap'};
fieldList_WM = { 'WMf_2_probe', 'WMf_3_probe', 'WMshape_2_probe', 'WMshape_3_probe'};
fieldList_FD = {'FDfixed_1000Hz_probe', 'FDdiscrete_probe'};
fieldList_FD_RT = {'FDfixed_1000Hz_probe', 'FDdiscrete_probe'};
fieldList_digitS = {'digitSpan_new_A','digitSpan_new_B'};
% subject ID
subList = {'proj11-2-002','proj11-2-003', 'proj11-2-004' ,'proj11-2-005' ,'proj11-2-006' ,'proj11-2-007','proj11-2-008' ,'proj11-2-019'... %tone-agnosia
    'proj11-2-009', 'proj11-2-010', 'proj11-2-011','proj11-2-012','proj11-2-013', 'proj11-2-014' ,'proj11-2-015' ,'proj11-2-016' ,'proj11-2-017','proj11-2-018' ,...
    'proj11-2-020', 'proj11-2-021', 'proj11-2-022','proj11-1-018',... % pure-amusia
    'proj11-1-001','proj11-1-002','proj11-1-003', 'proj11-1-004' ,'proj11-1-005' ,'proj11-1-006' ,'proj11-1-007','proj11-1-008' ,...
    'proj11-1-009', 'proj11-1-010', 'proj11-1-011','proj11-1-012','proj11-1-013', 'proj11-1-014' ,'proj11-1-015' ,'proj11-1-016' ,'proj11-1-017',...
    'proj11-1-019', 'proj11-1-020', 'proj11-1-021', 'proj11-1-022'} ; % control
% gather to one .mat
if exist('data2B.mat','file')
    load data2B.mat
end

% Start
switch groupN
    %% Task:Auditory threshold
    case 0% Auditory threshold
        for N=1:length(subList)
            varName = [path subList{N} '.mat'];
            load(varName);
            if isfield(OP, 'toneAudiometry')
                X = OP.toneAudiometry;
                left = X(:,2)';
                right = X(:,3)' ;
                [high,long]=size(X);
                temp1=2*high-1;
                temp2=2*high;
                toneThre(N,1:2:temp1) = left;
                toneThre(N,2:2:temp2) = right;
            end
        end
        data2.Audiometry= toneThre; % row(subject）/ column（L+R in different frequency）
        data2.AudiometryHeader = {'L250', 'R250', 'L500', 'R500','L1000', 'R1000',  'L2000', 'R2000', 'L4000', 'R4000', 'L6000', 'R6000', };
        save data2B data2
        
        
        
        %% Task2:  Frequency  discrimination
    case 2 %FD
        
        fieldList = fieldList_FD;
        
        for M=1:length(fieldList)
            fieldName = fieldList{M};
            thresh1=NaN(length(subList),4);%未补做部分按nan填充
            for N=1:length(subList)
                varName = [path subList{N} '.mat'];
                load(varName);
                if isfield(OP, fieldName)
                    mfileName = fieldnames(OP.(fieldName));
                    blockN = length(mfileName);
                    
                    for j = 1:blockN
                        fileName = mfileName{j};
                        X = OP.(fieldName).(fileName);
                        if isfield(X, 'deltaF')
                            % to confirm log or geomean or others
                            [thresh,numRev] =  cal_thresh(X.deltaF,5,'log');%geomean first log then
                        else
                            thresh= NaN;numRev=NaN;
                        end
                        thresh1(N,j) = thresh;
                        
                    end
                else
                end
                
            end
            meanThresh = nanmean(thresh1,2);
            data2.FD.(fieldName) = meanThresh;
        end
        save data2B   data2
        %% FD-RT
    case 5
        
        fieldList = fieldList_FD_RT;
        
        %cut = NaN(length(subList),4);
        for M=1:length(fieldList)
            fieldName = fieldList{M};
            %time0=NaN(length(subList),4);%未补做部分按nan填充
            for N=1:length(subList)
                varName = [path subList{N} '.mat'];
                load(varName);
                if isfield(OP, fieldName)
                  
                    X = OP.(fieldName);
                    if size(X,2)>2 % some do 3 blocks
                        RT = [X.F_001.responseLatency;X.F_002.responseLatency;X.F_003.responseLatency];
                        isC = [X.F_001.isCorrect;X.F_002.isCorrect;X.F_003.isCorrect];
                    else %2 blocks
                        RT = [X.F_001.responseLatency;X.F_002.responseLatency];
                        isC = [X.F_001.isCorrect;X.F_002.isCorrect];
                    end  
                    trialN = length(RT);
                    % OV (lowCut,highCut, mean-wrongRT,mean-rightRT)
                    lowCut = 0.2; highCut = 3;
                    OV(N,1) = numel(find(RT<lowCut));
                    OV(N,2) = numel(find(RT>nanmean(RT)+highCut*nanstd(RT)));
                    RT(RT<lowCut) = NaN;
                    RT(RT>nanmean(RT)+highCut*nanstd(RT)) = NaN;       
                    wrongRT = RT(isC==0);
                    rightRT = RT(isC==1);
                    OV(N,3) = nanmean(wrongRT);
                    OV(N,4) = nanmedian(rightRT);
                    OV(N,5) =OV(N,1)/trialN ;
                    OV(N,6) = OV(N,2)/trialN ;
                end      
            end   
            data2.FDRT2.(fieldName)= OV;
        end

save data2B   data2

%%  Task3: Working memory
case 3 %WM
    fieldList = fieldList_WM;
    for M=1:length(fieldList)
        fieldName = fieldList{M};
        preprime=NaN(length(subList),3);
        for N=1:length(subList)
            varName = [path subList{N} '.mat'];
            load(varName);
            if isfield(OP, fieldName)
                mfileName = fieldnames(OP.(fieldName));
                blockN = length(mfileName);
                
                for j = 1:blockN
                    fileName = mfileName{j};
                    X = OP.(fieldName).(fileName);
                    [HR,FAR,Pc,dP,dPc,nTrial,nback]=cal_dprime(X);
                    preprime(N,j) = dPc;
                end
            else
            end
        end
        meanpreprime = nanmean(preprime,2);
        data2.WM.(fieldName)= meanpreprime;
    end
    
    save data2B   data2
    
    %% 3.3 digitSpan (A+B)
    case 4 %digitS
        fieldList = fieldList_digitS;
        for M=1:length(fieldList)%差别太大的对相同的一组做两次，总成绩无关AB只求平均
            fieldName = fieldList{M};
            add_mean=NaN(length(subList),2);
            for N=1:length(subList)
                varName = [path subList{N} '.mat'];
                load(varName);
                if isfield(OP, fieldName)
                    mfileName = fieldnames(OP.(fieldName));
                    blockN = length(mfileName);
                    
                    for j = 1:blockN
                        fileName = mfileName{j};
                        X = OP.(fieldName).(fileName).results;
                        AB=X(:,3);
                        add_mean(N,j)=sum(cell2mat(AB));%差别太大的对相同的一组做两次,2个block先求平均，总成绩无关AB只求平均
                    end
                    
                else
                end
                
            end
            digitForward(:,M) = nanmean(add_mean,2);
        end
        meandigitForward=nanmean(digitForward,2);
        data2. digitSpan_revAB= meandigitForward;
        save data2B   data2
        
        otherwise
            msgbox('Group not exist, please recheck your input','warn');
            end
            %% LOOP
            
            end
            
            
            
            
