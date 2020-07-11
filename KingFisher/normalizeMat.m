function [mat] = normalizeMat(mat)

for i=1:size(mat,2)                              
    minC=min(mat(:,i));
    maxC=max(mat(:,i));
    mat(:,i)=(mat(:,i)-minC)/(maxC-minC);
end

end

