function OV = cal_congruency_mean(cond, lowCut, highCut)
% function OV = cal_congruency(cond, lowCut, highCut)
% OV is a structure
% calculate congruency between ST(syllable and tone), and between CV


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
OV.ST = nan(subN,4); % ST-S(1),ST-D(234); ST-CONGRUENT(14) ,ST-INCON(23)
OV.CV = nan(subN,4); %  CV м╛ио
OV.LW = nan(subN,4); % LW
OV.STER= nan(subN,4);
OV.CVER = nan(subN,4);
OV.LWER = nan(subN,4);
OV.header = {'same1', 'different234',  'congruent14', 'incongruent23'};
%%
for i = 1:subN
    subName = [path subList{i} '.mat']; 
    load(subName);
    if isfield(OP,cond)
        F=OP.(cond);
        if size(F,2)>1 % some do 2 blocks
            RT = [F(1).responseLatency;F(2).responseLatency];
            isC = [F(1).isCorrect;F(2).isCorrect;];
            Tr = [F(1).Trelation;F(2).Trelation];
            Cr = [F(1).Crelation;F(2).Crelation];
            Vr = [F(1).Vrelation;F(2).Vrelation];
            Pr = [F(1).Prelation;F(2).Prelation];
            Lr = [F(1).earRelation;F(2).earRelation];
            cueID = [F(1).cueID;F(2).cueID;];
            targetID = [F(1).targetID;F(2).targetID];
        else
        RT = F.responseLatency;
        isC = F.isCorrect;
        Tr = F.Trelation;
        Cr = F.Crelation;
        Vr = F.Vrelation;
        Pr = F.Prelation;
        cueID = F.cueID;
        targetID = F.targetID;
        Lr = F.earRelation;
        end
        % rid of cutoffs and errors        
        %             trialN = length(RT);
        RT(isC==0) = NaN;
        RT(RT<lowCut) = NaN;
        RT(RT>nanmean(RT)+highCut*nanstd(RT)) = NaN;

 
% word relationship
for w=1:length(cueID)
    Wr(w,1) = isequal(cueID(w),targetID(w));
end
Wr=double(Wr);
Wr(find(Wr==0))=2;

        % calculate RT variables
        OV.ST(i, 1:4) = [nanmean(RT(Pr==1 & Tr==1)), ...
            nanmean(RT(Pr==2 | Tr==2)),...
            nanmean(RT(Pr==Tr)),...
            nanmean(RT(Pr~=Tr))];

        OV.CV(i, 1:4) = [nanmean(RT(Cr==1 & Vr==1)), ...
        nanmean(RT(Cr==2 | Vr==2)),...
        nanmean(RT(Cr==Vr)),...
        nanmean(RT(Cr~=Vr))];
    
            OV.LW(i, 1:4) = [nanmean(RT(Lr == 1 & Wr==1)), ...
            nanmean(RT(Lr == 2 | Wr==2)),...
        nanmean(RT(Lr==Wr)),...
        nanmean(RT(Lr~=Wr))];
    
        % calculate error rate
        OV.STER(i, 1:4) = [numel(find(isC==0 & Pr==1 & Tr==1))/numel(find(Pr==1 & Tr==1)), ...
            numel(find(isC==0 & (Pr==2 | Tr==2)))/numel(find(Pr==2 | Tr==2)), ...
            numel(find(isC==0 & Pr==Tr))/numel(find(Pr==Tr)),...
            numel(find(isC==0 & Pr~=Tr))/numel(find(Pr~=Tr))];
        
        OV.CVER(i, 1:4) = [numel(find(isC==0 & Cr==1 & Vr==1))/numel(find(Cr==1 & Vr==1)), ...
            numel(find(isC==0 & (Cr==2 | Vr==2)))/numel(find(Cr==2 | Vr==2)), ...
            numel(find(isC==0 & Cr==Vr))/numel(find(Cr==Vr)),...
            numel(find(isC==0 & Cr~=Vr))/numel(find(Cr~=Vr))];
        
        OV.LWER(i, 1:4) = [numel(find(isC==0 & Lr==1 & Wr==1))/numel(find(Lr==1 & Wr==1)), ...
            numel(find(isC==0 & (Lr==2 | Vr==2)))/numel(find(Lr==2 | Wr==2)), ...
            numel(find(isC==0 & Lr==Wr))/numel(find(Lr==Wr)),...
            numel(find(isC==0 & Lr~=Wr))/numel(find(Lr~=Wr))];
    

 end
end

