function [centerAff,centerInd,affs] = fillCentDataAff(data,centers,centerAff,centerInd,cents)
%this function set affiliations for each point in data to 
%it's closest centroid.
%
%Input: 'data' - data points by rows
%       'centers' - center points
%        centerAff - 'for row i each col j is index of point from 'data'
%        which the i centroid is closest to it.
%       'centerInd' - center index for each centroid
%
%Output:'cenerAff' - updated version of input.
%       'centerInd' - center index for each centroid.
%       'affs' -  vector of affiliations in relation to each point from 'data'

dim=size(data);
affs=zeros(dim(1),1);    
global DISTMAT
for i=1:dim(1)
    %currNorms=vecnorm((data(i,:)-centers),2,2);
    currNorms=DISTMAT(i,cents)';
    currNorms(currNorms==0)=Inf;
    [~,minIc]=min(currNorms);
    centerAff(minIc,centerInd(minIc))=i;
    centerInd(minIc)=centerInd(minIc)+1;
    affs(i)=minIc;
end

end

