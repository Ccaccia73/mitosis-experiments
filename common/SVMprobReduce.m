function [ labels, probabilities ] = SVMprobReduce( input_labels, input_probs )
%SVMprobReduce reduces the probabilities ox extended probability SVM in probabilities
% for samples
%   INPUT:
%	- input_labels: labels for extended samples
%	- input_probs: probabilities for extended samples
%
%	OUTPUT:
%	- labels: labels for samples (1/8 of extended samples)
%	- probabilities: final probabilities (mean of 8 probabilities)

if mod(length(input_labels),8) ~= 0
	disp('Labels size not multiple of 8')
	return
end


nclass = length(input_labels) / 8;
probabilities = zeros(nclass,2);

for j1 = 1:nclass
	probabilities(j1,1) = mean(input_probs(8*(j1 - 1) + 1:8*j1));
	probabilities(j1,2) = 1 - probabilities(j1,1);
end

labels = ones(nclass,1);

labels(probabilities(:,1) < 0.5) = -1;

end
