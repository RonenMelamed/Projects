function [gaussian] = Gaussian2D(plain_dim , mu , sigma , drow, alpha)
%Usage: neigh2 = Gaussian2D([0 Z;0 Z], [bmucor(1) bmucor(2)] , [sigma 0; 0 sigma] , 1, alpha);

x1 = plain_dim(1)+1 : plain_dim(3);
x2 = plain_dim(2)+1: plain_dim(4);
[X2,X1] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
y = mvnpdf(X,mu,sigma);
gaussian = reshape(y,length(x2),length(x1));
gaussian = gaussian/max(max(gaussian));
gaussian = gaussian*alpha;
if drow == 1
    figure(1)
    imagesc(gaussian)
    title(sprintf("%.2f",norm(gaussian)))
%     caxis([min(y(:))-0.5*range(y(:)),max(y(:))])
%     xlabel('x1')
%     ylabel('x2')
%     zlabel('Probability Density')
end
end

