function [filter,classifier]=CSPBuild1(data1,data2,wn,pl)
% datalength=min(length(data1),length(data2));
% data1=data1(1:datalength,:);
% data2=data2(1:datalength,:);
cov1=(data1'*data1)/trace(data1'*data1);
cov2=(data2'*data2)/trace(data2'*data2);

[p,d]=eig(cov1+cov2);
[d,i]=sort(diag(d),'descend');
p=p(:,i);
w=sqrt(inv(diag(d)))*p';
cov1=w*cov1*w';
cov2=w*cov2*w';



[V,D]=eig(cov1,cov2);
[D,ind]=sort(diag(D),'descend'); %#ok<*ASGLU>
% [D,ind]=sort(diag(D)); %#ok<*ASGLU>
V=V(:,ind);
V=V'*w;
for i=1:length(ind), V(i,:)=V(i,:)./norm(V(i,:)); end
V=V';
CSP = [V(:,1:3) V(:,end-2:end)];
input1 = squeeze(log(var(reshape(data1*CSP,wn,[],6))));
input2 = squeeze(log(var(reshape(data2*CSP,wn,[],6))));
input = [input1;input2];
d1=length(input1);
d2=length(input2);
if pl
    CSPdisp(CSP,1);
    figure;
    gscatter(input(:,2),input(:,5),[ones(1,d1) -1*ones(1,d2)])
end
classifier = fitcdiscr(input,[ones(1,d1) -1*ones(1,d2)]);
filter=CSP;



end