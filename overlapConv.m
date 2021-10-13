function segImg = overlapConv(segImg)

for i=1:size(segImg,1)
    for j=1:size(segImg,2)
        for z=1:size(segImg,3)
            if segImg(i,j,z) == -1   % if exists an overlap
                
                patch = segImg(i-4:i+4,j-4:j+4,z-4:z+4);    %extract the 9-by-9-by-9 patch around it
                
                patch(patch==-1) = 0;   %overlaps are excluded from voting
                
                % vote
                labelCount = histcounts(patch);
                
                %assign the most common label
                [~, segImg(i,j,z)] = max(labelCount(2:end)); 
                
        end
    end
end
end

