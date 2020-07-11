function [Xtrain, ytrain, Xtest, ytest] = createDataSet(X, y , precentage)

%CREATEDATASET Summary of this function goes here
%   Detailed explanation goes here
% usege [Xtrain, ytrain, Xtest, ytest] = createDataSet(data, lebels , 0.7)
%   X = data
%   y = data labels
% precentage = presentage of data selected to train group

labels = length(unique(y));
    label = y(1);
    j = 1;
    y1 = [y' -1]';
    positions = zeros(labels , 1);
    Xtrain = [];
    ytrain = [];
    Xtest = [];
    ytest = [];
for i = 1:labels
    while(label == y1(j))
        j = j+ 1;
    end
    if y1(j) == -1
        break
    end
    positions(i+1) = j-1;
    label = y1(j);
    fprintf(sprintf("%d \n",j))
end

for i = 1:labels-1
    grid = positions(i)+1: positions(i+1);
    l = length (positions(i)+1: positions(i+1));
    selected = randsample(grid, round(l*precentage));
    unselected = setdiff(grid , selected);
    Xtrain = [ Xtrain ; X(selected, :)];
    Xtest = [ Xtest ; X(unselected, :)];
    ytrain = [ ytrain ; y(selected) ];
    ytest = [ ytest ; y(unselected) ] ;
end

end

