function [res] = plot_face(X,ind,x,y)
%plots the ind'th face from X reshapes the vector according to x,y dimentions 
%into matrix and returnsit in "res"
res=reshape(X(ind,:),x,y);
colormap('gray')
imagesc(res);
end

