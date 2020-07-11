function [] = plotClustering(data,vect,kmeansVec,medoidVec,str,K)
%this function plots silhouettes of clusterings.


%original silhouette
subplot(223)
newSilhouette(data,vect,K,' original');
xlabel('Original new Silhouette','FontWeight','Bold','FontSize',15)
ylim([-1,1])
%silhouette(data,vect); 

%Medoid silhouette
subplot(222)
%silhouette(data,medoidVec); 
newSilhouette(data,medoidVec,K,' Kmedoids',vect);
xlabel('Kmedoiods new Silhouette','FontWeight','Bold','FontSize',15)%medoid silhouette
ylim([-1,1])

%K-means silhouette
subplot(221)
%silhouette(data,kmeansVec); 
newSilhouette(data,kmeansVec,K,' Kmeans',vect);
xlabel('kmeans new silhouette','FontWeight','Bold','FontSize',15)%kmeans silhouette
ylim([-1,1])

text(140, 2.5, str, ...
  'VerticalAlignment', 'top', ...
  'HorizontalAlignment', 'center','FontWeight','Bold','FontSize',15);

end

