function ERD=calcLog4DERD(ERP,rest,sr,overlap)
[timescale,freqscale,chan,trial]=size(ERP); %#ok<*ASGLU>
restfixed = uint32((rest-1)*sr*(1-overlap));
% ref=zeros(51,1);
ref=mean(ERP(uint32(1*sr*(1-overlap)):restfixed,:,:,:),1);
stdref=std(ERP(uint32(1*sr*(1-overlap)):restfixed,:,:,:),1);
ERD=(ERP-ref)./stdref;
ERD=permute(ERD,[3 1 2 4]);
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