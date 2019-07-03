function filter=filterSpawn(EEG)
filter=struct;
filter.sample=0;
filter.num=4;
passBand         = [7 30];
[B,A]            = fir1(400,passBand/(EEG.sampleRate/2));
stopBand1        = [49 51];
[stopB1,stopA1]  = butter(3,stopBand1/(EEG.sampleRate/2),'stop');
stopBand2        = [99 101];
[stopB2,stopA2]  = butter(3,stopBand2/(EEG.sampleRate/2),'stop');
[HB,HA]          =butter(3,1/(EEG.sampleRate/2),'high');
filter.coeff.b={HB,stopB1,stopB2,B};
filter.coeff.a={HA,stopA1,stopA2,A};
filter.z=cell(filter.num,1);
end