function [theta,k] = my_perceptron_train(X,y)

len=size(X);
theta=randn(len(2),1);
correct=0;
k=1;
l=1;
while correct<len(1)
   
    a=y(k)*theta'*X(k,:)';
    if a<0
        theta=theta+y(k)*X(k,:)';
        correct=0;
    else
        correct=correct+1;
    end
    k=k+1;
    if k==len(1); k=1 ;end
    l=l+1;
end

%plot_theta(X,y,theta);
end
