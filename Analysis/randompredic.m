close all
p=2/3;
%    [n,c]=size(dataClass{i});
% ind=randperm(n/caliEEG.sampleRate);
for i = 1:3
    [n,c]=size(dataClass{i});
    temp = reshape(dataClass{i},caliEEG.sampleRate,[],c);
    temp=temp(:,randperm(n/caliEEG.sampleRate),:);
    temp=reshape(temp,[],c);
    caliData{i}=temp(1:round(p*n),:);
    testData{i}=temp(round(p*n)+1:end,:);
end

[CSP,LDA,CSPPattern]=CSPCrossBuild(caliData,caliEEG.sampleRate,1);
[label,CSPFeat]=CSPpredict(testData,CSP,LDA,caliEEG.sampleRate);%%
figure(101);

truelabel(:,1)=[1*ones(length(testData{1})/caliEEG.sampleRate,1);-1*ones(length(testData{2})/caliEEG.sampleRate,1);0*ones(length(testData{3})/caliEEG.sampleRate,1)];
truelabel(:,2)=[1*ones(length(testData{1})/caliEEG.sampleRate,1);0*ones(length(testData{2})/caliEEG.sampleRate,1);-1*ones(length(testData{3})/caliEEG.sampleRate,1)];
truelabel(:,3)=[0*ones(length(testData{1})/caliEEG.sampleRate,1);1*ones(length(testData{2})/caliEEG.sampleRate,1);-1*ones(length(testData{3})/caliEEG.sampleRate,1)];


for i = 1:3
subplot(3,1,i);
area(label{i});
hold on
area(truelabel(:,i),'FaceAlpha',0.3,'FaceColor','r')
  legend('predict label','true label')
end
% area(label{1});
[~,temp]=CSPpredict(caliData,CSP,LDA,caliEEG.sampleRate);%%
%%
close all
i=1
k=3
n=size(temp{k},1)/3;
n1=size(CSPFeat{k},1)/3;
histogram(temp{k}(n+1:2*n,i));
hold on
histogram(temp{k}(2*n+1:3*n,i));
histogram(CSPFeat{k}(n+1:2*n1,i));
histogram(CSPFeat{k}(2*n1+1:3*n1,i));
%%


% temp=appendCell(temp,CSPFeat);
% % temp=vertcat(temp{:});
% ind=[1:2*n 3*n+1:3*n+2*n1];
% temp=temp{3}(ind,:);
% c=zeros(size(temp,1),1);
% c(1:n)=1;
% c(n+1:2*n)=2;
% c(2*n+1:2*n+n1)=-1;
% c(2*n+n1+1:2*n+2*n1)=-2;
% figure;
% scatter3(temp(:,1),temp(:,3),temp(:,6),[],c,'filled')
% colormap jet
% 
% sc
% histogram(temp(1:n,2))
% 
% histogram(temp(n+1:2*n,3))
% hold on
% histogram(temp(2*n+1:3*n,3))