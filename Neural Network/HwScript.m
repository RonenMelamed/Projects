clear
clc
%% A1:
load 'face_train.mat'
load 'face_test.mat'
load('1Layer Results.mat')
load('2Layer Results.mat')
ytest(ytest==-1)=2;
fprintf('\n**************************EX5 RESULTS *************************************************************|\n');
fprintf('\nA1: Data is loaded');

%% B1: plot_face function has been made
fprintf('\nB1: plot_face function has been made\n');


%% C12 + D12:
str='C12 + D12: \nwe adjusted the nn parameters with initializeParam function to fit the relevant data.\n we test here combination of different parameters to fine tune our network and get\n the optimal parameters for us to use. we are using cross-validation to  figure it out.\n note: i hve already run this code so this will be in comments forunnecesary \nactivation of this heacy program.\n';

max_iter=1500;
InputLayerSize  = size(Xtrain,2); 
numLabels=2;
alpha = [0.1 1 3];
lambda = [0.1 1 3];
HiddenLayer1=[8 14 20];
HiddenLayer2=[8 14 20];

% training the network using backpropagation algorithm with different
% values -  1 hidden layer
data1Layer=zeros(length(alpha)*length(lambda)*...
     length(HiddenLayer1),7);
 accMax1=0;
 count=1;
 
%{
for i=1:length(alpha)
   for j=1:length(lambda)
      for k=1:length(HiddenLayer1)
          
            Theta1Tmp = InitializeParam( InputLayerSize,HiddenLayer1(k));
            Theta2Tmp = InitializeParam(HiddenLayer1(k),numLabels);
            [JTmp,Theta1Tmp,Theta2Tmp,accTmp] = bpHw(Theta1Tmp, Theta2Tmp, Xtrain,ytrain,max_iter, alpha(i),lambda(j));
            if accTmp>accMax1
                J1=JTmp;
                Theta11=Theta1Tmp;
                Theta21=Theta2Tmp;
                accMax1=accTmp;
                i1=i;
                j1=j;
                k1=k;
            end  
             fprintf(['\n %d from 27 iterations for 1 Layer \n'],count);
             count=count+1;
      end
   end
   end
%}

%% E1 - observing optimal parameters
load('1Layer Results.mat')
fprintf('\n----------------- E1 results -----------------------------------');
fprintf('\nOptimal parameters are : ');
fprintf('\nNumber of neurons in hidden layer 1 : %d',HiddenLayer1(k1));
fprintf('\nAlpha value : %d',alpha(i1));
fprintf('\nlambda value : %d',lambda(j1));
fprintf('it seems that bigger number of neurons improva accuracy. also small lamda rank.\nthe best training results were very close to the testing results'); 
% F1 - observing optimal results

fprintf('\n-----------------  F2  --- results :');
%run result through test using forward propogation
m = size(Xtest, 1);
p1 = ff_predict(Theta11, Theta21, Xtest,ytest);
accMaxOne=sum(p1 == ytest)/m * 100; %we can see that the result is the same as loaded from '1Layer Results.mat'
fprintf(' Network Accuracy for Testing Set - one Layer: %f Precent \n\n', accMaxOne);
%fprintf('\n With optimal parameters: \nalpha=%f  \nlambda=%f \nnnumber of neurons for hidden layer:%f\n\n\n',alpha(i1),lambda(j1),HiddenLayer1(k1)); 




% training the network using backpropagation algorithm with different
% values -  2 hidden layer - again i already run this program so there is
% no need to run again

accMax2=0;
count=1;
data2Layer=zeros(length(alpha)*length(lambda)*...
     length(HiddenLayer1)*length(HiddenLayer2),9);
load 'face_train.mat'
%_________________________
%{
for i=1:length(alpha)
   for j=1:length(lambda)
      for k=1:length(HiddenLayer1)
         for l=1:length(HiddenLayer2)            
            Theta1Tmp = InitializeParam( InputLayerSize , HiddenLayer1(k));
            Theta2Tmp = InitializeParam( HiddenLayer1(k) , HiddenLayer2(l));
            Theta3Tmp = InitializeParam( HiddenLayer2(l),numLabels);
            [JTmp,Theta1Tmp,Theta2Tmp,Theta3Tmp,accTmp] = bpHw2(Theta1Tmp, Theta2Tmp, Theta3Tmp,Xtrain,ytrain,max_iter, alpha(i),lambda(j));
            if accTmp>accMax2
                J2=JTmp;
                Theta12=Theta1Tmp;
                Theta22=Theta2Tmp;
                Theta32=Theta3Tmp;
                accMax2=accTmp;
                i2=i;
                j2=j;
                k2=k;
                l2=l;
            end 
             fprintf(['\n %d from 81 iterations for 2 Layer \n'],count);
             count=count+1;
         end
      end
   end
end
%save the results
%save('1Layer Results','J1','Theta11','Theta21','accMax1','i1','j1','k1');
%save('2Layer Results','J2','Theta12','Theta22','Theta32','accMax2','i2','j2','k2','l2');
%}

%% E2 - observing optimal parameters - 2 Hidden layers
load('2Layer Results.mat')
fprintf('\nnn----------------- E2 results 2 hidden Layers -----------------------------------');
fprintf('\nOptimal parameters are: ');
fprintf('\nNumber of neurons in hidden layer 1: %d',HiddenLayer1(k1));
fprintf('\nNumber of neurons in hidden layer 2: %d',HiddenLayer2(l2));
fprintf('\nAlpha value: %d',alpha(i1));
fprintf('\nlambda value: %d',lambda(j1));
% F2 - observing optimal results - 2 Hidden layers

fprintf('\n----------------- F2 --- results :');
%run result through test using forward propogation
p2 = ff_predict2(Theta12, Theta22,Theta32, Xtest,ytest);
accMaxTwo=sum(p2 == ytest)/m * 100;
fprintf(' Network Accuracy for Testing Set - two Layers : %f Precent \n', accMaxTwo);
fprintf('it seems that bigger number of neurons improv accuracy. also small lamda rank.\nthe best training results were very close to the testing results. (Similar results with 1 Layer).\n'); 

