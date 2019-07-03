function dataTrial=matClassTrialExtract(EEG,tr)
sr=EEG.sampleRate;
time=tr(1)*sr+1:tr(2)*sr;
load CSPgoodChan
dataTrial=cell(max(EEG.trialAssign)+1,1);
for i = 1:length(EEG.task)
    dataTrial{EEG.trialAssign(i)+1}=cat(3,dataTrial{EEG.trialAssign(i)+1},EEG.dataf(time+EEG.task(i),goodChan));
end
x=cellfun('isempty',dataTrial);
dataTrial(x)=[];


end