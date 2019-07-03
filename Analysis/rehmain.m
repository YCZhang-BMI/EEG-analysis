testeeID = 'i';
root = 'E:\chou\data\rehBMI/';
NIFile = dir([root 'NetStation/' testeeID '*.mat']);
% NIFile = dir(['E:\chou\data\326/' testeeID '*.mat']);
mffFile = dir([root 'NetStation/' testeeID '*.mff']);
matFile = dir([root testeeID '/' 'session*.mat']);
dataTrial = [];
trialAppend;
% dataTrial = dataCZTrial;
tgtChan=find(goodChan==36);
overlap=0.9;
main;


dataClass=cell(2,1);
for i = 1:length(dataTrial)
    dataClass{1}=[dataClass{1};dataTrial{i}(:,1001:4000)'];
    dataClass{2}=[dataClass{2};dataTrial{i}(:,6001:9000)'];
end

for i = 1:length(dataClass)
    dataClass{i}=dataClass{i}(1:10:end,:);
end
%%
for i = 1:10
dataClass2{1}=reshape(dataClass{1},300,[],76);
dataClass2{2}=reshape(dataClass{2},300,[],76);
dataClass2{1}=dataClass2{1}(:,randperm(250),:);
dataClass2{2}=dataClass2{2}(:,randperm(250),:);
dataClass2{1}=reshape(dataClass2{1},[],76);
dataClass2{2}=reshape(dataClass2{2},[],76);


dataClass1{1}=dataClass2{1}(1:6000,:);
dataClass1{2}=dataClass2{2}(1:6000,:);
dataClass3{1}=dataClass2{1}(6001:end,:);
dataClass3{2}=dataClass2{2}(6001:end,:);

[CSP,LDA]=CSPCrossBuild(dataClass1,100,0);

[label,CSPFeat]=CSPpredict(dataClass3,CSP,LDA,100);
disp(i)
ac(i)=sum(label{1}==[ones(690,1);ones(690,1)*-1])/1380;
end

%%
figure;
 area(label{1})
  hold on
  area([ones(450,1);ones(450,1)*-1],'FaceAlpha',0.3,'FaceColor','r')
  legend('predict label','true label')