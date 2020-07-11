function [] = plotSilhouetteData(mat,str)
%This function plot the silhouette values for a given matrix
%Input: matrix: rows - silhouette values
%               cols - centeroid number
%Note:the number '-2' is a flag for us to recognize legal data points
%Usage: plotSilhouetteData(mat)

if nargin<2, str=' clustering'; end  
dim=size(mat);
c = 1;
for k=1:dim(1)
    j=1;
    %v = mat(k,mat(k,:,1)>-1,:);
    %cols = v(1,:,2:end);
    %cols = reshape(cols,size(cols,3),size(cols,2));
    
    while(mat(k,j,1)>-1)
        v(j,:) = mat(k,j,1:end);
        j=j+1;
    end 
    v = sortrows(v);
    for i=1:j-1
        stem(c,v(i,1),'color',v(i,2:end),'LineWidth',2,'MarkerSize',1.7);
        hold on
        c=c+1; 
    end
    stem(c,0.4,'color',[0 0 0],'LineWidth',2.4,'MarkerSize',0.9);
    c=c+1;
end



% for k=1:dim(1)
%    v=mat(k,:);
%    v=v(v>=-1);
%    x2=x2+length(v);
%    xx=(x1:1:x2);
%    x1=x2+1;
%    stem(xx,sort(v),'filled','LineWidth',1.5,'MarkerSize',2);
%    hold on
% end
camroll(-90)
text(120, 0.09, strcat(str,' new Silhouette '), ...
  'VerticalAlignment', 'top', ...
  'HorizontalAlignment', 'center','FontWeight','Bold','FontSize',14);
end

