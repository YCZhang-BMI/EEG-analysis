addpath('E:\chou\Script\storage')
addpath('E:\chou\BCILAB-devel')
testeeID = 'a';
root = 'E:\chou\data\0619_2/';
calNIFile = dir([root testeeID '_cali*.mat']);
calMffFile = dir([root testeeID '_cali*.mff']);
sessionNIFile = dir([root testeeID '_test*.mat']);
sessionMffFile = dir([root testeeID '_test*.mff']);
calMatFile = dir([root 'calSession*.mat']);
sessionMatFile = dir([root 'session*.mat']);
bcilab;
%%

% load c1020
load CSPgoodChan
dataClass=cell(3,1) ;
% clear ALLEEG
for sessionCount=3:4
load([calMatFile(sessionCount).folder '/' calMatFile(sessionCount).name]);
% caliEEG=EEGDownsample(caliEEG,100);

% ChannelLocation;

EEG=pop_importdata('data',caliEEG.data(:,goodChan)','srate',1000);
load chanlocs
EEG.chanlocs=chanlocs(goodChan);
EEG.event=labEvt(caliEEG);
EEG = pop_eegfiltnew(EEG,1,40);
EEG = pop_resample(EEG,100);
[EEG,com] = pop_reref(EEG,[]);
[ALLEEG,EEG]=eeg_store(ALLEEG,EEG,sessionCount);
end
eeglab redraw
%%


% myapproach = {'CSP' 'SignalProcessing',{'EpochExtraction',[2 5],'FIRFilter',[7 8 26 28]}};

% myapproach = {'SpecCSP' 'SignalProcessing',{'EpochExtraction',[2 5]}};

myapproach = {'SpecCSP' 'SignalProcessing',{'EpochExtraction',[2 5]} 'Prediction',{'FeatureExtraction',{'SpectralPrior',[7 15]}}};
% learn a predictive model
[trainloss,lastmodel,laststats] = bci_train('Data',ALLEEG(4),'Approach',myapproach,'TargetMarkers',{'left','start'}); 
disp(['training mis-classification rate: ' num2str(trainloss*100,3) '%']);
% CSPdisp(lastmodel.featuremodel.patterns')
% visualize results
bci_visualize(lastmodel)

[prediction,loss,teststats,targets] = bci_predict(lastmodel,ALLEEG(3));
disp(['test mis-classification rate: ' num2str(loss*100,3) '%']);
disp(['  predicted classes: ',num2str(round(prediction{2}*prediction{3})')]);  % class probabilities * class values
disp(['  true classes     : ',num2str(round(targets)')]);
