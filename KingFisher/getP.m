function [vec] = getP(vec)
f0 = vec(1);
vec(2:length(vec)) = vec(1)+ cumsum(flip(diff(z))); 
end

