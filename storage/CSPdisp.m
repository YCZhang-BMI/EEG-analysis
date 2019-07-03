function CSPdisp(CSP)
% if fl
% CSP = pinv(CSP)';
% end
ChannelLocation;
load CSPgoodChan goodChan;
figure;
for i = 1:6
    subplot(2,3,i)
    topography(CSP(:,i),loc(goodChan,:),3);
    axis equal
    m=max([CSP(:,i);-CSP(:,i)]);
    caxis([-m m])
    
%     caxis([-1 1])
end

end