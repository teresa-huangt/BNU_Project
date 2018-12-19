% sort and calculate
%
% homeWork_chengsy
% Update :  11/29/2016
% Note: change path  and infoPath
 
% set path 
path = 'F:/course/MA1-1/matlab/Data_sort/data/';

% get excel file name
files= dir([ 'F:/course/MA1-1/matlab/Data_sort/data/*.xlsx']);
fileList = {files.name};

% load excel data
subN = length(fileList);
for i = 1:subN
      fileName = fileList{i};
      filePath = [path fileName];
      excelData = xlsread(filePath);
      
      % re-order according to column 1
      % ���յ�һ������
      excelData = sortrows(excelData,1);
      
      
      % order by column
      mfileList = {'congruence','central','surrounding','response','RT' };
      columnN = length(mfileList);
      for j = 1: columnN
      mfileName = mfileList{j};
      columnData = excelData(: ,j);
      S.(mfileName)= columnData;
      end
      congruence = S.congruence;
      central = S.central;
      surrounding = S.surrounding;
      response = S.response;
      RT = S.RT;
      
      % clear data 
      % 1.S12�ķ�Ӧʱ�Ǹ�ֵ���޳���
      % 2.�޳���Ӧ�����trial(���ڶ��к͵����У����һ����˵����Ӧ��ȷ)
      cutMarker = 0;
      RT(RT<cutMarker) = NaN;
      RT(response~=central) = NaN;
      
      % cal mean RT for 4 condition (column1)
      % ����4�������Ӧʱ��ֵ��
      RT_4condition(i,1:4) = [ nanmean(RT(congruence ==1)),nanmean(RT(congruence ==2)) ,nanmean(RT(congruence ==3)) ,nanmean(RT(congruence ==4)) ];
      % cal mean RT for congruence
      % �ټ���һ�ºͳ�ͻ�ķ�Ӧʱ��ֵ��
      %14��ʾ����������һ�£�23��ʾ���������ĳ�ͻ
      RT_2congruence(i,1:2) =[ nanmean(RT(congruence ==1| congruence ==4)),nanmean(RT(congruence ==2 | congruence ==3))  ];

end

% gather (subjects' demography info + 4 confition RT+ 2 congruence RT )
      RT_gather =[RT_4condition,RT_2congruence];
      infoPath = 'F:/course/MA1-1/matlab/Data_sort/������Ϣ.xlsx';
      [num,txt,raw] = xlsread(infoPath);
      info = raw(2:16,1); % only extract useful info
      T = table(RT_gather,  'RowNames',info)% to see...
      wholeTable = {info RT_gather };
      save wholeTable wholeTable
% write to excel
     xlswrite('chengsy_data.xlsx', info,1,'A1');
     xlswrite('chengsy_data.xlsx', RT_gather,1,'B1');
     



