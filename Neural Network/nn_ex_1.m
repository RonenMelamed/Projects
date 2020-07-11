% nn learning
% This script demonstrate nn learning using backpropagation algorithm
% (using batch learning) on various data sets
%


clear ; clc

% Loading the data                    
load processed.mat
vect = vect(:);
% Initalization of the parameters 
[Xtrain, ytrain, Xtest, ytest] = createDataSet(dataNewLog, vect , 0.7);

m = size(Xtrain, 1); % number of training examples
InputLayerSize  = size(Xtrain,2);  % 
HiddenLayerSize = 30;   %  hidden units
numLabels = 9;          % 10 labels for 10 digits, the label '10' is for digit 0.

% digitdemo % visualizing the data
% pause

% loading the (predefined) parameters
%load('myTheta.mat');

%p = ff_predict(Theta1, Theta2, X);

%fprintf('\n Training Set Accuracy: %f\n', sum(p == y)/m * 100);
%pause

% training the network using backpropagation algorithm
%
Theta1 = InitializeParam(InputLayerSize, HiddenLayerSize);
Theta2= InitializeParam(HiddenLayerSize, numLabels);
%load myTheta
%p = ff_predict(Theta1, Theta2, X);
%fprintf('\nTraining Set Accuracy: %f \n', sum(p == y)/m * 100);
max_iter=100000;
alpha=0.2;
Lambda=1;
%bp(Theta1, Theta2, X,y,max_iter, alpha,Lambda,Xtest,ytest)
[J, Theta1,Theta2] = bp1(Theta1, Theta2, Xtrain,ytrain,max_iter,alpha, Lambda,Xtest,ytest);

% Performance of the trained nn on training set:
p = ff_predict(Theta1, Theta2, Xtest,ytest);
fprintf('\n Trained net performance on training set: %f \n', sum(p == ytest)/m * 100);

% Performance of the trained nn on training set:
p = ff_predict(Theta1, Theta2, Xtest,ytest);
fprintf('\n Trained net performance on training set: %f \n', sum(p == ytest)/m * 100);

                          
                          