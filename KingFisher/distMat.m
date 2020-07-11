function [res] = distMat(Z,index)
%This function takes dimentionc Z and 
%and returns  the distance between index to all other as if it is a matrix.

point = [ceil(index / Z), mod(index,Z) ];
if (point(2)==0), point(2) = Z; end
res = zeros(1,Z^2);
for i=1:Z^2
    tmpoint = [ceil(i / Z), mod(i,Z) ];
    if (tmpoint(2)==0), tmpoint(2) = Z; end
    res(i) = pdist2(point,tmpoint);
end

end

