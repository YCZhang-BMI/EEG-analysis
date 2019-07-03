function [label,feat]=CSPpredict(dataClass,CSP,LDA,wn)
for i = 1:length(LDA)
k=vertcat(dataClass{:})*CSP{i};
k=reshape(k,wn,[],6);
feat{i}=log(squeeze(var(k,1))); %#ok<*AGROW>
label{i}=predict(LDA{i},feat{i});

end
end