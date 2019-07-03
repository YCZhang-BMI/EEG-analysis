for i = 1:3
    P{i}=(var(dataClass{i},1));
end
for i = 1:2
ERD{i}=P{i+1}-P{1};
end

%%
p=cell(3,1);
for i=1:3
    freq=0:1000/size(dataClass{i},1):500;
temp=((1/(1000*size(dataClass{i},1)))*abs(fft(dataClass{i},[],1))).^2;
% temp=log(temp);
for j = 1:50
p{i}(j,:)=sum(temp((freq>=j-1)&freq<j,:),1);
end
end
f=(0:40)+1;
for i = 1:2
ERD{i}=sum(p{i+1}(f,:),1)-sum(p{1}(f,:),1);
end

%%
temp=ERD{2};
a=max(abs(temp));
figure;
topography(temp,loc(goodChan,:),3,0,0)
caxis([-a a])
[~,ind]=min(temp);
goodChan(ind)
temp=vertcat(dataClass{:});
% figure;
% plot(temp(:,ind))

%%
close all
plot(p{1, 1}(:,1))
hold on
plot(p{2, 1}(:,1))
plot(p{3, 1}(:,1))