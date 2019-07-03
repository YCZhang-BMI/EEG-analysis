addpath('E:\chou\Script\storage')
testeeID = 'a';
root = 'E:\chou\data\0619_2/';
calNIFile = dir([root testeeID '_cali*.mat']);
calMffFile = dir([root testeeID '_cali*.mff']);
sessionNIFile = dir([root testeeID '_test*.mat']);
sessionMffFile = dir([root testeeID '_test*.mff']);
calMatFile = dir([root 'calSession*.mat']);
sessionMatFile = dir([root 'session*.mat']);
% load CSPgoodChan
% ChannelLocation;
%%
dataClassTrial=cell(2,1);
clear sessionPower
for sessionCount = 1:4

load([calMatFile(sessionCount).folder '/' calMatFile(sessionCount).name]);
caliEEG=EEGDownsample(caliEEG,100);
temp=matClassTrialExtract(caliEEG,[-5 5]);
dataClassTrial=appendCell(dataClassTrial,temp,3);
% temp=cellfun(@CAR,temp,'UniformOutput',false);
% temp=matscaling(temp);

% sessionPower(:,sessionCount)=log(var(temp{1},1));
% dataClass=appendCell(temp,dataClass);
end
overlap=0.9;
logERP4DClassTrial=cellfun(@(x) log(calc4DERP(x,caliEEG.sampleRate,overlap)),dataClassTrial,'UniformOutput',false);
sumLogERPClass=cellfun(@(x) (mean(x,4)),logERP4DClassTrial,'UniformOutput',false);
logERD4DClassTrial=cellfun(@(x) (calcLog4DERD(x,5,caliEEG.sampleRate,overlap)),logERP4DClassTrial,'UniformOutput',false);
sumLogERD4DClass=cellfun(@(x) (calcLog4DERD(x,5,caliEEG.sampleRate,overlap)),sumLogERPClass,'UniformOutput',false);
tfLogMap(sumLogERD4DClass{1},65)
topoLogERD(sumLogERD4DClass{1},[8 13],5,caliEEG.sampleRate,24,goodChan,overlap)
for i = 1:40
tfLogMap(logERD4DClassTrial{1}(:,:,:,i),65)
pause(0.5)
end

