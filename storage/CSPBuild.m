function [filter,classifier,PT]=CSPBuild(data1,data2,wn,pl)
% datalength=min(length(data1),length(data2));
% data1=data1(1:datalength,:);
% data2=data2(1:datalength,:);

% a=robustcov(data1,'OutlierFraction',0.2);
% b=robustcov(data2,'OutlierFraction',0.2);
% [V,D]=eig(a,a+b);


[V,D]=eig(cov(data1),cov(data1)+cov(data2));
[D,ind]=sort(diag(D),'descend'); %#ok<*ASGLU>
V=V(:,ind);
P=inv(V);
PT=P([1:3 end-2:end],:)';
CSP = [V(:,1:3) V(:,end-2:end)];
% CSP = V(:,1:6);
input1 = squeeze(log(var(reshape(data1*CSP,wn,[],6))));
input2 = squeeze(log(var(reshape(data2*CSP,wn,[],6))));
input = [input1;input2];
d1=length(input1);
d2=length(input2);
if pl
    CSPdisp(PT);
    figure;
    gscatter(input(:,2),input(:,5),[ones(1,d1) -1*ones(1,d2)])
end
classifier = fitcdiscr(input,[ones(1,d1) -1*ones(1,d2)]);
filter=CSP;


end