function [EEG,evt]=NIMatLoad(Dir,sessionCount)
EEG=(load([Dir(sessionCount).folder '/' Dir(sessionCount).name],'*mff'));
% load([matFile(sessionCount).folder '/' matFile(sessionCount).name])
% load(['E:\chou\data\tailBMI/' testeeID '/session' num2str(sessionCount) '.mat'])
% EEG = readmff([mffFile(sessionCount).folder,'\',mffFile(sessionCount).name]);

evt=load([Dir(sessionCount).folder '/' Dir(sessionCount).name],'evt*');

EEG = struct2cell(EEG);
EEG = double(EEG{1});
evt = struct2cell(evt);
evt = evt{1};


end