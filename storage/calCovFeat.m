function covFeat=calCovFeat(dataTrial,overlap)

[chan,time]=size(dataTrial);
window=1000;
tp=1:window*(1-overlap):time-window;
tp=int16(tp);
covFeat=zeros(length(tp),chan*(chan+1)/2);

ei=tril(ones(chan));
ei=logical(ei(:));

for i = 1:length(tp)
d=dataTrial(:,tp(i):tp(i)+window-1)';
d=d'*d/window;
d=d(ei)';
covFeat(i,:)=d;
end