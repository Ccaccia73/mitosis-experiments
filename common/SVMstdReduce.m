function [predicted_labels, probabilities] = SVMstdReduce( labels )
%SVMstdReduce reduces the predicted classes of a standard SVM in probabilities
%	INPUT:
%   - labels: predicted labels of SVM (8 for each sample)
%
%	OUTPUT:
%	- labels: labels with threshold 0.5
%	- probabilities: corresponding probability (in eights)

if mod(length(labels),8) ~= 0
	disp('Labels size not multiple of 8')
	return
end

prob0 = (labels == 1);

nclass = length(labels) / 8;
probabilities = zeros(nclass,2);

for j1 = 1:nclass
	probabilities(j1,1) = sum(prob0(8*(j1 - 1) + 1:8*j1))/8;
	probabilities(j1,2) = 1 - probabilities(j1,1);
end

predicted_labels = ones(nclass,1);

predicted_labels(probabilities(:,1) < 0.5) = -1;