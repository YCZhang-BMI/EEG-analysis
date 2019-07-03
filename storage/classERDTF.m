dataTrialR1=dataTrial(trialAssign==1);
dataTrialR0=dataTrial(trialAssign==0);

sumDataTrialR1=calCellSum(dataTrialR1);
sumDataTrialR0=calCellSum(dataTrialR0);

logERPTrialR1=logERPTrial(trialAssign==1);
logERPTrialR0=logERPTrial(trialAssign==0);

sumLogERPR1=calCellSum(logERPTrialR1);
sumLogERPR0=calCellSum(logERPTrialR0);

sumLogERDR1=calcLogERD(sumLogERPR1,5000,overlap);
sumLogERDR0=calcLogERD(sumLogERPR0,5000,overlap);

logERDTrialR1=logERDTrial(trialAssign==1);
logERDTrialR0=logERDTrial(trialAssign==0);
sumLogERDR1=calCellSum(logERDTrialR1);
sumLogERDR0=calCellSum(logERDTrialR0);
tfLogMap(sumLogERDR1,tgtChan);
tfLogMap(sumLogERDR0,find(goodChan==104));
caxis([-1 1])
% topoLogERD(sumLogERDR1,[7 13],5,1000,tgtChan,goodChan,overlap);
% topoLogERD(sumLogERDR0,[7 13],5,1000,tgtChan,goodChan,overlap);
% %%
% caxis([0 5])
% 
% a=calcLogERD(log(calcERP(sumDataTrialR1,1000,0.9)),5000,0.9);
% tfLogMap(a,tgtChan);
% 
% sumDataTrial=calCellSum(dataTrial);