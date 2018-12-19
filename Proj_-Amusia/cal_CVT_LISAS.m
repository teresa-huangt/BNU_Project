%
%% CVT st/dt
% CVT-SAME TONE

% load data2D.mat;
% 
% taskList = {'speechEar_rovGap',...
%     'speechID_rovGap',...
%     'phoneticDisc_rovGap',...
%     'consDisc_rovGap',...
%     'vowelDisc_rovGap',...
%     'toneDisc_rovGap'};
% fieldList = {'CVT_mean','CVT_median'};
% 
% for i =1: length(taskList)
%     taskName = taskList{i};
%     for j=1: length(fieldList)
%         fieldName = fieldList{j};
%         
%         %  exact data matrix
%         RTmatrix = data2.(taskName).(fieldName).RTst;%RTms = RT.*1000;
%         ERmatrix = data2.(taskName).(fieldName).ERst;
%         sRTmatrix = nanstd(RTmatrix);
%         sERmatrix = nanstd(ERmatrix);
%         [sub,con] = size(RTmatrix);
%         LISAS = nan(sub,con);
%         
%         % cal LISAS
%         for i = 1:con
%             for j = 1:sub
%                 RT = RTmatrix(j,i);
%                 ER = ERmatrix(j,i);
%                 sRT = sRTmatrix(i);
%                 sER = sERmatrix(i);
%                 LISAS(j,i) = RT+(sRT/sER)*ER;
%                 
%             end
%         end
%         
%         % save
%         data2.(taskName).(fieldName).LISASst=LISAS;
%     end
% end
% 
% save data2D data2

% CVT-DIFFERENT TONE
load data2D.mat;

taskList = {'speechEar_rovGap',...
    'speechID_rovGap',...
    'phoneticDisc_rovGap',...
    'consDisc_rovGap',...
    'vowelDisc_rovGap',...
    'toneDisc_rovGap'};
fieldList = {'CVT_mean','CVT_median'};

for i =1%1: length(taskList)
    taskName = taskList{i};
    for j=2%1: length(fieldList)
        fieldName = fieldList{j};
        
        %  exact data matrix
        RTmatrix = data2.(taskName).(fieldName).RTdt;%RTms = RT.*1000;
        ERmatrix = data2.(taskName).(fieldName).ERdt;
        sRTmatrix = nanstd(RTmatrix);
        sERmatrix = nanstd(ERmatrix);
        [sub,con] = size(RTmatrix);
        LISAS = nan(sub,con);
        
        % cal LISAS
        for i = 2%1:con
            for j = 1:sub
                RT = RTmatrix(j,i);
                ER = ERmatrix(j,i);
                sRT = sRTmatrix(i);
                sER = sERmatrix(i);
                LISAS(j,i) = RT+(sRT/sER)*ER;
                
            end
        end
        
        % save
        data2.(taskName).(fieldName).LISASdt=LISAS;
    end
end

save data2D data2