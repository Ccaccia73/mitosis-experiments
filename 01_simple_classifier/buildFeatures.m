load '../globalDataSet.mat'

train_features = [];
train_class = [];
eval_features = [];
eval_class = [];

for k1=1:length(globalDataSet)
	
	actfeatures = [mean(globalDataSet(k1).data(:)) std(globalDataSet(k1).data(:))];
	actclass = globalDataSet(k1).class;
	
	if globalDataSet(k1).train
		train_features = vertcat(train_features,actfeatures);
		train_class = vertcat(train_class,actclass);
	else
		eval_features = vertcat(eval_features,actfeatures);
		eval_class = vertcat(eval_class,actclass);
	end
	
end


% normalization

[train_features_norm, m_t, std_t] = normalizeF(train_features);
eval_features_norm = normalizeF(eval_features, m_t, std_t);

save('simpleFeatures.mat','train_features','train_features_norm','train_class','eval_features','eval_features_norm','eval_class');

% 
% rng('default');
% 
% idx = randperm(length(train_class));
% 
% trainsize = [10 20 50 100 200 length(train_class)];
% 
% for k1=1:length(trainsize)
% 	
% 	disp([num2str(trainsize(k1)),' random samples']);
% 	
% 	
% 	svmStruct = svmtrain(train_features(idx(1:trainsize(k1)),:),train_class(idx(1:trainsize(k1))),'showplot',true);
% 	
% 	C = svmclassify(svmStruct,eval_features,'showplot',true);
% 	disp ' ';
% 	errRate = sum(eval_class ~= C)/length(eval_class);  %mis-classification rate
% 	disp ' ';
% 	disp(['Error rate: ',num2str(errRate)]);
% 	[conMat,order] = confusionmat(eval_class,C,'order',[1 0]); % the confusion matrix
% 	disp ' ';
% 	disp('Confusion Matrix')
% 	disp(['tp: ',num2str(conMat(1,1)),'  fn: ',num2str(conMat(1,2))])
% 	disp(['fp: ',num2str(conMat(2,1)),'  tn: ',num2str(conMat(2,2))])
% 	disp ' ';
% 	disp ' ';
% 	
% 	
% 
% end