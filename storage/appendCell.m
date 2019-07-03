function cell=appendCell(cell1,cell2,k)
for i = 1:length(cell1)
    cell{i}=cat(k,cell1{i},cell2{i});
end
end