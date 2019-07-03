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
tgtChan=find(goodChan==36);
session = 2;

[EEG1,evt]=NIMatLoad(calNIFile,session);
trialAssign=load([calMatFile(session).folder '/' calMatFile(session).name],'trialAssign');
trialAssign=trialAssign.trialAssign;
trialClass=trialAssign;
trialClass(trialAssign==0)=-1;
EEG1 = EEG1(goodChan,:);
EEG1 = firEEG(EEG1);

dataTrial  = trialExtract(EEG1,evt);
%%
overlap=0.90;
main;
classERDTF;
topoLogERD(sumLogERDR1,[7 13],5,1000,tgtChan,goodChan,overlap);
topoLogERD(sumLogERDR0,[7 13],5,1000,tgtChan,goodChan,overlap);
%%

[ERPFeat,catERPFeat]=calERPFeat(logERPTrial);
%%


[coeff,score,latent,tsquared,explained,mu] =pca(ERPFeat{4});
figure;
scatter3(score(:,1),score(:,2),score(:,3),[],1:110,'filled')
colormap autumn
%%

[Y,loss]=tsne(ERPFeat{10},'NumDimensions',3);
figure;
scatter3(Y(:,1),Y(:,2),Y(:,3),[],1:110,'filled')
colormap autumn

%%
% catCovFeat=vertcat(covFeat{:});
c=1:size(ERPFeat{1},1);
c=repmat(c',1,length(dataTrial));
c=c*diag(trialClass);
c=c(:);
c(c<40&c>-40)=0
%%
[coeff,score,latent,tsquared,explained,mu] =pca(catERPFeat);
figure;
scatter3(score(:,1),score(:,2),score(:,3),[],c,'filled')
colormap jet

%%
n=3;
index=int32(1:n*(11/(1-overlap)));
figure;
scatter3(score(index,1),score(index,2),score(index,3),[],c(index),'filled')
colormap autumn


%%
tic
[Y,loss]=tsne(catERPFeat,'NumDimensions',3);
toc
%%
figure;
scatter3(Y(:,1),Y(:,2),Y(:,3),[],c(:),'filled')
colormap jet
%%
n=3;
index=int32(1:n*(11/(1-overlap)));
figure;
scatter3(Y(index,1),Y(index,2),Y(index,3),[],c(index),'filled')
colormap autumn

% %%
% scatter(Y(:,1),Y(:,2),[],c,'filled')