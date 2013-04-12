% load data


logfile = strcat('log_exp03_',datestr(now),'.txt');


if ~exist('class','dir')
	mkdir('class')
end

diary(logfile)


load('../../extTrainDataSet.mat');
load('../../extEvalDataSet.mat');

features_type = 'MSiVHL';

% number of features
n = length(features_type);

combinations = dec2bin(1:2^n-1,n);


extendT = true;
extendE = true;
normalize = true;
save_data = true;
show_data = true;


te_data = cell(n,4);

for j1=1:n
	% (train - features STD) - train class - (eval features STD) - eval class - train
	% features NORM - eval features NORM
	[ ~, te_data{j1,2}, ~, te_data{j1,4}, te_data{j1,1}, te_data{j1,3} ] = ...
	extractFeatures(extTrainDataSet, extEvalDataSet, features_type(j1), extendT, extendE, normalize, save_data, strcat(features_type(j1),'_norm_extA.mat') );
end




SVM_AUC = 0;
SVM_acc = 0;

RF_AUC = 0;
RF_acc = 0;

for k1 = 1:size(combinations,1)
	feats = [];
	
	t_feat_n01 = [];
	t_cl01 = [];
	e_feat_n01 = [];
	e_cl01 = [];
	
	for k2=1:n
		if combinations(k1,k2) == '1'
			switch k2
				case 1
					feats = strcat(feats,'M');
					t_feat_n01 = [t_feat_n01,te_data{k2,1}];
					e_feat_n01 = [e_feat_n01,te_data{k2,3}];
					
					if isempty(t_cl01)
						t_cl01 = te_data{k2,2};
					end
					
					if isempty(e_cl01)
						e_cl01 = te_data{k2,4};
					end
				case 2
					feats = strcat(feats,'S');
					t_feat_n01 = [t_feat_n01,te_data{k2,1}];
					e_feat_n01 = [e_feat_n01,te_data{k2,3}];

					if isempty(t_cl01)
						t_cl01 = te_data{k2,2};
					end
					
					if isempty(e_cl01)
						e_cl01 = te_data{k2,4};
					end
				case 3
					feats = strcat(feats,'i');
					e_feat_n01 = [e_feat_n01,te_data{k2,3}];
					t_feat_n01 = [t_feat_n01,te_data{k2,1}];

					if isempty(t_cl01)
						t_cl01 = te_data{k2,2};
					end
					
					if isempty(e_cl01)
						e_cl01 = te_data{k2,4};
					end
				case 4
					feats = strcat(feats,'V');
					e_feat_n01 = [e_feat_n01,te_data{k2,3}];
					t_feat_n01 = [t_feat_n01,te_data{k2,1}];

					if isempty(t_cl01)
						t_cl01 = te_data{k2,2};
					end
					
					if isempty(e_cl01)
						e_cl01 = te_data{k2,4};
					end
				case 5
					feats = strcat(feats,'H');
					t_feat_n01 = [t_feat_n01,te_data{k2,1}];
					e_feat_n01 = [e_feat_n01,te_data{k2,3}];

					if isempty(t_cl01)
						t_cl01 = te_data{k2,2};
					end
					
					if isempty(e_cl01)
						e_cl01 = te_data{k2,4};
					end
				case 6
					feats = strcat(feats,'L');
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
	end
	
	
	
	disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
	disp(' ')
	disp(['experiment ',num2str(k1),' of ',num2str(size(combinations,1)),' - features: ',feats])

	
	params = struct;
	params.SMVstd = '-q';
	params.SMVprob = '-q';
	
	res = classify_data( 'pr', params, t_feat_n01, t_cl01, e_feat_n01, e_cl01, extendE, show_data, save_data, strcat('class_',feats,'_norm_extA.mat'), strcat('feat_',feats,'-extA-ds_norm') );
	
	if res(1,1) > SVM_AUC
		SVM_AUC = res(1,1);
		SVM_AUC_feats = feats;
	end
	
	if res(2,1) > SVM_acc
		SVM_acc = res(2,1);
		SVM_acc_feats = feats;
	end
	
	if res(1,2) > RF_AUC
		RF_AUC = res(1,2);
		RF_AUC_feats = feats;
	end
	
	if res(2,2) > RF_acc
		RF_acc = res(2,2);
		RF_acc_feats = feats;
	end
		
end

disp(['Best SVM AUC: ',num2str(SVM_AUC),' with features ',SVM_AUC_feats]);
disp(['Best SVM acc: ',num2str(SVM_acc),' with features ',SVM_acc_feats]);
disp(['Best RF AUC:  ',num2str(RF_AUC),' with features ',RF_AUC_feats]);
disp(['Best RF acc:  ',num2str(RF_acc),' with features ',RF_acc_feats]);


diary off
