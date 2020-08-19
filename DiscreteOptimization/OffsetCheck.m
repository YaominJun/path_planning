function offset=OffsetCheck()
%横向偏移成本分析
offset=-5:1:5;
for i=1:length(offset)
    offset(i)=2^(abs(offset(i)))-1;
end
offset=offset/10;