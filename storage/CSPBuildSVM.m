function [filter,classifier]=CSPBuildSVM(data1,data2,wn,pl)
% datalength=min(length(data1),length(data2));
% data1=data1(1:datalength,:);
% data2=data2(1:datalength,:);
[V,D]=eig(cov(data1),cov(data1)+cov(data2));
[D,ind]=sort(diag(D),'descend'); %#ok<*ASGLU>
V=V(:,ind);
% CSP = [V(:,1:4) V(:,end-1:end)];
CSP = V(:,1:6);
input1 = squeeze(log(var(reshape(data1*CSP,wn,[],6))));
input2 = squeeze(log(var(reshape(data2*CSP,wn,[],6))));
input = [input1;input2];
d1=length(input1);
d2=length(input2);
if pl
    CSPdisp(CSP);
    figure;
    gscatter(input(:,1),input(:,6),[ones(1,d1) -1*ones(1,d2)])
end
classifier = fitcsvm(input,[ones(1,d1) -1*ones(1,d2)]);
filter=CSP;



end