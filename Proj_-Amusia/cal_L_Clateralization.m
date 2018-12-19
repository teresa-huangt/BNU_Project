function OV = cal_L_Clateralization(cond, lowCut, highCut)
% function OV = OV = cal_lateralization(cond, lowCut, highCut)
% OV is a structure
% LOCATION TASK
% CS-targetL/R; CD-targetL/R


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
OV.RT= nan(subN,4);
OV.ER= nan(subN,4);
OV.header = {'CS-targetL','CS-targetR',  'CD-targetL', 'CD-targetR'};
%%
for i = 1:subN
    subName = [path subList{i} '.mat'];
    load(subName);
    if isfield(OP,cond)
        F=OP.(cond);
        if size(F,2)>1 % some do 2 blocks
            RT = [F(1).responseLatency;F(2).responseLatency];
            isC = [F(1).isCorrect;F(2).isCorrect;];
            cueEar = [F(1).cueEar;F(2).cueEar];
            targetEar = [F(1).targetEar;F(2).targetEar];
            Cr = [F(1).Crelation;F(2).Crelation];
        else
            RT = F.responseLatency;
            isC = F.isCorrect;
            cueEar = F.cueEar;
            targetEar = F.targetEar;
             Cr = F.Crelation;
        end
        % rid of cutoffs and errors
        RT(isC==0) = NaN;
        RT(RT<lowCut) = NaN;
        %         RT(RT>cutoff) = NaN;
        RT(RT>nanmean(RT)+highCut*nanstd(RT)) = NaN;
        
        % calculate variables
        OV.RT(i, 1:4) = [nanmean(RT(Cr==1 & targetEar == 1)), ...
            nanmean(RT(Cr==1 & targetEar == 2)), ...
            nanmean(RT(Cr==2 & targetEar == 1)), ...
            nanmean(RT(Cr==2 & targetEar == 2))];
        
        OV.ER(i, 1:4) = [numel(find(isC==0 & Cr==1 & targetEar == 1))/numel(find(Cr==1 & targetEar == 1)),...
            numel(find(isC==0 & Cr==1 & targetEar == 2))/numel(find(Cr==1 & targetEar == 2)),...
            numel(find(isC==0 & Cr==2 & targetEar == 1))/numel(find(Cr==2 & targetEar == 1)),...
            numel(find(isC==0 & Cr==2 & targetEar == 2))/numel(find(Cr==2 & targetEar == 2))];
        
        OV.N(i, 1:4) = [numel(find(isnan(RT(Cr==1 & targetEar == 1))==0)),...
            numel(find(isnan(RT(Cr==1 & targetEar == 2))==0)), ...
            numel(find(isnan(RT(Cr==2 & targetEar == 1))==0)), ...
            numel(find(isnan(RT(Cr==2 & targetEar == 2))==0))];
    end
end

% cd(cfolder);