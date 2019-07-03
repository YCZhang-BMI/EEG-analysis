function EEG=matscaling(EEG)
a=vertcat(EEG{:});
a=std(EEG{1},1);
for i = 1:length(EEG)
    EEG{i}=EEG{i}./a;
end
end