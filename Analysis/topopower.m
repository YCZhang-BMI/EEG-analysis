figure(156)
for i = 1:3
    p=sessionPower(:,i+1)-sessionPower(:,i);
    
topography(p,loc(goodChan,:),3)
caxis(max(abs(p))*[-1 1])
colorbar
pause(0.5)
end
%%
figure(156)
k=1;
for i = 1:4
    p=sessionPower{k}(:,i)-sessionPower{k}(:,1);
    
topography(p,loc(goodChan,:),3)
caxis([-2.5 2.5])
colorbar
pause(0.5)
end