function OV = cal_mean(cond, lowCut, highCut)
% function OV = cal_meanRT(cond, cutoff)
% OV is a subN X 3 matrix: meanRT, error rate, number of valid RT trials
% (excluding incorrect and cutoff RTs)
% highCut is in std unit; 
% lowCut is still in time


%
% set path
path = 'F:/Work/Speech_amusia/allGroup_data/';
% subject ID
subList = {'proj11-2-002','proj11-2-003', 'proj11-2-004' ,'proj11-2-005' ,'proj11-2-006' ,'proj11-2-007','proj11-2-008' ,'proj11-2-019'... %tone-agnosia 8
                  'proj11-2-009', 'proj11-2-010', 'proj11-2-011','proj11-2-012','proj11-2-013', 'proj11-2-014' ,'proj11-2-015' ,'proj11-2-016' ,'proj11-2-017','proj11-2-018' ,...
                  'proj11-2-020', 'proj11-2-021', 'proj11-2-022','proj11-1-018',... % pure-amusia 14
                  'proj11-1-001','proj11-1-002','proj11-1-003', 'proj11-1-004' ,'proj11-1-005' ,'proj11-1-006' ,'proj11-1-007','proj11-1-008' ,...
                  'proj11-1-009', 'proj11-1-010', 'proj11-1-011','proj11-1-012','proj11-1-013', 'proj11-1-014' ,'proj11-1-015' ,'proj11-1-016' ,'proj11-1-017',...
                  'proj11-1-019', 'proj11-1-020', 'proj11-1-021', 'proj11-1-022'} ; % control 21
subN = length(subList);

% cutoff = 2;
OV = nan(subN,9); % meanRT, errorrate, valid RT trials, lowCut number, highCut number,medianRT, highCut ratio, std-rt.std-er
%%
for i = 1:subN
    %%
    %subName = fileList{i};
    subName = [path subList{i} '.mat']; 
    load(subName);
    if isfield(OP,cond)
        F=OP.(cond);
        if size(F,2)>1 % some do 2 blocks
            RT = [F(1).responseLatency;F(2).responseLatency];
            isC = [F(1).isCorrect;F(2).isCorrect;];
        else
            RT = F.responseLatency;
            isC = F.isCorrect;
        end
        
        trialN = length(RT);
        % count cutoffs and errors 
        OV(i,2) = numel( find(isC==0))/trialN;
        RT(isC==0) = NaN;
        OV(i,4) = numel(find(RT<lowCut));
        RT(RT<lowCut) = NaN;
        highRT = nanmean(RT)+highCut*nanstd(RT);
        OV(i,5) = numel(find(RT>highRT));
        RT(RT>highRT) = NaN;
        OV(i,3) = trialN-sum(isnan(RT)); % count num of trials used to calculate mean RT
%         OV(i, 3) = numel(find(RT<cutoff)); %count valid instead of invalid trials
%         OV(i,2) = numel( find(isC==0))/trialN;
%         OV(i,4) = numel(find(RT>cutoff));
        % calculate RT variables
%         RT(RT>cutoff) = NaN;
        OV(i,1) = nanmean(RT);
        OV(i,6) = nanmedian(RT);
        OV(i,7) = OV(i,5) /trialN;
%         OV(i,8) = std(RT);
%         OV(i,9) = ;
        
    end
end

%cd(cfolder);