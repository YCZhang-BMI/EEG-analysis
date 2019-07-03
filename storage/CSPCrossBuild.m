function [CSP,LDA,PT]=CSPCrossBuild(dataClass,wn,pl)
n=length(dataClass);
k=1;
for i=1:n
    for j=i+1:n
        [a,b,c]=CSPBuild(dataClass{i},dataClass{j},wn,pl);
        CSP{k}=a;
        LDA{k}=b;
        PT{k}=c;
        k=k+1;
    end
    
    
end
end