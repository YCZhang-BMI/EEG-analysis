function topoERD(ERD,band,rest,window,tgtChan,goodChan)
[chan,timescale,freqscale]=size(ERD); %#ok<*ASGLU>
bandfixed = floor(band*window/1000)+1;
timefixed = rest/100;
% ERD=zeros(129,1);
% for i = 1:chan
%     ERD(i)=(mean(mean(ERP(i,timefixed:end,bandfixed(1):bandfixed(2))))./mean(mean(ERP(i,15:timefixed,bandfixed(1):bandfixed(2))))-1);
% end
ERDtopo = mean(mean(ERD(:,timefixed:end,bandfixed(1):bandfixed(2)),3),2);

ChannelLocation;
figure;
topography(ERDtopo,loc(goodChan,:),3,0,0,tgtChan);
caxis([-0 0.5])
end