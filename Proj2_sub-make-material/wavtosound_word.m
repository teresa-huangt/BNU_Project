%% wav2sound
%
%将所有的.wav 文件转化成可以数组格式

%pathList={'base syllable','nonexistent syllable','vowel change exisyllable','tone change exisyllable'};
pathList={'baseSyllable','nonexistSyllable','vowelChanged','toneChanged'};

%path0=['F:\Work\SAM_tone_model\录音_removeGap_update160831\nomr500_fade40ms\'];
path0=['F:\Work\proj_YE\录音12142016_播音专业录\4_normalize650ms - 补录修正\'];

n1=ones(30,1); %for sortID
        for n=1:length(pathList)
        pathName=strcat(path0,pathList(n)) 
     
        cd (pathName{1,1});
        wavfile= [pathName{1,1} '\*.wav'];
        names=dir(wavfile);

                for i=1:length(names)
                str=names(i).name;
                ind=findstr(str,'.');
                
                ID{i,1}=str(1:ind-1);%元胞数组的第一列是.wav文件的名称
                
                [sampledata,FS] = audioread(str);                
                getAudio = sampledata';
                getRms = rms(getAudio(1,:));
                ampAudio= getAudio*0.5/getRms; %mormalize amplitude
                ID{i,2}=ampAudio; %元胞数组的第二列是.wav文件的数组  
                
                end
        idSpoken{n}=ID;
        nn=num2cell(n1);
        nList{n}=nn;
        n1=n1+1;
        end

idSpoken =[idSpoken{1},nList{1,1};idSpoken{2},nList{1,2};idSpoken{3},nList{1,3};idSpoken{4},nList{1,4}];
%save idSpoken idSpoken 

cd('F:\Work\proj_YE\codes- 单字');
%save('femalewordName.mat','idSpoken'); %测可听度用（note：需再增加列的信息）
save('word20170802_amp.mat','idSpoken'); %测可听度用（note：需再增加列的信息）

%% Change format for real task (monitor)
% femalewordName.mat : 120*4 cell for testing audibility
% convert to fwordName.mat : 30*4 cell
load femalewordName %idSpoken
c1 = idSpoken(1:30,2);
c2 = idSpoken(31:60,2);
c3 = idSpoken(61:90,2);
c4 = idSpoken(91:120,2);
idSpoken = [c1 c2 c3 c4];
cd('F:\Work\proj_YE\codes- 单字');
%save('fwordName_removeGap.mat','idSpoken');%正式试验用
save('word20170802_amp_removeGap.mat','idSpoken');%正式试验用

%试听
for i=1:length(idSpoken(:,2))
    
    sound(idSpoken{i,2},44100);
    pause(1);
end
