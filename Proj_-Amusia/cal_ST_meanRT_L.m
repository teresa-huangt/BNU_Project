function OV = cal_ST_meanRT_L(cond, lowCut, highCut)
% function OV = cal_phonemeLevel(cond, lowCut, highCut)
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

OV.RT = nan(subN,4); % S&T: 
OV.ER= nan(subN,4);
OV.N= nan(subN,4);

OV.header = {'SSST', 'SSDT', 'DSST', 'DSDT'};
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
            Tr = [F(1).Trelation;F(2).Trelation];
            Cr = [F(1).Crelation;F(2).Crelation];
            Vr = [F(1).Vrelation;F(2).Vrelation];
            %Pr = [F(1).Prelation;F(2).Prelation];
            Lr = [F(1).earRelation;F(2).earRelation];
        else
            RT = F.responseLatency;
            isC = F.isCorrect;
            Tr = F.Trelation;
            Cr = F.Crelation;
            Vr = F.Vrelation;
            %Pr = F.Prelation;
            Lr = F.earRelation;
        end
        
        % S relationship
        Pr = NaN(length(Cr),1);
        Pr(Cr==1&Vr==1)=1;
        Pr(Cr==2|Vr==2)=2;
        
        % rid of cutoffs and errors
        RT(isC==0) = NaN;
        RT(RT<lowCut) = NaN;
        RT(RT>nanmean(RT)+highCut*nanstd(RT)) = NaN;

        %% calculate RT variables
        % lc
        OV.RT(i, 1:4) = [nanmean(RT( Pr == 1 & Tr == 1)), ...
            nanmean(RT(Tr == 2 & Pr == 1)),nanmean(RT(Tr == 1 & Pr == 2)), ...
            nanmean(RT(Tr == 2 & Pr == 2))];
        
        % count valid trials for each condition (excluding both errors and
        % cutoffs, which may overlap, so count actual trials used
      
        OV.N(i, 1:4) = [numel(find(isnan(RT(Pr == 1 & Tr == 1))==0)),...
        numel(find(isnan(RT(Pr == 1 &Tr == 2))==0)), ...
        numel(find(isnan(RT(Pr == 2 & Tr == 1 ))==0)), ...
        numel(find(isnan(RT(Pr == 2 &Tr == 2))==0))];
        
        % calculate error rate
        OV.ER(i, 1:4) = [numel(find(isC==0 &  Pr == 1 & Tr == 1))/numel(find( Pr == 1 & Tr == 1)), ...
            numel(find(isC==0 &  Pr == 1 & Tr == 2))/numel(find( Pr == 1 & Tr == 2)), ...
            numel(find(isC==0 &  Pr == 2 & Tr == 1))/numel(find(  Pr == 2 & Tr == 1)), ...
            numel(find(isC==0 &  Pr == 2 & Tr == 2))/numel(find(  Pr == 2 & Tr == 2))];
    end
end

