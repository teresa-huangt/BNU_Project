
load data2B.mat;

% exact data matrix
RTmatrix = data2.summary(:,1:2:12);
%RTms_matrix = RTmatrix.*1000;
ERmatrix = data2.summary(:,2:2:12);
[sub,con] = size(RTmatrix);
LISAS = nan(sub,con);
% cal std (total subjects)
sRTmatrix = std(RTmatrix);
sERmatrix = std(ERmatrix);
% cal LISAS
for i = 1:con
    for j = 1:sub
        RT = RTmatrix(j,i);
        ER = ERmatrix(j,i);
        sRT = sRTmatrix(i);
        sER = sERmatrix(i);
        LISAS(j,i) = RT+(sRT/sER)*ER;
        
    end
end

data2.summaryLISAS = LISAS;

save data2B data2