function OV = cal_CVmedian(cond, lowCut, highCut)
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
OV.RT= nan(subN,4); % SCSV SCDV, DCSV, DCDV
OV.ER= nan(subN,4); % SCSV SCDV, DCSV, DCDV
OV.N= nan(subN,4); % SCSV SCDV, DCSV, DCDV
OV.header = {'SCSV', 'SCDV', 'DCSV', 'DCDV'};
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
        else
            RT = F.responseLatency;
            isC = F.isCorrect;
%             Tr = F.Trelation;
            Cr = F.Crelation;
            Vr = F.Vrelation;
            Pr = F.Prelation;
        end
        %% rid of cutoffs and errors
        RT(isC==0) = NaN;
        RT(RT<lowCut) = NaN;
%         RT(RT>cutoff) = NaN;
        RT(RT>nanmean(RT)+highCut*nanstd(RT)) = NaN;
        %             trialN = length(RT);
        %% calculate RT variables
        OV.RT(i, 1:4) = [nanmedian(RT(Cr == 1 & Vr == 1)),nanmedian(RT(Cr == 1 & Vr == 2)), ...
            nanmedian(RT( Cr == 2&Vr == 1)),nanmedian(RT(Vr == 2 & Cr == 2))];
        % count valid trials for each condition (excluding both errors and
        % cutoffs, which may overlap, so count actual trials used
        OV.N(i, 1:4) = [numel(find(isnan(RT(Cr == 1 & Vr == 1))==0)),numel(find(isnan(RT(Cr == 1 & Vr == 2))==0)), ...
            numel(find(isnan(RT(Cr == 2 &Vr == 1 ))==0)), ...
            numel(find(isnan(RT(Cr == 2 & Vr == 2))==0))];
        % calculate error rate
        OV.ER(i, 1:4) = [numel(find(isC==0 & Cr == 1 & Vr == 1))/numel(find(Cr == 1 & Vr == 1)),numel(find(isC==0 & Cr == 1 & Vr == 2))/numel(find(Cr == 1 & Vr == 2)), ...
            numel(find(isC==0 & Cr == 2 & Vr == 1))/numel(find(Cr == 2 & Vr == 1)), ...
            numel(find(isC==0 & Cr == 2 & Vr == 2))/numel(find(Cr == 2 & Vr == 2))];

    end
end
