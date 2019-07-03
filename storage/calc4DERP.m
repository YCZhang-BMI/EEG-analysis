function ERP=calc4DERP(data,samplingRate,overlap)
[time,chan,trial]=size(data);
window=samplingRate;
h=hamming(window)';
timescale=1:window*(1-overlap):time-window+1;
timescale=uint32(timescale)';
timescale=timescale+uint32(1:window)-1;
timescale=timescale+reshape(uint32(((1:chan)-1)*time),1,1,[]);
ERP=zeros(uint64((time-window)*(1-overlap)+1),window/2+1,chan,trial);
for i =1:trial
    temp=data(:,:,i);
temp=temp(timescale).*h;
temp=fft(temp,[],2);
temp=temp(:,1:window/2+1,:);
temp= (1/(window*window)) * abs(temp).^2;
temp(:,2:end-1,:)=2*temp(:,2:end-1,:);

ERP(:,:,:,i)=temp;
end




end