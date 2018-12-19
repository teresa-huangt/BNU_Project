function OV = cal_LW_meanRT(cond, lowCut, highCut)
% function OV = cal_CVmedian(cond, lowCut, highCut)
% extract only trials with different syllables, analyze if C or V difference matters
% tone status is ignored
% OV is a structure


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
OV.RT= nan(subN,4); % SLSW SLDW, DLSW, DLDW
OV.ER= nan(subN,4); % SLSW SLDW, DLSW, DLDW
OV.N= nan(subN,4); % SLSW SLDW, DLSW, DLDW
OV.header = {'SLSW' , 'SLDW', 'DLSW', 'DLDW'};
for i = 1:subN
    %%
    subName = [path subList{i} '.mat']; 
    load(subName);
    %%
    if isfield(OP,cond)
        F=OP.(cond);
        if size(F,2)>1 % some do 2 blocks
            RT = [F(1).responseLatency;F(2).responseLatency];
            isC = [F(1).isCorrect;F(2).isCorrect;];
%             Tr = [F(1).Trelation;F(2).Trelation];
            Cr = [F(1).Crelation;F(2).Crelation];
            Vr = [F(1).Vrelation;F(2).Vrelation];
            Pr = [F(1).Prelation;F(2).Prelation];
            Lr = [F(1).earRelation;F(2).earRelation];
            cueID = [F(1).cueID;F(2).cueID;];
            targetID = [F(1).targetID;F(2).targetID];
        else
            RT = F.responseLatency;
            isC = F.isCorrect;
%             Tr = F.Trelation;
            Cr = F.Crelation;
            Vr = F.Vrelation;
            Pr = F.Prelation;
            cueID = F.cueID;
            targetID = F.targetID;
            Lr = F.earRelation;
        end
        %% rid of cutoffs and errors
        RT(isC==0) = NaN;
        RT(RT<lowCut) = NaN;
%         RT(RT>cutoff) = NaN;
        RT(RT>nanmean(RT)+highCut*nanstd(RT)) = NaN;
        %             trialN = length(RT);
        %% calculate RT variables
        %
        c1 = find(Lr == 1 & cueID == targetID);
        c2 = find(Lr == 1 & cueID ~= targetID);
        c3 = find(Lr == 2 & cueID == targetID);
        c4 = find(Lr == 2 & cueID ~= targetID);
        %
        OV.RT(i, 1:4) = [nanmean(RT(Lr == 1 & cueID == targetID)),nanmean(RT(Lr == 1 & cueID ~= targetID)), ...
            nanmean(RT( Lr == 2 & cueID == targetID)),nanmean(RT(Lr == 2 & cueID ~= targetID))];
        % count valid trials for each condition (excluding both errors and
        % cutoffs, which may overlap, so count actual trials used
        OV.N(i, 1:4) = [numel(find(isnan(RT(Lr == 1 & cueID == targetID))==0)),numel(find(isnan(RT(Lr == 1 & cueID ~= targetID))==0)), ...
            numel(find(isnan(RT(Lr == 2 & cueID == targetID ))==0)), ...
            numel(find(isnan(RT(Lr == 2 & cueID ~= targetID))==0))];
        % calculate error rate
        OV.ER(i, 1:4) = [numel(find(isC==0 & Lr == 1 & cueID == targetID))/numel(find(Lr == 1 & cueID == targetID)),...
            numel(find(isC==0 & Lr == 1 & cueID ~= targetID))/numel(find(Lr == 1 & cueID ~= targetID)), ...
            numel(find(isC==0 & Lr == 2 & cueID == targetID))/numel(find(Lr == 2 & cueID == targetID)), ...
            numel(find(isC==0 & Lr == 2 & cueID ~= targetID))/numel(find(Lr == 2 & cueID ~= targetID))];

    end
end

