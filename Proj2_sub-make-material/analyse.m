% 
% TEST audibility
%
% Update :  12/05/2016 huangt
% Note: 
 
% set path 
path = 'F:/Work/proj_YE/codes- µ¥×Ö/data/';

% get excel file name
files= dir([ 'F:/Work/proj_YE/codes- µ¥×Ö/data/*.mat']);
subList = {files.name};
% LIST
        fieldList = {'WordsInput','VowelsInput'};
         for M=1:length(fieldList)
            fieldName = fieldList{M};
              RT=NaN(120,length(subList));
             isC=NaN(120,length(subList));
             group=NaN(120,length(subList));
             for N=1:length(subList)
                varName = [path subList{N} ]; 
                load(varName);
                 if isfield(OP, fieldName)         

                        id=OP.(fieldName).IDcode;
                        sort=OP.(fieldName).IDsort;
                        acc=OP.(fieldName).isCorrect;
                        rt = OP.(fieldName).responseLatency;
                       % idiom = OP.VowelsInput.Idioms(id,1);
                        sort=cell2mat(sort);
                        all=[id sort acc rt];
                        sortall = sortrows(all,1);

 
                           RT(:,N) = sortall(:,4);
                           isC (:,N) = sortall(:,3);
                           group(:,N) = sortall(:,2);                      
                 end
                  
             end
              AU.(fieldName).RT=RT;
              AU.(fieldName).isC=isC;
              AU.(fieldName).group=group;
               AU.(fieldName).idiom=idiom;
         end

         save testaudio AU
 %
 load testaudio.mat
 W = AU.WordsInput.isC;
 V = AU.VowelsInput.isC;
 W=mean(W,2);
 V=mean(V,2);
 sum = [W,V]
   AU.SUM=sum;
 
