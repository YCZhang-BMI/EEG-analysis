function a=calCellUneSum(Cell)
a=zeros(size(Cell{1}));
for i=length(Cell)
    l=min(size(Cell{i},1),size(a,1));
    a(1:l,:)=a(1:l,:)+Cell{i}(1:l,:);
end
a=a/length(Cell);
end