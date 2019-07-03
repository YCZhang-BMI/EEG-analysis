function dataTrial=trialExtract(EEG,evt_255_DINs)
j=1;
for i=1:length(evt_255_DINs)
    if strcmp('DIN3',evt_255_DINs{1,i})
        dataTrial{j}=EEG(:,evt_255_DINs{2,i}-8999:evt_255_DINs{2,i}+9000);
        j=j+1;
    end
end

end