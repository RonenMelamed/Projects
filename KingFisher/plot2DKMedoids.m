function [] = plot2DKMedoids(data,aff,centers)
%This function plots 2D clustering.
%Input: 'data' - data set
%       'aff' - affiliation vec.
%       'centers'  - medoids points.

for i=1:size(centers,1)
   d1=data(aff==i,:);
   plot(d1(:,1),d1(:,2),'*');
   hold on
end
plot(centers(:,1),centers(:,2),'d','MarkerSize',10,'MarkerEdgeColor','w')
set(gca,'Color','k')
title('Clustering result');
end

