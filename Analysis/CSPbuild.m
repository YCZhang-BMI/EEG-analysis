addpath('E:\chou\Script\storage')
testeeID = 'a';
root = 'E:\chou\data\0531CSP/';
calNIFile = dir([root testeeID '_cali*.mat']);
calMffFile = dir([root testeeID '_cali*.mff']);
sessionNIFile = dir([root testeeID '_test*.mat']);
sessionMffFile = dir([root testeeID '_test*.mff']);
calMatFile = dir([root 'calSession*.mat']);
sessionMatFile = dir([root 'session*.mat']);


load CSPgoodChan
sessionCount = 2;

[EEG1,evt]=NIMatLoad(calNIFile,sessionCount);
EEG1 = EEG1(goodChan,:);
EEG1 = firEEG(EEG1);
dataTrial=trialExtract(EEG1,evt);
load([calMatFile(sessionCount).folder '/' calMatFile(sessionCount).name]);
dataTrial1=dataTrial(trialAssign==1);
dataTrial0=dataTrial(trialAssign==0);

calRest = [];
calTask1 = [];
calTask0 = [];
for i = 1:length(dataTrial)
    calRest=[calRest;dataTrial{i}(:,1001:5000)'];
end
for i = 1:length(dataTrial1)
    calTask1=[calTask1;dataTrial1{i}(:,5501:11500)'];
end
for i = 1:length(dataTrial0)
    calTask0=[calTask0;dataTrial0{i}(:,5501:11500)'];
end


ChannelLocation;
[CSPR1,LDAR1]=CSPBuild(calRest,calTask1,1000,0);
[CSPR0,LDAR0]=CSPBuild(calRest,calTask0,1000,0);
[CSPT,LDAT]=CSPBuild(calTask1,calTask0,1000,0);


% [CSPR1,SVMR1]=CSPBuildSVM(calRest,calTask1);
% [CSPR0,SVMR0]=CSPBuildSVM(calRest,calTask0);
% [CSPT,SVMT]=CSPBuildSVM(calTask1,calTask0);