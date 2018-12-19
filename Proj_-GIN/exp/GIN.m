%% Gap Detection - Gap in Noise Test (GIN)
%
% Parameters from:
% reference1:Widespread auditory deficits in tune deafness
% reference2:GIN (Gaps-In-Noise) Test Performance in Subjects with Confirmed Central Auditory Nervous System Involvement
%
% Update: 03/14/2017 huangt
%
% Note:
% 1. connect to GUI;
% 2. pure tone to white noise
% 3. binaural to monaural ?
% 4. control volumn

% BEGIN :D

function GIN

%% BASIC  PARAMETERS
% subject ID
subID = 'test20170320'

% block number
run = 1;

% trial number
command = 'demo';
switch command
    case 'demo'
        nTrials = 5;
    case 'probe'
        nTrials = 35;
end
% calibration
booth = 'Feb';
[A,B, C, D]=findLevel(booth,1000,75);
L=A;
R=B;
audioDevice = C;
outputChannels = D;
samplingRate = 44100;
nrchannels = 2;


%% EXPERIMENTAL PARAMETERS

% timeline
cueDur = 0.3;
trialDur = 6;
ISI = 5;
nTrial = 35;

% tone infomation
baseFreq = 1000;
rampDur = 0*0.001  ; 

% gap duration matrix(10type*6repeat=60trials)
%basicGap = [ 1.20:0.1:2.1]; % 10 types of gap duration
basicGap = [0.002, 0.003, 0.004, 0.005, 0.006, 0.008, 0.010, 0.012, 0.015, 0.020];
%basicGap = zeros(1,10);
repeatGap = repmat(basicGap,1,6); % Each gap duration is presented six times during the test for a total of 60 gaps
empty = zeros(1,45);
fullGap = [repeatGap,empty];
[~,len] = size(fullGap);
orderInex = randperm(len);
for i=1:len
    index = orderInex(1,i);
    randomGap(1,i) = fullGap(index);
end
randomGapDur = reshape(randomGap,[nTrial,3]);

% number of gaps in each trial
for i = 1:nTrial
    oneGap_list = randomGapDur(i,:);
    nGap(i,1) = sum(oneGap_list>0);
end


% tone duration matrix(>500ms)
randomToneDur = 0.5 + zeros(nTrial, 4);
for trial_ = 1 : nTrial
    rem = trialDur - sum(randomToneDur(trial_,:)) - sum(randomGapDur(trial_,:));
    for j = 1 : 3
        t = rand * rem;
        randomToneDur(trial_, j) = randomToneDur(trial_, j) + t;
        rem = rem - t;
    end
    randomToneDur(trial_, 4) = randomToneDur(trial_, 4) + rem;
end


%Preparing the reinforcement/feedback images
%These are taken from: http://psychtoolbox.org/wikka.php?wakka=FaqTextureWindow
happyFace=imread('./visualStimuli/500px-Happy_face.svg.png','png');
sadFace=imread('./visualStimuli/500px-Sad_face.svg.png','png');
awesomeFace=imread('./visualStimuli/600px-Happy_smiley_face.png','png')+170;


%%  INITIALIZE

AssertOpenGL;
Screen('Preference', 'SkipSyncTests', 1);
old_Verbosity=Screen('Preference', 'Verbosity', 1);
old_VisualDebuglevel=Screen('Preference', 'VisualDebuglevel', 3);
oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);

screens=Screen('Screens');
screenNumber=max(screens);
white=WhiteIndex(screenNumber);
black=BlackIndex(screenNumber);
[expWin,rect]=Screen('OpenWindow',screenNumber,white, [], [], 2);
[xCenter, yCenter] = RectCenter(rect);
Screen('BlendFunction', expWin, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

InitializePsychSound(1); % Initialize driver, request low-latency preinit:
PsychPortAudio('Verbosity', 2); % 2 for real, 5 for debug
pahandle = PsychPortAudio('Open', audioDevice, 1, 2, samplingRate, nrchannels,[],[],outputChannels);
% silence = zeros(2,0.1*samplingRate);
% PsychPortAudio('FillBuffer', pahandle, silence);
% PsychPortAudio('Start', pahandle, 1,0,1);
% WaitSecs(0.1);

KbName('UnifyKeyNames');
KbCheck;
ListenChar(2);
HideCursor;

% Text
instructionText =  'Press the total number of gaps/slience.\n\n\n range:0-3 \n\n\n Press any button to begin.';
debriefText = 'Well Done! \n Press a key to continue';
Screen('TextSize', expWin, 26);
Screen('TextFont', expWin, 'Helvetica');

% Prepare the fixation-cross texture
FixCr=ones(32)*255;
FixCr(16:17,:)=0;
FixCr(:,16:17)=0;
fixcross = Screen('MakeTexture',expWin,FixCr);
centreWindowCoords = [xCenter-10,yCenter-10,xCenter+10,yCenter+10];

for r = 1:run % all block loop
    %% GIVE INSTRUCTIONS
    
    DrawFormattedText(expWin, instructionText, 'center', 'center',0,75,false,false,1.5);
    Screen('Flip', expWin,0,0);
    KbWait([], 3);
    
    for i=1:nTrials % one block loop(all trial in one block)
        %% RUN EXPERIMENT
        
        % Construct audio
        this_trialdesign_gap = randomGapDur(i, :);
        this_trialdesign_ton = randomToneDur(i, :);
        
        gapSlience = cell(3, 1);
        for j = 1 : 3
            gapSlience{j} = zeros(1, fix(samplingRate*this_trialdesign_gap(j)));
        end
        %randomGapDur
        standardTone = cell(4, 1);
        for j = 1 : 4
            standardTone{j} = makeTone(baseFreq, this_trialdesign_ton(j), rampDur, samplingRate);
            points = size(standardTone{j},2)
            %addNoise = wgn(1,points,2)
            noise{j} = wgn(1,points,0 )%standardTone{j} + addNoise
        end
        stim_whole = [ noise{1}, gapSlience{1}, noise{2}, gapSlience{2}, noise{3}, gapSlience{3}, noise{4} ];
        %stim_whole = [ standardTone{1}, gapSlience{1}, standardTone{2}, gapSlience{2}, standardTone{3}, gapSlience{3}, standardTone{4} ];
        Left=L*stim_whole;
        Right=R*stim_whole;
        stim_whole = [Left;Right];
        
        % Cue figure
        Screen('DrawTexture', expWin, fixcross,[],centreWindowCoords);
        Screen('Flip', expWin,0,0);
        WaitSecs(cueDur);
        Screen('Flip', expWin,0,0)  ;
        
        % Play;
        PsychPortAudio('FillBuffer', pahandle, stim_whole);
        targetOnset(i)=PsychPortAudio('Start', pahandle, 1, 0, 1);
        
        % collect response
        while true
            [secs, keyCode] = KbWait([], 2);
            responseKey = KbName(keyCode);
            if strcmp(responseKey,'ESCAPE')
                ShowCursor;
                Screen('CloseAll'); %or sca
                PsychPortAudio('Close');
                Screen('Preference', 'Verbosity', old_Verbosity);
                Screen('Preference', 'VisualDebugLevel', old_VisualDebuglevel);
                Screen('Preference', 'SuppressAllWarnings', oldSupressAllWarnings);
                ListenChar(0);
            end
            responseKey = str2double(responseKey(1));
            
            if ismember(responseKey,[0 1 2 3])
                break
            end
        end
        
        % record response
        nResp(i, 1) = responseKey;
        
        %for feedback
        %         if responseKey>=nGap(i)
        if responseKey == nGap(i)
            isCorrect(i,1)=1;
            Screen('PutImage', expWin, happyFace);
        else
            isCorrect(i,1)=0;
            Screen('PutImage', expWin, sadFace);
        end
        Screen('Flip', expWin,0,0);
        WaitSecs(ISI);
    end
    % end figure
    Screen('PutImage', expWin, awesomeFace);
    DrawFormattedText(expWin, debriefText, 'center', 'center',0,75,false,false,1.5);
    Screen('Flip', expWin,0,0);
    KbWait([], 3);% Wait for key stroke.
end
% save eee
%% SAVE DATA
% save( sprintf('%s_Resp.mat', subID), 'randomGapDur', 'nResp','isCorrect' )

trackN = 1:nTrial;
condition = ['GIN' '_' command];
results = {trackN',nGap, nResp, isCorrect,randomGapDur};
colHeaders =  { 'trackN','nGap', 'nResp', 'isCorrect', 'randomGapDur'};
dataSave(subID, booth, results, colHeaders, condition); % commit one part in dataSave.m

%% OUTPUT (claculate threshold)
% data4test = [randomGapDur, nResp];
% 
% num_fa = 0;
% list_hit = [];
% for tri_ = 1 : nTrial
%     gap = randomGapDur(tri_, :);
%     gap = sort(gap, 'descend');
%     ngap = sum( 0~=gap );
%     nre = nResp(tri_);
%     if nre==ngap
%         list_hit = [list_hit, gap(1:ngap)];
%     end
%     if nre>ngap
%         list_hit = [list_hit, gap(1:ngap)];
%         num_fa = num_fa + 1;
%         data4test(tri_, 5) = 1;
%     end
%     if nre<ngap
%         list_hit = [list_hit, gap(1:nre)];
%     end
% end
% 
% fa_rate = num_fa / nTrial
% 
% compare_gap = unique(randomGapDur);
% compare_gap(0==compare_gap) = '';
% for j = 1 : length(compare_gap)
%     tmp = compare_gap(j, 1);
%     compare_gap(j, 2) = sum(tmp==randomGapDur(:));
%     compare_gap(j, 3) = sum(tmp==list_hit);
%     compare_gap(j, 4) = compare_gap(j, 3) / compare_gap(j, 2);
% end
% compare_gap = [ compare_gap, compare_gap(:,end)>=4/6 ]
% tmp = find( 0==compare_gap(:, end) );
% position = tmp(end) + 1;
% threshold = compare_gap(position,1)

%%  QUIT
ShowCursor;
Screen('CloseAll'); %or sca
PsychPortAudio('Close');
Screen('Preference', 'Verbosity', old_Verbosity);
Screen('Preference', 'VisualDebugLevel', old_VisualDebuglevel);
Screen('Preference', 'SuppressAllWarnings', oldSupressAllWarnings);
ListenChar(0);

end

