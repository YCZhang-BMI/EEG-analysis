function ERP=calcERP(data,samplingRate,overlap)
[chan,time]=size(data);
data=data';
window=samplingRate;
h=hamming(window)';
timescale=1:window*(1-overlap):time-window+1;
timescale=uint32(timescale)';
timescale=timescale+uint32(1:window)-1;

timescale=timescale+reshape(uint32(((1:chan)-1)*time),1,1,[]);
ERP=zeros(chan,length(timescale),window/2+1);
% % for i=1:chan
%     for j=1:length(timescale)
%         x=fft(data(:,timescale(j):timescale(j)+window-1).*h,[],2);
%         x=x(:,1:window/2+1);
%         p= (1/(window*window)) * abs(x).^2;
%         p(2:end-1)=2*p(2:end-1);
%         ERP(:,j,:)=p;
%         clear x p;
%     end
%         
% end
temp=data(timescale).*h;
temp=fft(temp,[],2);
temp=temp(:,1:window/2+1,:);
temp= (1/(window*window)) * abs(temp).^2;
temp(:,2:end-1,:)=2*temp(:,2:end-1,:);

ERP=temp;



end