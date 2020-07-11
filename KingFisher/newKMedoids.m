function [affs,centers,centerInd] = newKMedoids(data,centNum,maxIter)
%this function create KMedoids model for given dataset.

%Input: 'data' - data matrix
%       'centers' - number of desired centers
%       'maxIter' - maximus number of iterations

%Output:'aff' - affiliation vector
%       'centers' - centers data points
%       'centerInd' - number of points per center
%Usage:
%       load fisheriris; X = meas(:,3:4);[aff,centers,centerInd]=newKMedoid2(X,3,1000);plot2DKMedoids(X,aff,centers)
%       


dim=size(data);
cents=randi(dim(1),1,centNum);
centers=data(cents,:);          %centers/medoids matrix
iter=1;                         %iter index
centerAff=inf(centNum,dim(1));  %hold index affiliation for each medoid

global DISTMAT
DISTMAT=pdist2(data,data,'euclidean');

while iter<maxIter
    
    centerInd=ones(centNum,1);
    changeFlags=zeros(1,centNum);   
    [centerAff,centerInd,affs]=fillCentDataAff(data,centers,centerAff,centerInd,cents);
    [changeFlags,centers,cents]=cal_changes(data,centers,centerAff,centerInd,changeFlags,cents);
    
    if sum(changeFlags)==0
        break;
    end
    
    centerAff=centerAff+inf;         %reset affiliations 
    iter=iter+1;
end
clear global variable
end

