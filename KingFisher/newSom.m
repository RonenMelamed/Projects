function [] = newSom(data,label,Z,K,alpha0,sigma0,maxIter)
%Self Organizing Map implementation. run for demonstration

if nargin<1
    load fisheriris
    data=meas(:,3:4);
    label=[ones(1,50) ones(1,50)+1 ones(1,50)+2]';
    Z=10;
    alpha0=0.9;
    sigma0=3;
    maxIter = 10000;
    colorset = [1 0 0; 0 1 0; 0 0 1 ];
else
    colorset = mycolorset(K,1); 
end

%Allocate & Initialize
alpha=alpha0;
sigma=sigma0;
board = zeros(Z, Z, 3);
[M,N] = size(data);
theta=randn(N,Z^2)';
figure(1)
for t=1:maxIter
   
        m=randi(M);                         %random point index
        clr = colorset(label(m),:);         %get its color
        vec=data(m,:);                      %current point
        vecDists = pdist2(vec,theta)';              %calc dists between theta and input
        [~,bmui] = min(vecDists,[],1);              %find bmu
        bmucor = [ceil(bmui / Z), mod(bmui,Z) ];    %get bmu coordinates
        if (bmucor(2)==0), bmucor(2) = Z; end
        board(bmucor(1),bmucor(2),:) = clr;         %get input point's class color
        neighborhood = distMat(Z,bmui)';            %get grid distance between neurons
        neighborhood = exp(-(neighborhood.^2)/(2*sigma^2));     %turn distance to neighborood funtion
        figure(1)
        imagesc(vec2mat(neighborhood,Z));
        vecDelta = vec - theta;                                 %difference between input and theta
        theta = theta + ( alpha * neighborhood .* vecDelta );   %update rule 
        alpha = alpha0*exp(-t/5000);                           %decay alpha
        sigma = sigma0*exp(-t/5000);                           %decay sigma
   
        if mod(t,100)==0
          figure(2)
          pause(0.000001)
          image(board)
          ylabel(t);
        end
   
end
end
