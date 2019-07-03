addpath('E:\chou\Script\storage')
testeeID = 'a';
root = 'E:\chou\data\0523CSP/';
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
% dataTrial1=dataTrial(trialAssign==1);
% dataTrial0=dataTrial(trialAssign==0);

%%
varR0=cell(length(dataTrial),1);
varR1=cell(length(dataTrial),1);
varT=cell(length(dataTrial),1);
labelR0=cell(length(dataTrial),1);
labelR1=cell(length(dataTrial),1);
labelT=cell(length(dataTrial),1);
for i = 1:length(dataTrial)
    varR0{i} = zeros(length(1:50:(length(dataTrial{i})-1000)),6);
    varR1{i} = zeros(length(1:50:(length(dataTrial{i})-1000)),6);
    varT{i} = zeros(length(1:50:(length(dataTrial{i})-1000)),6);
    data=dataTrial{i}';
    for j = 1:50:(length(dataTrial{i})-1000)
        varR0{i}((j-1)/50+1,:)=log(var(data(j:j+999,:)*CSPR0));
        varR1{i}((j-1)/50+1,:)=log(var(data(j:j+999,:)*CSPR1));
        varT{i}((j-1)/50+1,:)=log(var(data(j:j+999,:)*CSPT));
    end
    labelR0{i}=predict(LDAR0,varR0{i});
    labelR1{i}=predict(LDAR1,varR1{i});
    labelT{i}=predict(LDAT,varT{i}(101:end,:));
%     labelR0{i}=predict(SVMR0,varR0{i});
%     labelR1{i}=predict(SVMR1,varR1{i});
%     labelT{i}=predict(SVMT,varT{i});
end
%%
varR0=vertcat(varR0{:});
labelR0=vertcat(labelR0{:});
varR1=vertcat(varR1{:});
labelR1=vertcat(labelR1{:});
varT=vertcat(varT{:});
labelT=vertcat(labelT{:});

gscatter(varR0(:,1),varR0(:,6),labelR0)
gscatter(varR1(:,1),varR1(:,6),labelR1)
gscatter(varT(:,2),varT(:,5),labelT)

% scatter3(varR0(:,1),varR0(:,2),varR0(:,6),[],c,'filled')