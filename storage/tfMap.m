function tfMap(ERD,chan)
[timescale,freqscale,chanNum]=size(ERD);
freq = 0:(freqscale-1);
time = (0:timescale-1)/10;
figure;
ERDchan(:,:) = ERD(:,:,chan);
imagesc(time,freq,ERDchan');

caxis([-1 1]);    
axis xy
colormap('jet')
colorbar
ylim([0 50]);
xlim([0 (timescale-1)/10]);
xlabel('Time [s]','FontSize',20)
ylabel('Frequency [Hz]','FontSize',20)
end