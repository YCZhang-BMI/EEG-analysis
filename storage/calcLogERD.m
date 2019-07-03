function ERD=calcLogERD(ERP,rest,overlap)
[chan,timescale,freqscale]=size(ERP); %#ok<*ASGLU>
restfixed = int32((rest-1000)/(1000*(1-overlap)));
% ref=zeros(51,1);
ERD = zeros(chan,timescale,51);
for i = 1:chan
    for j = 1:51
        ref=mean(ERP(i,int32(1/(1-overlap)):restfixed,j));
        stdref = std(ERP(i,10:restfixed,j));
        ERD(i,:,j) = (ref-ERP(i,:,j))./stdref;
    end
end
% for i=1:51
%     ref(i)=mean(ERP(chan,10:restfixed,i));
%     for j=1:timescale
%         ERD(i,j)=1-ERP(chan,j,i)/ref(i);
%     end
% end

% freq = 0:50;
% time = (0:timescale-1)/10;
% figure;
% imagesc(time,freq,ERD);
% 
% caxis([-1 1]);    
% axis xy
% colormap('jet')
% colorbar
% ylim([0 50]);
% xlim([0 (timescale-1)/10]);
% xlabel('Time [s]','FontSize',20)
% ylabel('Frequency [Hz]','FontSize',20)

end