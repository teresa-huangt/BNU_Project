function proj4_1o_group(groupN,ispost)
% fucntion proj4_group(groupN)
% groupN: 1 for group 1 & 2
%         3 for group 3 
%         4 for group 4
          
path1 = '../data_reelder/';

fieldList1 = {'lowpass1k_SAM8_ILD0probe','lowpass1k_SAM8_ILD6probe','puretone500_SAM8_ILD0probe'};

trainField1 = 'lowpass1k_SAM8_ILD0train';
trainField2 = 'puretone500_SAM8_ILD0train';
trainField3 = 'lowpass1k_SAM0_ITD0train';
trainField4 = 'lowpass1k_SAM0_ITD0train';

subList1={'1o-002','1o-007','1o-008','1o-009','1o-010',...
          '1o-011','1o-012','1o-013','1o-014','1o-015','1o-016'};


saveField1 = 'group1';
saveField2 = 'group3';
saveField3 = 'group4';
saveField4 = 'group5';

   if exist('proj4o_group.mat','file') %
      load proj4o_group.mat            %
   end
    
switch groupN
    case 1
        fieldList = fieldList1;
        trainField = trainField1;
        subList = subList1;
        saveField = saveField1;
    case 3
        fieldList = fieldList2;
        trainField = trainField2;
        subList = subList2;
        saveField = saveField2;
    case 4
        fieldList = fieldList3;
        trainField = trainField3;
        subList = subList3;
        saveField = saveField3;
    case 5
        fieldList = fieldList4;
        trainField = trainField4;
        subList = subList4;
        saveField = saveField4;
    otherwise 
        msgbox('Group not exist, please recheck your input','warn');
end


%% Code to manage Pre and Post test data
for M=1:length(fieldList)
fieldName = fieldList{M};

 thresh1=NaN(length(subList),7);
 numRev1=NaN(length(subList),7);
  date1=NaN(length(subList),7);
  
for N=1:length(subList)
varName = [path1 'proj4-' subList{N} '.mat'];
load(varName);

if isfield(OP, fieldName)

            mfileName = fieldnames(OP.(fieldName));
            blockN = length(mfileName);
            
            % calculating thresh repectively for pre and post test
                for j = 1:blockN       %pretest
                fileName = mfileName{j};
                
                X = OP.(fieldName).(fileName);
              if isfield(X, 'deltaILD')
                 [thresh,numRev] = cal_thresh(X.deltaILD,3,'linear');                                   
              elseif isfield(X, 'deltaITD')
                  [thresh,numRev] = cal_thresh(X.deltaITD ,3,'log');
              else
                  thresh= NaN; numRev=NaN;
              end
                          
                 thresh1(N, j) = thresh;
                 numRev1(N, j) = numRev;
                 date1(N,j) = datenum(X.date(1:3));                                       
                end
                                                      
else
    
    fieldName=fieldList{M};               
end
end
% save to group data
proj4o_group.(saveField).(fieldName).thresh = thresh1;
proj4o_group.(saveField).(fieldName).Rev = numRev1;
%proj4o_group.(saveField).(fieldName).Date = date1;
end


for c=1:length(fieldList)
     fieldName = fieldList{c};
     A=nanmean(proj4o_group.(saveField).(fieldName).thresh(:,1:2),2);%1:3 +¸ÄÇ°Ãæ
     B=nanmean(proj4o_group.(saveField).(fieldName).thresh(:,3:end),2);%3:end
        
       proj4o_group.(saveField).summary(:,(2*c-1):2*c)=[A,B];       
   
end


groupInd = nan(1,1);
for s =1:length(subList)
    sub = subList{s}(2);%control 2
    
    groupInd(s,1) = str2double(sub);
    
    proj4o_group.(saveField).groupInd = groupInd;
end

save proj4o_group_control proj4o_group

%% Code to manage data of training session
subList = subList(groupInd == groupN);  %to discard the control group

for N=1:length(subList)
varName = [path1 'proj4-' subList{N} '.mat'];
load(varName);

 if isfield(OP, trainField)
            mfileName = fieldnames(OP.(trainField));
            trainN = length(mfileName);
            thresh2=NaN(trainN,4);
                for j = 1:trainN
                fileName = mfileName{j};
                X = OP.(trainField).(fileName);
                if isfield(X,'deltaILD')
                [thresh,numRev] = cal_thresh(X.deltaILD,3,'linear');
                elseif isfield(X,'deltaITD')
                [thresh,numRev] = cal_thresh(X.deltaITD,3,'log');
                end
                thresh2(j,1:2) =[thresh,numRev];
                thresh2(j,3) = datenum(X.date(1:3));
                end
end
    % mark data with session number
    [B,I,J] = unique(thresh2(:,3));  % B = subData(I,4); subData(:,4)=B(J);
    % add session number to subData
    thresh2(:,4)= J;

threshbysession = NaN(length(B),3);
for i = 1:length(B)
    sessionN = J(I(i));
threshbysession(i,1) = sessionN; %session number

if any(ismember(groupN,[4,5])) 
    
threshbysession(i,2) = geomean(thresh2(J==sessionN,1)); %session mean
%outliers = find(thresh2(J==sessionN,1) > 2*threshbysession(i,2));
else
threshbysession(i,2) = nanmean(thresh2(J==sessionN,1));
end
threshbysession(i,3) = nanstd(thresh2(J==sessionN,1)); %session mean
end

%%
for i = 1:length(B)
    sessionN = J(I(i));
    thresh2(J==sessionN & thresh2(:,1) > 2.5*threshbysession(i,2),1:2)=NaN;
    
end
%%
for i = 1:length(B)
    sessionN = J(I(i));
    
if any(ismember(groupN,[4,5])) 
    
thresh22 = thresh2(J==sessionN,1);

threshbysession(i,2) = geomean(thresh22(~isnan(thresh22)));    %session mean

else
threshbysession(i,2) = nanmean(thresh2(J==sessionN,1));
end
threshbysession(i,3) = nanstd(thresh2(J==sessionN,1)); %session mean

end


% save to group data
Scode = ['S' subList{N}(1) 'o_' subList{N}(4:end)];

proj4o_group.(saveField).train.individually.(Scode).All = thresh2;
proj4o_group.(saveField).train.individually.(Scode).bySession = threshbysession;
end



 for r=1:length(subList)
     Scode = ['S' subList{r}(1) 'o_' subList{r}(4:end)];
     A = proj4o_group.(saveField).train.individually.(Scode).bySession;
     x=size(A,1);
     proj4o_group.(saveField).train.all.session(r,1:x)=A(:,1)'; 
     proj4o_group.(saveField).train.all.ILD(r,1:x)=A(:,2)'; 
     proj4o_group.(saveField).train.all.var(r,1:x)=A(:,3)';      
 end
 proj4o_group.(saveField).train.all.session(proj4o_group.(saveField).train.all.session==0)=NaN;
 proj4o_group.(saveField).train.all.ILD(proj4o_group.(saveField).train.all.ILD==0)=NaN;
 proj4o_group.(saveField).train.all.var(proj4o_group.(saveField).train.all.var==0)=NaN;
  
 save proj4o_group_train_all proj4o_group
 

end









