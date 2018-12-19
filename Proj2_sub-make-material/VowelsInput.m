function VowelsInput(subID,command)
% Modify from wavtosound.m + IdiomsInput.m
% Purpose:Test the audibility for further use
% Include 4 groups spoken words (Mandarin Chinese
%sortID:
% ...1:existent syllable targets;
% ...2:non-existent syllable targets;
% ...3:vowel changed filler;
% ...4:tone changed filler
%Huangt  04/16/2016


% %% wav2sound
% %clear
% %�����е�.wav �ļ�ת���ɿ��������ʽ
% pathList={'base syllable','nonexistent syllable','vowel change exisyllable','tone change exisyllable'};
% path0=['F:\Work\SAM_tone_model\Record_YE_1999_EXP1\wordrecord_YE1999_exp1\'];
% n1=ones(30,1); %for sortID
%         for n=1:length(pathList)
%         pathName=strcat(path0,pathList(n)) 
%      
%         cd (pathName{1,1});
%         wavfile= [pathName{1,1} '\*.wav'];
%         names=dir(wavfile);
% 
%                 for i=1:length(names)
%                 str=names(i).name;
%                 ind=findstr(str,'.');
%                 ID{i,1}=str(1:ind-1);%Ԫ������ĵ�һ����.wav�ļ�������
%                 [sampledata,FS] = audioread(str);
%                 ID{i,2}=sampledata';%Ԫ������ĵڶ�����.wav�ļ�������           
%                 end
%         idSpoken{n}=ID;
%         nn=num2cell(n1);
%         nList{n}=nn;
%         n1=n1+1;
%         end
% ����������������or��֪����������ô����
% idSpoken =[idSpoken{1},nList{1,1};idSpoken{2},nList{1,2};idSpoken{3},nList{1,3};idSpoken{4},nList{1,4}];
% %save idSpoken idSpoken 
% cd('F:\Work\SAM_tone_model\codes');
% save('wordName.mat','idSpoken');
%% WordsInput

if nargin <1 
subID='test';
booth='vionlin'; %
command='demo';
end
booth='violin';
   %load( 'NewwordName.mat');
    load( 'femalewordName.mat');
N=length(idSpoken);% SI from Yan.mat  c1-c4audio ;c5-c8 corresponding consonant+vowel+tone(maker :1-4); c9 the whole idioms in chinese
                                  % now from wordName.mat/
                                  % c1=consonant+vowel+tone(maker
                                  % :1-4);c2=audio;c3=sortID
                                 
switch command
    case 'demo' 
         load('femalewordName.mat');
         trialN = 5;
         A = randperm(trialN)';
         order= A(1:trialN);%
        %α���һ����ϰ�飺��ٴʶ�Ҫ����
    case 'run'
        trialN = N; %30;% (later add 30)only test gruop2-nonexist_words vowel part
        A = randperm(trialN)';
        order= A(1:trialN);
      %  order=A+30;
   
end

%������������
[LevL LevR]=setVol('noise',[],[],'wordFemale',[75 75],4,N); %booth default what��
bigFont = 30;
smallFont = 20;
%%

    AssertOpenGL; % Make sure the script is running on Psychtoolbox-3
    InitializePsychSound(1); % Initialize driver, request low-latency preinit:
    PsychPortAudio('Verbosity', 2); % 2 for real, 5 for debug
    samplingRate = 44100;
    nrchannels = 2;
    audioDevice=1;
    outputChannels=[0,1];
    pahandle = PsychPortAudio('Open', audioDevice, 1, 2, samplingRate, nrchannels,[],[],outputChannels);

%%
response = cell(trialN,1);
isCorrect = zeros(trialN,1);
RT = NaN(trialN,1);
cueTime=NaN(trialN,1);
ind = NaN;
i=1;


targetID=idSpoken(order,1);
sortID=idSpoken(order,3);%
precueDuration = 0.1+(0.5-0.1)*rand(trialN,1);
gap=NaN(trialN,1);
SOA = 0.5;

%%
f=figure('unit','normalized', 'position', [0.2 0.2 0.6,0.6], 'Color', [0.8 0.8 0.8]);
set(f, 'MenuBar', 'none', 'NumberTitle', 'off', 'Name', 'Audibility Test');

h_text=uicontrol ('style', 'text', 'fontsize', smallFont,...
    'Fontname', 'Crescent', 'String', ...
    {'������Ქ��һ�����ֵĶ��������ڲ��ּ��ֵ�����ƴ��ƴ����.';'';...
    '�����ڶ���������֮�󾡿������Ӧ��ƴ������ĸ';...
    '���������ֱ�ʾ'},...
    'units', 'normalized', 'position', [.1 .6 .8 .3], ...
    'BackgroundColor', [0.8 0.8 0.8]);
h_listen = uicontrol ('style', 'text', 'fontsize', bigFont,...
    'Fontname', 'Crescent', 'String', ...
    {'��ϸ��'},'units', 'normalized', 'position', [.3 .6 .3 .2], ...
    'BackgroundColor', [0.8 0.8 0.8],'visible','off');
h_type = uicontrol ('style', 'text', 'fontsize', bigFont,...
    'Fontname', 'Crescent', 'String', ...
   '��������ĸ+����','units', 'normalized', 'position', [.3 .6 .4 .2], ...
    'BackgroundColor', [0.8 0.8 0.8],'visible','off');
h_control=uicontrol('style', 'pushbutton', 'string', 'Start', ...
    'fontsize', bigFont, 'units', 'normalized', 'position', [.4 .2 .2 .1], ...
    'callback', @run_file, 'Backgroundcolor', [0.1, 0.5, 0.8], ...
    'Foregroundcolor', [0,1,0.3]);
h_input = uicontrol('style', 'edit', 'string', '', ...
    'units', 'normalized', 'position', [.1 .45 .7 .1], ...
    'fontsize', bigFont,'Visible', 'off', ...
    'Backgroundcolor', [0.2, 0.2, 0.2], ...
    'Foregroundcolor', [0.3, 0.3, 0.8], 'callback',@evaluate ,'SelectionHighlight','off');
%%
    function run_file(hObject, eventData)
        uicontrol(h_input);        
        set(h_control, 'Visible', 'off');
        set(h_text, 'Visible', 'off');
        set(h_listen,'Visible', 'on');
       pause(precueDuration(i));
        ind = order(i);
%         for j=1:3
%             cue1=SI{ind,j};
%             Left=LevL(i,j)*cue1(1,:);
%             Right=LevR(i,j)*cue1(1,:);
%              cue_isi=zeros(1,SOA*samplingRate-length(cue1));
%             cue{j}= [Left,cue_isi;Right,cue_isi];
%         end
%         cue = [cue{1},cue{2},cue{3}];

            cue1=idSpoken{ind,2};
            Left=LevL(i,1)*cue1(1,:);
            Right=LevR(i,1)*cue1(1,:);
             cue_isi=zeros(1,SOA*samplingRate-length(cue1));
            cue= [Left,cue_isi;Right,cue_isi];
 
        wholeDuration = length(cue)/samplingRate;
        PsychPortAudio('FillBuffer', pahandle, cue);
        cueStartTime = PsychPortAudio('Start', pahandle, 1, 0, 1);
        pause(wholeDuration);
        PsychPortAudio('Stop', pahandle);
      
        set(h_listen, 'Visible', 'off');%��ʾ����ϸ����
        set(h_type,'Visible', 'on');%��ʾ��������ƴ����������
        set(h_input,'string', '', 'Visible', 'on');%��ʾ�����
        uicontrol(h_input);
        T = GetSecs;
        [resptime, keyCode] = KbWait;%��¼����ʱ��ʱ��        set(h_control, 'visible', 'on', 'string', 'Next');
         RT(i)=resptime-T; 
    end
    
    %%
      function evaluate(hObject, eventData)
        
        S=get(hObject, 'string');
        response{i} = S;
        isCorrect(i) = strcmp(response{i},idSpoken{ind,4});%1 if correct, 0 if not
        set(h_input,'String','');
        set(h_input,'Backgroundcolor', [0.8, 0.8, 0.8],'Foregroundcolor', [0.8, 0.8, 0.8]);
        i=i+1;
       if i<= trialN;
           set(h_type, 'Visible','off');
           set(h_listen, 'Visible','on');
           pause(precueDuration(i));
           ind=order(i);
     %  for j=1:3
            cue1=idSpoken{ind,2};
            Left=LevL(i,1)*cue1(1,:);
            Right=LevR(i,1)*cue1(1,:);
             cue_isi=zeros(1,SOA*samplingRate-length(cue1));
            cue= [Left,cue_isi;Right,cue_isi];
            gap(i,1)=length(cue_isi)/44100;
     %   end     
        cueTime(i)=length(cue)/44100;
        %%
      %  cue = [cue{1},cue{2},cue{3}];
        wholeDuration = length(cue)/samplingRate;
        PsychPortAudio('FillBuffer', pahandle, cue);
        cueStartTime = PsychPortAudio('Start', pahandle, 1, 0, 1);
        pause(wholeDuration);
        PsychPortAudio('Stop', pahandle);
        
        set(h_type, 'Visible', 'on');%������ƴ��
        set(h_input,'string', '','Backgroundcolor', [0.2, 0.2, 0.2],'Foregroundcolor', [0.3, 0.3, 0.8]);
        uicontrol(h_input);
        %% ��¼��Ӧʱ
        T = GetSecs;
        [resptime, keyCode] = KbWait;%��¼����ʱ��ʱ��        set(h_control, 'visible', 'on', 'string', 'Next');
        RT(i)=resptime-T;
    
        else
            set(h_type,'Visible','off');
            set(h_listen,'Visible','off')
            set(h_text, 'string', '���Խ���', 'fontsize', bigFont,'visible','on');
            saveData;
            PsychPortAudio('Close');
            msgbox('finished')
            pause(1);
            close(f);
            
       end       
      end
%%
    function saveData
        S.Idioms=targetID;
        S.responseChar=response;
        S.isCorrect=isCorrect;
        S.responseLatency=RT;
         S.idSpoken= idSpoken;
        
        S.onsetTime=cueTime+RT;
        S.gap=gap;
        S.IDcode=order;
%        S.IDsort=cell2mat(sortID);
        S.IDsort=sortID;
%        S.ALL=[order,targetID,sortID];
        S.booth=booth;
        condition ='VowelsInput';
%        colHeaders =  {'Stimuli_Index','isCorrect','ResponeTime',};
       dataSave(subID,condition,S);
    end

end