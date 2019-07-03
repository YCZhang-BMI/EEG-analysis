function dataClass=extractClassData(EEG,percentage,tc,goodChan)
% load CSPgoodChan
% ChannelLocation;
dataClass=cell(3,1);
time=[2 5]*EEG.sampleRate;
switch tc
    case 1

        for j = 1:fix(percentage*length(EEG.task))
            
            for i =0:2
                if EEG.trialAssign(j) ==i
                    dataClass{i+1} = [dataClass{i+1} ; EEG.dataf(EEG.task(j)+time(1)+1:EEG.task(j)+time(2),goodChan)]; %#ok<*AGROW>
                end
            end
            
        end
    case 2
        
        for j = 1:fix(percentage*length(EEG.task))
            dataClass{1}=[dataClass{1} ; EEG.dataf(EEG.task(j)+time(1)+1-5*EEG.sampleRate:EEG.task(j)+time(2)-5*EEG.sampleRate,goodChan)];
            for i =1:2
                if EEG.trialAssign(j) ==i
                    dataClass{i+1} = [dataClass{i+1} ; EEG.dataf(EEG.task(j)+time(1)+1:EEG.task(j)+time(2),goodChan)]; %#ok<*AGROW>
                end
            end
            
        end
end
end