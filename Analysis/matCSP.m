addpath('E:\chou\Script\storage')
testeeID = 'a';
root = 'E:\chou\data\0619_2/';
calNIFile = dir([root testeeID '_cali*.mat']);
calMffFile = dir([root testeeID '_cali*.mff']);
sessionNIFile = dir([root testeeID '_test*.mat']);
sessionMffFile = dir([root testeeID '_test*.mff']);
calMatFile = dir([root 'calSession*.mat']);
sessionMatFile = dir([root 'session*.mat']);
load CSPgoodChan
ChannelLocation;
%%
dataClass=cell(3,1) ;
clear sessionPower
for sessionCount = 4:4

load([calMatFile(sessionCount).folder '/' calMatFile(sessionCount).name]);
caliEEG=EEGDownsample(caliEEG,100);

temp=extractClassData(caliEEG,1,2,goodChan);
% temp=cellfun(@CAR,temp,'UniformOutput',false);
temp=matscaling(temp);

sessionPower{1}(:,sessionCount)=log(var(temp{1},1));

sessionPower{2}(:,sessionCount)=log(var(temp{2},1));

sessionPower{3}(:,sessionCount)=log(var(temp{3},1));
dataClass=appendCell(dataClass,temp,1);
end
%%
% dataClass=cellfun(@CAR,dataClass,'UniformOutput',false);
for i = 1:length(dataClass)
classERP{i}=log(calcERP(dataClass{i}',caliEEG.sampleRate,0.9));
end
% classERD{1}=classERP{2}-classERP{1};
% tfMap(classERD{1},24)


[CSP,LDA,CSPPattern]=CSPCrossBuild(dataClass,caliEEG.sampleRate,1);

[label,CSPFeat]=CSPpredict(dataClass,CSP,LDA,caliEEG.sampleRate);
% figure;
% scatter3(CSPFeat{1}(1:102,1),CSPFeat{1}(1:102,2),CSPFeat{1}(1:102,6),[],[ones(51,1);0*ones(51,1)],'filled')
% colormap jet
% caxis([-1.2 1.2])
%%
sessionCount = 3;
load([calMatFile(sessionCount).folder '/' calMatFile(sessionCount).name]);
caliEEG=EEGDownsample(caliEEG,100);
temp=extractClassData(caliEEG,1,2,goodChan);
% temp=cellfun(@CAR,temp,'UniformOutput',false);
temp=matscaling(temp);
testClass=temp;

[label,CSPFeat]=CSPpredict(testClass,CSP,LDA,caliEEG.sampleRate);
%%
figure;
for i = 1:3
subplot(3,1,i);
area(label{i});
end
