function [probs] = getProbs(y)
uy=unique(y);
len=length(uy);
probs = zeros(1,len);
for i = 1:len
    probs(i) = sum(y==uy(i))/length(y);
end
end

