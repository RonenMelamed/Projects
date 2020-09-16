function [er] = my_perceptron_test(theta, X_test, y_test)
er=0;
dim=size(X_test);
theta=theta(:);
for i=1:dim(1)
    p=X_test(i,:);
    if p*theta>=0 && y_test(i)==-1
        er=er+1;
    end
    if p*theta<0 && y_test(i)==1
        er=er+1;
    end
end
if er~=0 , er=er/dim(1); end            
end

