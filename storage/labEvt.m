function event=labEvt(EEG)
event=struct('type',{},'latency',{});
for i = 1:length(EEG.rest)
    temp(i).type='start';
    temp(i).latency=EEG.rest(i);
end
event=[event temp];
clear temp
for i = 1:length(EEG.task)
    switch EEG.trialAssign(i)
        case 0
              temp(i).type='rest';
        case 1
            temp(i).type='left';
        case 2
            temp(i).type='right';
    end
    
    temp(i).latency=EEG.task(i);
end
event=[event temp];
clear temp
for i = 1:length(EEG.break)
    temp(i).type='break';
    temp(i).latency=EEG.break(i);
end
event=[event temp];
[~,ind]=sort([event.latency]);
event=event(ind);
while event(end).latency>=size(EEG.data,1)
    event(end)=[];
end
    
    
end