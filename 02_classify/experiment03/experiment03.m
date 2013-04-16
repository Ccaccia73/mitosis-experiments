% load data


logfile = strcat('log_exp03_',datestr(now),'.txt');


if ~exist('class','dir')
	mkdir('class')
end

diary(logfile)


load('../../extTrainDataSet.mat');
load('../../extEvalDataSet.mat');


for h1 = 1:3
	
	switch h1
		case 1
			features_type = 'MSiVHL';
		case 2
			features_type = 'MSiVHR';
		case 3
			features_type = 'MSiVHU';
	end
	
	% number of features
	n = length(features_type);
	
	combinations = dec2bin(1:2^n-1,n);
	
	
	extendT = true;
	extendE = true;
	normalize = true;
	save_data = false;
	show_data = true;
	
	
	te_data = cell(n,4);
	
	for j1=1:n
		% (train - features STD) - train class - (eval features STD) - eval class - train
		% features NORM - eval features NORM
		[ ~, te_data{j1,2}, ~, te_data{j1,4}, te_data{j1,1}, te_data{j1,3} ] = ...
			extractFeatures(extTrainDataSet, extEvalDataSet, features_type(j1), extendT, extendE, normalize, save_data, strcat(features_type(j1),'_norm_extA.mat') );
	end
	
	
	
	
	SVM_AUC = zeros(n,4);
	SVM_acc = zeros(n,4);
	
	RF_AUC = zeros(n,4);
	RF_acc = zeros(n,4);
	
	feat_list = cell(n,1);
	
	for k1 = 1:size(combinations,1)
		feats = [];
		
		t_feat_n01 = [];
		t_cl01 = [];
		e_feat_n01 = [];
		e_cl01 = [];
		
		for k2=1:n
			if combinations(k1,k2) == '1'
				feats = strcat(feats,features_type(k2));
				t_feat_n01 = [t_feat_n01,te_data{k2,1}];
				e_feat_n01 = [e_feat_n01,te_data{k2,3}];
				
				if isempty(t_cl01)
					t_cl01 = te_data{k2,2};
				end
				
				if isempty(e_cl01)
					e_cl01 = te_data{k2,4};
				end
			end
		end
		
		feat_list(k1) = feats;
		
		
		disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
		disp(' ')
		disp(['experiment ',num2str(k1),' of ',num2str(size(combinations,1)),' - features: ',feats])
		
		
		params = struct;
		params.SMVstd = '-q';
		params.SMVprob = '-q';
		
		res = classify_data( 'pr', params, t_feat_n01, t_cl01, e_feat_n01, e_cl01, extendE, show_data, save_data, strcat('class_',feats,'_norm_extA.mat'), strcat('feat_',feats,'-extA-ds_norm') );
		
		SVM_AUC(k1,1) = res(1,1);
		SVM_acc(k1,2) = res(2,1);
		RF_AUC(k1,3) = res(1,2);
		RF_acc(k1,4) = res(2,2);
		
	end
	
	save(strcat(features_type,'_results,mat','-regexp','^SVM|^RF|^SC','feature_list'));


end

% disp(['Best SVM AUC: ',num2str(SVM_AUC),' with features ',SVM_AUC_feats]);
% disp(['Best SVM acc: ',num2str(SVM_acc),' with features ',SVM_acc_feats]);
% disp(['Best RF AUC:  ',num2str(RF_AUC),' with features ',RF_AUC_feats]);
% disp(['Best RF acc:  ',num2str(RF_acc),' with features ',RF_acc_feats]);


diary off
