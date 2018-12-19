%% REFERENCE:
% https://github.com/lucklab/erplab/wiki/Measuring-amplitudes-and-latencies-with-the-ERP-Measurement-Tool:-Tutorial
clear all; clc;
%OPEN
eeglab
numsubjects =5;

% Exp2-tone
parentfolder = 'D:/Work_D/EXP2-TAIL-tone/'
cd(parentfolder);

% % Exp5-word
% parentfolder = 'D:/Work_D/EXP5-TAIL-word/'
% cd(parentfolder);

% % Exp3-vowel (差值AF34后再做)
% parentfolder = 'D:/Work_D/EXP3-TAIL-vowel/'
% cd(parentfolder);

%load data
load('refM_secondS_allerp.mat') 


%% 100-160ms
% bin56(vowel variation)
ampMean = pop_geterpvalues( ALLERP, [100 160], [5 6 ], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                 'Filename', [parentfolder 'T100160_ampMean_bin56.txt'],  'Measure', 'meanbl', 'Resolution',1 );
             
ampPeak = pop_geterpvalues(  ALLERP, [100 160], [5 6 ], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                  'Filename', [parentfolder 'T100160_ampPeak_bin56.txt'],  'Measure', 'peakampbl', 'Resolution',1 );
              
latencyPeak = pop_geterpvalues( ALLERP, [100 160], [5 6], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                  'Filename', [parentfolder 'T100160_latPeak_bin56.txt'], 'Measure', 'peaklatbl', 'Resolution',1 );
            
areaMean_neg2pos = pop_geterpvalues( ALLERP, [100 160], [5 6], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                  'Filename', [parentfolder 'T100160_areaMean_neg2pos_bin56.txt'], 'Measure', 'areat', 'Resolution',1 );
              
              
% bin1011 (tone variation)
ampMean = pop_geterpvalues( ALLERP, [100 160], [10 11 ], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                 'Filename', [parentfolder 'T100160_ampMean_bin1011.txt'],  'Measure', 'meanbl', 'Resolution',1 );
             
ampPeak = pop_geterpvalues(  ALLERP, [100 160], [10 11 ], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                  'Filename', [parentfolder 'T100160_ampPeak_bin1011.txt'],  'Measure', 'peakampbl', 'Resolution',1 );
              
latencyPeak = pop_geterpvalues( ALLERP, [100 160], [10 11], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                  'Filename', [parentfolder 'T100160_latPeak_bin1011.txt'], 'Measure', 'peaklatbl', 'Resolution',1 );
            
areaMean_neg2pos = pop_geterpvalues( ALLERP, [100 160], [10 11], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                  'Filename', [parentfolder 'T100160_areaMean_neg2pos_bin1011.txt'], 'Measure', 'areat', 'Resolution',1 );

%% 200-300ms
% bin56(vowel variation)
ampMean = pop_geterpvalues( ALLERP, [200 300], [5 6 ], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                 'Filename', [parentfolder 'T200300_ampMean_bin56.txt'],  'Measure', 'meanbl', 'Resolution',1 );
             
ampPeak = pop_geterpvalues(  ALLERP, [200 300], [5 6 ], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                  'Filename', [parentfolder 'T200300_ampPeak_bin56.txt'],  'Measure', 'peakampbl', 'Resolution',1 );
              
latencyPeak = pop_geterpvalues( ALLERP, [200 300], [5 6], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                  'Filename', [parentfolder 'T200300_latPeak_bin56.txt'], 'Measure', 'peaklatbl', 'Resolution',1 );
            
areaMean_neg2pos = pop_geterpvalues( ALLERP, [200 300], [5 6], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                  'Filename', [parentfolder 'T200300_areaMean_neg2pos_bin56.txt'], 'Measure', 'areat', 'Resolution',1 );
              
              
% bin1011 (tone variation)
ampMean = pop_geterpvalues( ALLERP, [200 300], [10 11 ], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                 'Filename', [parentfolder 'T200300_ampMean_bin1011.txt'],  'Measure', 'meanbl', 'Resolution',1 );
             
ampPeak = pop_geterpvalues(  ALLERP, [200 300], [10 11 ], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                  'Filename', [parentfolder 'T200300_ampPeak_bin1011.txt'],  'Measure', 'peakampbl', 'Resolution',1 );
              
latencyPeak = pop_geterpvalues( ALLERP, [200 300], [10 11], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                  'Filename', [parentfolder 'T200300_latPeak_bin1011.txt'], 'Measure', 'peaklatbl', 'Resolution',1 );
            
areaMean_neg2pos = pop_geterpvalues( ALLERP, [200 300], [10 11], 1:62 , 'Baseline', 'pre', 'Erpsets', [1:numsubjects], 'FileFormat', 'wide', ...
                  'Filename', [parentfolder 'T200300_areaMean_neg2pos_bin1011.txt'], 'Measure', 'areat', 'Resolution',1 );
