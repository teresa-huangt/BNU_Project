%% analysing individually
%  [finderror findright findsort]
%  错误的拼写，正确的拼写，所属分组

%% WORD
%ACC
 subID = 'test1122'
  path = 'F:/Work/SAM_model_Behavior/data/';
  data = [path subID '.mat'];
  load(data);
  isCorrect = OP.WordsInput(2).isCorrect;
  ACC_word = cal_ACC(isCorrect)
  
 % 
ind=find(isCorrect==0);
finderror =OP.WordsInput(2).responseChar(ind);
findrightCODE =OP.WordsInput(2).IDcode(ind);
load('femalewordName.mat');
findright=idSpoken(findrightCODE,1);
findsort =OP.WordsInput(2).IDsort(ind);
vs_word=[finderror,findright,  findsort]

%% VOWEL
%ACC
  isCorrect = OP.VowelsInput(2).isCorrect;
  ACC_vowel = cal_ACC(isCorrect)
  
 % 
ind=find(isCorrect==0);
finderror =OP.VowelsInput(2).responseChar(ind);
findrightCODE =OP.VowelsInput(2).IDcode(ind);
load('femalewordName.mat');
findright=idSpoken(findrightCODE,1);
findsort =OP.VowelsInput(2).IDsort(ind);
vs_vowel=[finderror,findright,  findsort]


