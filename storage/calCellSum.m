function sumCell=calCellSum(Cell)
sumCell=zeros(size(Cell{1}));
for i=1:length(Cell)
    sumCell = sumCell+Cell{i};
end
sumCell = sumCell/length(Cell);
end