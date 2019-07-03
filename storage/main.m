% tic
% ERPTrial=cell(size(dataTrial));
% for i=1:length(dataTrial)
% ERPTrial{i}=calcERP(dataTrial{i},1000,overlap);
% end
% toc
tic
ERPTrial=cellfun(@(x) calcERP(x,1000,overlap),dataTrial,'UniformOutput',false);
toc
tic
logERPTrial=cell(size(ERPTrial));
for i=1:length(ERPTrial)
logERPTrial{i}=log(ERPTrial{i});
end
toc


sumERP=calCellSum(ERPTrial);
sumLogERP=calCellSum(logERPTrial);




ERDTrial=cell(size(ERPTrial));
for i=1:length(ERPTrial)
ERDTrial{i}=calcERD(ERPTrial{i},9000);
end


logERDTrial=cell(size(logERPTrial));
for i=1:length(ERPTrial)
logERDTrial{i}=calcLogERD(logERPTrial{i},9000,overlap);
end
sumLogERD=zeros(size(logERDTrial{1}));
for i=1:length(logERDTrial)
    sumLogERD = sumLogERD+logERDTrial{i};
%     tfMap(ERDTrial{i});
end
sumLogERD = sumLogERD/size(logERDTrial,2);
% sumERD=calcERD(sumERP,5000);
sumLogERD=calcLogERD(sumLogERP,9000,overlap);
% tfMap(sumERD,tgtChan);
% topoERD(sumERD,[9 11],5000,1000,tgtChan,goodChan);

tfLogMap(sumLogERD,tgtChan);
% topoLogERD(sumLogERD,[7 13],5,1000,tgtChan,goodChan,overlap);
% plotERP(ERPTrial{10},129,[8 13],1000);
%  plotERD(sumERD,tgtChan,[8 13],1000);
% % % plot(dataERD(2,2256:2624)/100,-dataERD(1,2256:2624)*0.01);
% tfMap(ERDTrial{10});
% % 
% figure;
% plot(dataTrial{10}(129,:))

