function [y] = mycolorset(N,mode);
% mycolorset is a function to set a pre-defined number of different colors.
% Input arguments: 

if mode==1
    y=[0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 1 1 0; ...
        0 0.4470 0.7410; 0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250;...
        0.4940 0.1840 0.5560;0.4660 0.6740 0.1880; 0.3010 0.7450 0.9330;...
        0.6350 0.0780 0.1840; 1 1 1; 0 0 0];
    y=y(1:N,:);
else

y= {'#F00','#F80','#FF0','#0B0','#00F','#50F','#A0F','#000000','#FFFFFF',...
    '#D95319','#EDB120','#7E2F8E','#77AC30','#4DBEEE','#A2142F'};
end


% if mode~=1
% hold on
% for r=1:15
%     t = linspace(0,r,500);
%     x = sqrt(r.^2-t.^2);
%     plot(t,x,'Color',y{r},'LineWidth',10)
% end
% else
% hold on
% for r=1:15
%     t = linspace(0,r,500);
%     x = sqrt(r.^2-t.^2);
%     plot(t,x,'Color',y(r,:),'LineWidth',10)
% end
% 
% end

       


end

