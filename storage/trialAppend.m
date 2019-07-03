load CSPgoodChan
tic
for sessionCount = 1:2:length(NIFile)-1
[EEG1,evt]=NIMatLoad(NIFile,sessionCount);
EEG1 = EEG1(goodChan,:);
% EEG1 = lapl(EEG1,36,[7 20 34 46 52 54]);
% EEG1 = filtEEG(EEG1);
% tic
EEG1 = firEEG(EEG1);
% toc
% dataCZ = lapl(EEG1,129,[7 20 34 36 46 52 54]);
% dataCZTrial=trialExtract(dataCZ,evt_255_DINs);
dataTrial{sessionCount}=trialExtract(EEG1,evt);
end
toc
dataTrial=horzcat(dataTrial{:});