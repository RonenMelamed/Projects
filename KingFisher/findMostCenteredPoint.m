function [minI] = findMostCenteredPoint(data,centerAff,centerInd)
%This function calculates the most centered point for a set of points.
%Input: 'data' - data points
%       'centerAff' - hold data point indices.
%       'centerInd' - number of points in vec.possibility for certein size
%       of 'inf' tale in this vec, that is why we use 'centerInd'.
%Output: 'point' - the most centerd data point.

global DISTMAT
minSum=Inf;
minI=0;
for i=1:(centerInd-1)
   %currSum=sum(vecnorm((data(centerAff(i),:)-data(centerAff(1:(centerInd-1)),:)),2,2) );
   currSum=sum(DISTMAT(centerAff(i),centerAff(1:(centerInd-1))));
   if currSum<minSum
       minSum=currSum;
       minI=centerAff(i);
   end
end

end

