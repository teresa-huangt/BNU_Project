
load data2B.mat;

RT = data2.summary(:,1:2:12);
RTms = RT.*1000;
ER = data2.summary(:,2:2:12);
CR = 1-ER;
IES = RTms./CR;
data2.summaryIES = IES;

save data2B data2