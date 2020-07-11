clear
load fisheriris; 
%KMedoids - gets data,number of clusters and max iterations.
X = meas(:,3:4);
[aff,centers,centerInd]=newKMedoid(X,3,10000);
plot2DKMedoids(X,aff,centers)
 
%Silhouette - gets data,affiliations and number of clusters
spec2=[ones(1,50) ones(1,50)+1 ones(1,50)+2]';
result=newSilhouette(meas(:,3:4),spec2,3);
