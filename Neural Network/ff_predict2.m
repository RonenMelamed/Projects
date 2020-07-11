function [p, detectp] = ff_predict2(Theta1, Theta2, Theta3,X,y)
%ff_predict2 employs forward propagation on a 4 layer networks and
% determine the labels of  the inputs 
% Input arguments
%   Theta1 - matrix of parameters (weights)  between the input and the first hidden layer
%   Theta2 - matrix of parameters (weights)  between the hidden layer and the second hidden layer (or
%   Theta3 - matrix of parameters (weights)  between the hidden layer and the output layer (or

%   another hidden layer)
%   X - input matrix
%   y - the input labels
% Output arguments:
%   p - the predicted labels of the inputs
% Usage: p = forward_propagation(Theta1, Theta2, X)
%

% Initializations
m = size(X, 1);
num_labels = size(Theta2, 1);

p = zeros(size(X, 1), 1);

        X1=[ones(size(X,1),1) X];
        z2=X1*Theta1';
        a2=sigmoid(z2);
        a2=[ones(size(a2,1),1) a2];
        z3=a2*Theta2';
        a3=sigmoid(z3);
        a3=[ones(size(a3,1),1) a3];
        z4=a3*Theta3';
        a4=sigmoid(z4);


[k,p]=max(a4');
p=p';
detectp=(sum(p == y)/m * 100);







