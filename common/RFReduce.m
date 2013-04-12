function [ probabilities ] = RFReduce( votes )
%RFReduce reduces votes of Random Forest on extended samples to probabilities
%   INPUT:
%	- votes: classification of each tree
%
%	OUTPUT:
%	- probabilities: resulting probabilities for samples

if mod(length(votes),8) ~= 0
	disp('Labels size not multiple of 8')
	return
end


nclass = length(votes(:,1)) / 8;
probabilities = zeros(nclass,2);

for j1 = 1:nclass
	probabilities(j1,1) = mean(votes(8*(j1 - 1) + 1:8*j1,2))/sum(votes(8*(j1 - 1) + 1,:));
	probabilities(j1,2) = 1 - probabilities(j1,1);
end



end

