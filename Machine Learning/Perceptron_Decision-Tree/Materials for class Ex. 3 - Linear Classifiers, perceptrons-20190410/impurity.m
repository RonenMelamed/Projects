function [imp] = impurity(probs)
%% question 5a
in=1:1:length(probs);
imp=-sum(probs(in).*log2(probs(in)));
end