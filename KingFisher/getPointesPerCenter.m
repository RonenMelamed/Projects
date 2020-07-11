function [pointsForCenter] = getPointesPerCenter(vect,numCenters)
%This function recieves affiliation vector and number of centers,
%and outputs in number of affiliated points each  center has.
%Input: 
%       'vect' - affiliations vector.
%       'numCenters' - number of centers.
%Output:
%       'pointsForCenter' - the i'th element is the number of data points the i'th
%       center owns.
%Usage: 
%       getPointesPerCenter(vect,numCenters)

pointsForCenter=zeros(numCenters,1);
for i=1:length(vect)    
    pointsForCenter(vect(i))=pointsForCenter(vect(i))+1; 
end

end

