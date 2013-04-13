

logfile = strcat('log_exp05_',datestr(now),'.txt');


if ~exist('class','dir')
	mkdir('class')
end

diary(logfile)


load('../../extTrainDataSet.mat');
load('../../extEvalDataSet.mat');

feats = 'MSiVHL';

extendT = true;
extendE = true;
normalize = true;
save_data = true;
show_data = true;

[ ~, t_cl01, ~, e_cl01, t_feat_n01, e_feat_n01 ] = extractFeatures(extTrainDataSet, extEvalDataSet, feats, extendT, extendE, normalize, save_data, strcat(feats,'_norm_def.mat'));

kern = {'-t 2','-t 3'};
degr = {'-d 3','-d 4','-d 5','-d 6','-d 7'};
folds = {'','-v 3','-v 5','-v 10'};

n_kern = length(kern);
n_degr = length(degr);
n_folds = length(folds);


SVMstd_AUC = 0;
SVMstd_acc = 0;
SVMstd_AUC_params = zeros(3,1);
SVMstd_acc_params = zeros(3,1);


SVMprob_AUC = 0;
SVMprob_acc = 0;
SVMprob_AUC_params = zeros(3,1);
SVMprob_acc_params = zeros(3,1);


for k1=1:n_kern
	for k2=1:n_degr
		for k3=1:n_folds
			
			i1 = (k1 - 1) * n_degr * n_folds + (k2 - 1) * n_folds + k3;
			
			optstr = strcat(kern{k1},' ',degr{k2},' ',folds{k3});
			
			disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
			disp(' ')
			disp(['experiment ',num2str(i1),' of ',num2str(n_kern * n_degr * n_folds),' - options: ',optstr])
			
			
			params = struct;
			params.SMVstd = optstr;
			params.SMVprob = optstr;
			
			res = classify_data( 'sp', params, t_feat_n01, t_cl01, e_feat_n01, e_cl01, extendE, show_data, save_data, strcat('class_',feats,'_norm_extA.mat'), strcat('feat_',feats,'-opts',num2str(i1,'%03d'),'-extA-ds_norm') );
			
			if res(1,1) > SVMstd_AUC
				SVMstd_AUC = res(1,1);
				SVMstd_AUC_params = [k1 k2 k3]';
			end
			
			if res(2,1) > SVMstd_acc
				SVMstd_acc = res(2,1);
				SVMstd_acc_params = [k1 k2 k3]';
			end
			
			if res(1,2) > SVMprob_AUC
				SVMprob_AUC = res(1,2);
				SVMprob_AUC_params = [k1 k2 k3]';
			end
			
			if res(2,2) > SVMprob_acc
				SVMprob_acc = res(2,2);
				SVMprob_acc_params = [k1 k2 k3]';
			end
			
		end
	end
end

disp(['Best SVMstd AUC:  ',num2str(SVMstd_AUC),' with params: ',kern{SVMstd_AUC_params(1)},' ',degr{SVMstd_AUC_params(2)},' ',folds{SVMstd_AUC_params(3)}]);
disp(['Best SVMstd acc:  ',num2str(SVMstd_acc),' with params: ',kern{SVMstd_acc_params(1)},' ',degr{SVMstd_acc_params(2)},' ',folds{SVMstd_acc_params(3)}]);
disp(['Best SVMprob AUC: ',num2str(SVMprob_AUC),' with params: ',kern{SVMprob_AUC_params(1)},' ',degr{SVMprob_AUC_params(2)},' ',folds{SVMprob_AUC_params(3)}]);
disp(['Best SVMprob acc: ',num2str(SVMprob_acc),' with params: ',kern{SVMprob_acc_params(1)},' ',degr{SVMprob_acc_params(2)},' ',folds{SVMprob_acc_params(3)}]);


diary off
