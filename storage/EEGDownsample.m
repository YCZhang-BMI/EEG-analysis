function EEG=EEGDownsample(EEG,rate)
k=round(EEG.sampleRate/rate);
EEG.data=EEG.data(1:k:end,:);
EEG.dataf=EEG.dataf(1:k:end,:);
EEG.rest=round(EEG.rest/k);
EEG.task=round(EEG.task/k);
EEG.break=round(EEG.break/k);
EEG.sampleRate=EEG.sampleRate/k;
EEG.sample=round(EEG.sample/k);
end