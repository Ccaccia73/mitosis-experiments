% load data

delete('log.txt')

diary log.txt

load('../../extTrainDataSet.mat');
load('../../extEvalDataSet.mat');

% number of features
n = 7;

combinations = dec2bin(1:2^n-1,n);

SVM_AUC = 0;
SVM_acc = 0;

RF_AUC = 0;
RF_acc = 0;

for k1 = 1:size(combinations,1)
	feats = [];
	for k2=1:n
		if combinations(k1,k2) == '1'
			switch k2
				case 1
					feats = strcat(feats,'M');
				case 2
					feats = strcat(feats,'S');
				case 3
					feats = strcat(feats,'d');
				case 4
					feats = strcat(feats,'i');
				case 5
					feats = strcat(feats,'l');
				case 6
					feats = strcat(feats,'v');
				case 7
					feats = strcat(feats,'H');
			end
		end
	end
	
	
	extendT = true;
	extendE = true;
	normalize = true;
	save_data = true;
	show_data = true;
	
	disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
	disp(' ')
	disp(['experiment ',num2str(k1),' of ',num2str(size(combinations,1)),' - features: ',feats])

	% mean std intensity - norm features - ext train
	[ ~, t_cl01, ~, e_cl01, t_feat_n01, e_feat_n01 ] = extractFeatures(extTrainDataSet, extEvalDataSet, feats, extendT, extendE, normalize, save_data, strcat(feats,'_norm_extA.mat'));
	
	params = struct;
	
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
