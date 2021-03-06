function tfLogMap(ERD,chan)
[chanNum,timescale,freqscale]=size(ERD);
freq = 0:(freqscale-1);
time = (0:timescale-1)/10;
figure;
ERDchan(:,:) = ERD(chan,:,:);
imagesc(time,freq,ERDchan');

caxis([-3 3]);    
axis xy
colormap('jet')
colorbar
ylim([0 50]);
xlim([0 (timescale-1)/10]);
xlabel('Time [s]','FontSize',20)
ylabel('Frequency [Hz]','FontSize',20)
end