function [ sensitivity, specificity, precision, recall, F1score, error_rate ] = computePerformances( real_label, predicted_label, disp_data )
%COMPUTEPERFORMANCE Computes performances of binary classification
%   Input:
%	- real_label: real classification of data (1, -1)
%	- predicted_label: classification proposed by classifier
%
%	- disp_data: true to show data
%
%	Output:
%	- sensitivity
%	- specificity
%	- precision
%	- recall
%	- F1-score
%	- error rate

tp = length(intersect(find(real_label == 1), find(predicted_label == 1) ));
fp = length(intersect(find(real_label == -1), find(predicted_label == 1) ));
tn = length(intersect(find(real_label == -1), find(predicted_label == -1) ));
fn = length(intersect(find(real_label == 1), find(predicted_label == -1) ));

sensitivity = tp/( tp + fn);
specificity = tn / (tn + tp);

precision = tp/(tp + fp);
recall = tp/(tp + fn);

F1score = 2*precision*recall/(precision + recall);

error_rate = (fp + fn)/(tp + tn + fp + fn);

if disp_data
	disp(['Sensitivity: ',num2str(sensitivity*100),'%'])
	disp(['Specificity: ',num2str(specificity*100),'%'])
	disp(['Precision: ',num2str(precision*100),'%'])
	disp(['Recall: ',num2str(recall*100),'%'])
	disp(['F1-Score: ',num2str(F1score*100),'%'])
	disp(['Error rate: ',num2str(error_rate*100),'%'])
end


end

