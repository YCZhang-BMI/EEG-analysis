function topoLogERD(ERD,band,rest,window,tgtChan,goodChan,overlap)
[chan,timescale,freqscale]=size(ERD); %#ok<*ASGLU>
bandfixed = band+1;
timefixed = int32(rest/(1-overlap)):int32((rest+3)/(1-overlap));
% ERD=zeros(129,1);
% for i = 1:chan
%     ERD(i)=(mean(mean(ERP(i,timefixed:end,bandfixed(1):bandfixed(2))))./mean(mean(ERP(i,15:timefixed,bandfixed(1):bandfixed(2))))-1);
% end
ERDtopo = mean(mean(ERD(:,timefixed,bandfixed(1):bandfixed(2)),3),2);

ChannelLocation;
figure;
topography(ERDtopo,loc(goodChan,:),3,0,0,tgtChan);

caxis(max(abs(ERDtopo))*[-1 1])
end