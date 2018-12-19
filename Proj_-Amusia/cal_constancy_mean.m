function OV = cal_constancy_mean(cond, lowCut, highCut)
% function OV = cal_constancy(cond, lowCut, highCut)
% OV is a structure
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
OV.ear = nan(subN,4); %RT then ER
OV.C = nan(subN,4); 
OV.V= nan(subN,4);
OV.T = nan(subN,4);
OV.Syllable = nan(subN,4);
OV.W = nan(subN,4);
OV.header = {'sameRT','differentRT',  'sameER', 'differentER'};
%%
for i = 1:subN
    subName = [path subList{i} '.mat']; 
    load(subName);
    if isfield(OP,cond)
        F=OP.(cond);
        if size(F,2)>1 % some do 2 blocks
            RT = [F(1).responseLatency;F(2).responseLatency];
            isC = [F(1).isCorrect;F(2).isCorrect;];
            Er = [F(1).earRelation;F(2).earRelation];
            Tr = [F(1).Trelation;F(2).Trelation];
            Cr = [F(1).Crelation;F(2).Crelation];
            Vr = [F(1).Vrelation;F(2).Vrelation];
            Pr = [F(1).Prelation;F(2).Prelation];
            cueID = [F(1).cueID;F(2).cueID;];
            targetID = [F(1).targetID;F(2).targetID];
        else
        RT = F.responseLatency;
        Er = F.earRelation;
        isC = F.isCorrect;
        Tr = F.Trelation;
        Cr = F.Crelation;
        Vr = F.Vrelation;
        Pr = F.Prelation;
        cueID = F.cueID;
        targetID = F.targetID;   
        end
        % rid of cutoffs and errors
        RT(isC==0) = NaN;
        RT(RT<lowCut) = NaN;
        RT(RT>nanmean(RT)+highCut*nanstd(RT)) = NaN;

        % calculate variables
        OV.ear(i, 1:4) = [nanmean(RT(Er==1)), nanmean(RT(Er==2)),...
            numel(find(isC==0 & Er==1))/numel(find(Er==1)), ...
            numel(find(isC==0 & Er==2))/numel(find(Er==2))];
        OV.C(i, 1:4) = [nanmean(RT(Cr==1)), nanmean(RT(Cr==2)),...
            numel(find(isC==0 & Cr==1))/numel(find(Cr==1)), ...
            numel(find(isC==0 & Cr==2))/numel(find(Cr==2))];
        OV.V(i, 1:4) = [nanmean(RT(Vr==1)), nanmean(RT(Vr==2)),...
            numel(find(isC==0 & Vr==1))/numel(find(Vr==1)), ...
            numel(find(isC==0 & Vr==2))/numel(find(Vr==2))];
        OV.T(i, 1:4) = [nanmean(RT(Tr==1)), nanmean(RT(Tr==2)),...
            numel(find(isC==0 & Tr==1))/numel(find(Tr==1)), ...
            numel(find(isC==0 & Tr==2))/numel(find(Tr==2))];
        
%         OV.Syllable(i, 1:4) = [nanmean(RT(Pr==1)), nanmean(RT(Pr==2)),...
%             numel(find(isC==0 & Pr==1))/numel(find(Pr==1)), ...
%             numel(find(isC==0 & Pr==2))/numel(find(Pr==2))];

        OV.Syllable(i, 1:4) = [nanmean(RT(Cr==1&Vr==1)), nanmean(RT(Cr==2 | Vr==2)),...
            numel(find(isC==0 &(Cr==1&Vr==1)))/numel(find(Cr==1&Vr==1)), ...
            numel(find(isC==0 & (Cr==2 | Vr==2)))/numel(find(Cr==2 | Vr==2))];

                OV.W(i, 1:4) = [nanmean(RT( cueID == targetID)), nanmean(RT( cueID ~= targetID)),...
            numel(find(isC==0 & cueID == targetID))/numel(find(cueID == targetID)), ...
            numel(find(isC==0 & cueID ~= targetID))/numel(find(cueID ~= targetID))];
        
    end
end

%cd(cfolder);