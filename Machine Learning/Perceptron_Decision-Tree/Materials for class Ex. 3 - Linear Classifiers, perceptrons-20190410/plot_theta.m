function [res] = plot_theta(X,y,theta)
%plot decision boundry and data

plot(X(y==1,1),X(y==1,2),'ro')
hold on
plot(X(y==-1,1),X(y==-1,2),'bx')
v=axis;
xmin=v(1);
ymin=-theta(1)/theta(2)*xmin;
xmax=v(2);
ymax=-theta(1)/theta(2)*xmax;
res=[ymin,ymax];
plot([xmin,xmax],[ymin,ymax],'k','LineWidth',4)
set(gca,'Color','g')

end

