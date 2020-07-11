function [changeFlags,centers,cents]= cal_changes(data,centers,centerAff,centerInd,changeFlags,cents)
%This function determines which medoid needs to be replaced if any.
%Input: 
%       'data' - data points
%       'centers' - centers points
%       'centerAff' -for row i each col j is index of point from 'data',
%       affiliated to centeroid i.
%       'centerInd' - center indices for each centroid.
%       'changeFlags' - index i is one when the i'th centeroid had been
%       changed.
%Output:
%       'changeFlags' - index i is one when the i'th centeroid had
%       been changed - updated.
%       'centers' - new centeroid list
%Usage: cal_changes(data,centers,centerAff,centerInd,changeFlags)

    for k=1:size(centers,1)
        
       [currPoint]=findMostCenteredPoint(data,centerAff(k,:),centerInd(k));
       if currPoint~=0
            if (~isequal(data(currPoint,:),centers(k,:)))
                changeFlags(k)=1;
                centers(k,:)=data(currPoint,:);
                ents(k)=currPoint;
            end
       end
       
    end
end

