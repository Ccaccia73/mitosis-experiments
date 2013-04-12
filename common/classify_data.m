function [ results ] = classify_data( classifiers, parameters, train_features, train_class, eval_features, eval_class, is_extended, show_data, save_data, filename, title_string )
%classify_data classifies data according to defined classifiers
%   Input:
%	- classifiers: string defining type of classifiers to be used
% 		- s: SVM classifier
% 		- p: SVM classifiers with probability
% 		- r: Random Forest
% 		- c: Sparse Coding
% 	
% 	- parameters: struct containing possible parameters for classifiers
% 	
% 	- train_features :  features of the training set
% 	- train_class :		classification of training set
% 	- eval_features :	features of test set
% 	- eval_class :		classification of test set (used for performances)
%	
% 	- is_extended : the evaluation dataset is extended and has to be processed
% 	- show_data : whether to show output data (figures and results)
% 	- save_data : whether to save the data
% 	- filename : name used to save data
%	- title_string : string to be used for plots
%
% 	Output:
% 	matrix containing AUC and max accuracy for each classifier (one column
% 	for each classifier)


results = [];

for j1=1:length(classifiers)
	switch classifiers(j1)
		case 's'
			% SVM standard
			if show_data
				disp('--------------------------')
				disp('Classify with SVM standard')
			end
			
			if isfield(parameters,'SMVstd')
				params = strcat('',parameters.SMVstd);
			else
				params = '';
			end
			
			SVMmodel = libsvmtrain(train_class, train_features,params);
			
			if is_extended
				[SVMstd_ext.predicted_label, SVMstd_ext.accuracy, SVMstd_ext.dec_values] = libsvmpredict(eval_class, eval_features, SVMmodel,'-q');
				
				[SVMstd_ext.predicted_label_samples, SVMstd_ext.prob_estimates ] = SVMstdReduce(SVMstd_ext.predicted_label);
				
				if show_data
					str1 = strcat('SVM-std_',title_string);
					h = figure();
					hold on;
					title(str1,'Interpreter','none')
				end
				
				
				[SVMstd_ext.AUC, SVMstd_ext.AUH, SVMstd_ext.acc0, SVMstd_ext.accM ,SVMstd_ext.thrM, SVMstd_ext.thr, SVMstd_ext.acc, SVMstd_ext.sens, SVMstd_ext.spec, SVMstd_ext.hull] = rocplot(SVMstd_ext.prob_estimates(:,1),eval_class(1:8:end) == 1, show_data);
				
				if show_data
					hold off;
					tmp_dir = strcat('./figures/',strtok(title_string,'-'));
					if ~exist(tmp_dir,'dir')
						mkdir(tmp_dir)
					end
					saveas(h,strcat(tmp_dir,'/',str1),'png');
					close(h);
					disp(['AUC: ',num2str(SVMstd_ext.AUC)])
					disp(['max Accuracy: ',num2str(max(SVMstd_ext.acc))])
				end
				
				results = [results,[SVMstd_ext.AUC max(SVMstd_ext.acc)]'];
			else
				[SVMstd.predicted_label, SVMstd.accuracy, SVMstd.dec_values] = libsvmpredict(eval_class, eval_features, SVMmodel,'-q');
				[SVMstd.sensitivity, SVMstd.specificity, SVMstd.precision, SVMstd.recall, SVMstd.F1score, SVMstd.error_rate] = computePerformances(eval_class, SVMstd.predicted_label, show_data);
			end

		case 'p'
			% SVM with probabilities
			if show_data
				disp(' ')
				disp('--------------------------')
				disp('Classify with SVM probabilistic')
			end
			
			if isfield(parameters,'SMVprob')
				params = strcat('-b 1 ',parameters.SMVprob);
			else
				params = '-b 1';
			end
			
			SVMmodel = libsvmtrain(train_class, train_features,params);
			
			if is_extended
				[SVMprob.predicted_label_ext, SVMprob.accuracy_ext, SVMprob.prob_estimates_ext] = libsvmpredict(eval_class, eval_features, SVMmodel,'-q -b 1');
				[SVMprob.predicted_label, SVMprob.prob_estimates] = SVMprobReduce(SVMprob.predicted_label_ext, SVMprob.prob_estimates_ext);
				
				if show_data
					str1 = strcat('SVM-prob_',title_string); 
					h = figure();
					hold on;
					title(str1,'Interpreter','none')
				end
								
				
				[SVMprob.AUC, SVMprob.AUH, SVMprob.acc0, SVMprob.accM ,SVMprob.thrM, SVMprob.thr, SVMprob.acc, SVMprob.sens, SVMprob.spec, SVMprob.hull] = rocplot(SVMprob.prob_estimates(:,1),eval_class(1:8:end) == 1, show_data);
			else
				[SVMprob.predicted_label, SVMprob.accuracy, SVMprob.prob_estimates] = libsvmpredict(eval_class, eval_features, SVMmodel,'-q -b 1');
				
				if show_data
					str1 = strcat('SVM-prob_',title_string);
					h = figure();
					hold on;
					title(str1,'Interpreter','none')
				end

				[SVMprob.AUC, SVMprob.AUH, SVMprob.acc0, SVMprob.accM ,SVMprob.thrM, SVMprob.thr, SVMprob.acc, SVMprob.sens, SVMprob.spec, SVMprob.hull] = rocplot(SVMprob.prob_estimates(:,1),eval_class == 1, show_data);
			end
			
			
			% figure(11)
			
			if show_data
				hold off;
				tmp_dir = strcat('./figures/',strtok(title_string,'-'));
				if ~exist(tmp_dir,'dir')
					mkdir(tmp_dir)
				end
				saveas(h,strcat(tmp_dir,'/',str1),'png');
				close(h);
				disp(['AUC: ',num2str(SVMprob.AUC)])
				disp(['max Accuracy: ',num2str(max(SVMprob.acc))])
			end
			
			results = [results,[SVMprob.AUC max(SVMprob.acc)]'];

		case 'r'
			% random forest
			if show_data
				disp(' ')
				disp('--------------------------')
				disp('Classify with Random Forest')
			end
			
			if isfield(parameters,'RFntree')
				if isfield(parameters,'RFmtry')
					if isfiled(parameters,'RFextra_options')
						RF_model = classRF_train(train_features, train_class,parameters.RFntree,parameters.RFmtry,parameters.RFextra_options);
					else
						RF_model = classRF_train(train_features, train_class,parameters.RFntree,parameters.RFmtry);
					end
				else
					RF_model = classRF_train(train_features, train_class,parameters.RFntree);
				end
			else
				RF_model = classRF_train(train_features, train_class);
			end
			
			
			%figure(12)
			% subplot(2,1,2)
			if is_extended
				[RF.predicted_label_ext, RF.votes_ext] = classRF_predict(eval_features, RF_model);
				RF.probabilities = RFReduce(RF.votes_ext);
				
				if show_data
					str1 = strcat('RF_',title_string) ;
					h = figure();
					hold on;
					title(str1,'Interpreter','none')
				end
				
				[RF.AUC, RF.AUH, RF.acc0, RF.accM, RF.thrM, RF.thr, RF.acc, RF.sens, RF.spec, RF.hull] = rocplot(RF.probabilities(:,1),eval_class(1:8:end) == 1, show_data);
			else
				[RF.predicted_label, RF.votes] = classRF_predict(eval_features, RF_model);
				RF.probabilities = RF.votes(:,2)./sum(RF.votes,2);
				
				if show_data
					str1 = strcat('RF_',title_string); 
					h = figure();
					hold on;
					title(str1,'Interpreter','none');
				end
				
				
				[RF.AUC, RF.AUH, RF.acc0, RF.accM, RF.thrM, RF.thr, RF.acc, RF.sens, RF.spec, RF.hull] = rocplot(RF.probabilities,eval_class == 1, show_data);
			end
			
			
			if show_data
				hold off;
				tmp_dir = strcat('./figures/',strtok(title_string,'-'));
				if ~exist(tmp_dir,'dir')
					mkdir(tmp_dir)
				end
				saveas(h,strcat(tmp_dir,'/',str1),'png');
				close(h);
				disp(['AUC: ',num2str(RF.AUC)])
				disp(['max Accuracy: ',num2str(max(RF.acc))])
			end
			
			results = [results,[RF.AUC max(RF.acc)]'];

		case 'c'
			% sparse coding
			
		otherwise
			disp('Classifiers not recognized')
	end
end

if save_data
	if exist('filename','var')
		if isempty(strfind(filename,'.mat'))
			filename = strcat('./class/',filename,'.mat');
		else
			filename = strcat('./class/',filename);
		end
	else
		filename = './class/features.mat';
	end
	
	save(filename,'-regexp','^SVM|^RF|^SC');
end







end

