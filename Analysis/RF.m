addpath('E:\chou\Script\storage')
testeeID = 'a';
root = 'E:\chou\data\0531CSP/';
calNIFile = dir([root testeeID '_cali*.mat']);
calMffFile = dir([root testeeID '_cali*.mff']);
sessionNIFile = dir([root testeeID '_test*.mat']);
sessionMffFile = dir([root testeeID '_test*.mff']);
calMatFile = dir([root 'calSession*.mat']);
sessionMatFile = dir([root 'session*.mat']);

dataClass=cell(3,1) ;
for sessionCount = 1:3

load([calMatFile(sessionCount).folder '/' calMatFile(sessionCount).name]);
% caliEEG=EEGDownsample(caliEEG,100);
load CSPgoodChan
ChannelLocation;
dataClass=appendCell(extractClassData(caliEEG,1),dataClass);
end
for i = 1:length(dataClass)
classERP{i}=(calcERP(dataClass{i}',caliEEG.sampleRate,0));
end

for i = 1:length(classERP)
    classRFFeat{i}=horzcat(log(mean(classERP{i}(:,:,20:25),3))',log(mean(classERP{i}(:,:,15:19),3))',log(mean(classERP{i}(:,:,11:14),3))',log(mean(classERP{i}(:,:,8:11),3))',log(mean(classERP{i}(:,:,26:31),3))');
end
% n=size(classRFFeat{1},1);
%%
n=200;
clear ac
for n = 10:10:100
RFFeat=vertcat(classRFFeat{1}(1:n,:),classRFFeat{2}(1:n,:));

RFdl=TreeBagger(100,RFFeat,[ones(n,1);-1*ones(n,1)]);

PDFeat=vertcat(classRFFeat{1}(n+1:end,:),classRFFeat{2}(n+1:end,:));
label=predict(RFdl,PDFeat);
label=str2double(label);
figure(1);
area(label)
drawnow
ac(n/10)=sum(label==[ones(length(label)/2,1);-1*ones(length(label)/2,1)])/length(label)
end