function overlaps = combineSegs(seg1, seg2)
%OVERLAPMARKER 

    overlaps = seg1 + seg2;
    val=intersect(find(seg1 ~=0),find(seg2~=0));
    overlaps(val) = 10;

end

