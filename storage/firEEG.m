function out=firEEG(in)
% a = designfilt('bandpassfir', 'StopbandFrequency1', 2.5, 'PassbandFrequency1', 3, 'PassbandFrequency2', 49, 'StopbandFrequency2', 49.5, 'StopbandAttenuation1', 6, 'PassbandRipple', 1, 'StopbandAttenuation2', 6, 'SampleRate', 1000, 'DesignMethod', 'kaiserwin');
% b = designfilt('bandstopfir', 'PassbandFrequency1', 48.5, 'StopbandFrequency1', 49, 'StopbandFrequency2', 51, 'PassbandFrequency2', 51.5, 'PassbandRipple1', 1, 'StopbandAttenuation', 6, 'PassbandRipple2', 1, 'SampleRate', 1000, 'DesignMethod', 'kaiserwin');
% 
% stopBand         = [49 51];
% [stopB,stopA]    = butter(3,stopBand/(1000/2),'stop');
sampleRate = 1000;
passBand         = [7 30];
[B,A]            = fir1(400,passBand/(sampleRate/2));
stopBand1        = [49 51];
[stopB1,stopA1]  = butter(3,stopBand1/(sampleRate/2),'stop');
stopBand2        = [99 101];
[stopB2,stopA2]  = butter(3,stopBand2/(sampleRate/2),'stop');
[HB,HA]          =butter(3,3/(sampleRate/2),'high');
d = mean(grpdelay(B,A));
temp = filter(HB,HA,in');
temp = filter(stopB1,stopA1,temp);
temp = filter(stopB2,stopA2,temp);
temp = filter(B,A,[temp;ones(d,1)*temp(end,:)]);
temp(1:d,:)=[];
% tic
% temp = filtfilt(stopB,stopA,temp);
% toc


out = temp';



end