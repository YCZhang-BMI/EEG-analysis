function [ERPFeat,catERPFeat]=calERPFeat(ERPTrial)
ERPFeat=cell(1,length(ERPTrial));
for trial=1:length(ERPTrial)
    ERPFeat{trial}=zeros(size(ERPTrial{trial},2),size(ERPTrial{trial},1)*24);
    for i = 1:size(ERPTrial{trial},2)
    ERPFeat{trial}(i,:)=reshape(ERPTrial{trial}(:,i,8:31),[],1);
    end
end
catERPFeat=vertcat(ERPFeat{:});
end