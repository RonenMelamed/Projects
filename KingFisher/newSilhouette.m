function [resMat] = newSilhouette(data,aff,K,str,vect)
%This function gets data points, clustering affiliations and number of
%centeroids, and returns silhouette values for given affiliations.

%Input:
%       'data' is data points.
%       'vect' is datapoints's affiliation after kind of clustering
%       'numCenters' is number of centeroids.
%Output:
%       'resMat' is the result matrix. each row 'i' contains silhouette values for
%       centeroid number 'i'.
%       the flag '-2' was chosen for internal use
%Usage: 
%       load fisheriris
%       spec2=[ones(1,50) ones(1,50)+1 ones(1,50)+2]'
%       result=newSilhouette(meas(:,3:4),spec2,3);
if nargin<5, vect = aff; end                         %if comparison to original affiliation is not necessary
myColors = mycolorset(K,1);
numPoints=size(data,1);                                 %number of data points
bCentersD=zeros(K,1);                          %container for calculating total distance from point to clusters points
resMat=zeros(K,numPoints,4)-Inf;

endingVec=ones(K,1);
in=1:K;                                   %index vector for centers iteratios
    
pointsForCenter=getPointesPerCenter(aff,K);  %calculate number of data points each center owns

    for j=1:numPoints                                   %for each data point calculate si
        ai=0;
        bCentersD(:,:)=0;                               %reset bCenters
        for k=1:numPoints 
            
            if k~=j                                     %exclude vec with himself
              
                if aff(j)==aff(k)                        %if both points in same cluster
                    ai=ai+norm(data(j,:) - data(k,:));   %sum the distance 
                else
                    bCentersD(aff(k))= bCentersD(aff(k)) + norm(data(j,:) - data(k,:)); 
                end  
                
            end
        end  
        bCentersD(in)=bCentersD(in)./pointsForCenter(in);   %extract mean from distances summations
        bi=min(bCentersD(bCentersD>0));                     %closest center's mean distance
        ai=ai/pointsForCenter(aff(j));                      %ai mean
        si=(bi-ai) / max(bi,ai);                            %si value   
        currVect=endingVec(aff(j));                         %current centeroid number
        resMat(aff(j),currVect,1)=si;                       %insert new silhouette value for current centroid
        resMat(aff(j),currVect,2:end)=myColors(vect(j),:);  
        endingVec(aff(j))=currVect+1;                      %increase centeroid value count
        
    end                                                     
    plotSilhouetteData(resMat,str);                         %plot data
end

