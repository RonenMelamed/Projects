function [r] = Rand_index(cluster1,cluster2)
%RAND_INDEX Summary of this function goes here
%   Detailed explanation goes here
length=size(cluster1,1);
a=0; b=0; c=0; d=0;
for i=1:length-1
        for j=i:length
            if (cluster1(i)==cluster1(j) && cluster2(i)==cluster2(j))
                 a=a+1;
            elseif cluster1(i)~=cluster1(j) && cluster2(i)~=cluster2(j)
                b=b+1;
            elseif cluster1(i)==cluster1(j) && cluster2(i)~=cluster2(j)
                c=c+1;
            elseif cluster1(i)~=cluster1(j) && cluster2(i)==cluster2(j)
                d=d+1;
             end
        end      
end

r=(a+b)/(a+b+c+d);
end

