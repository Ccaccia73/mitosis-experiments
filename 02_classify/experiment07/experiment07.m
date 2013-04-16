
% load data


% logfile = strcat('log_exp07_',datestr(now),'.txt');
% 
% diary(logfile)

load('../../extTrainDataSet.mat');
load('../../extEvalDataSet.mat');



old_pc = -1;

h = waitbar(0,'1','Name','Running experiments.. ','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');

for k1=1:3
	
	switch k1
		case 1
			load('features_MSidHLV.mat');
			features_type = 'MSidHLV';
		case 2
			load('features_MSidHUV.mat');
			features_type = 'MSidHUV';
		case 3
			load('features_MSidHRV.mat');
			features_type = 'MSidHRV';
	end
	
	
	% number of features
	nf = length(features_type);
	
	
	LL = 11:10:101;
	
	nl = length(LL);
	
	
	combinations = dec2bin(1:2^nf-1,nf);
	
	nc = size(combinations,1);
	
	tot_exp = nl * nc * 3;
	
	extendT = true;
	extendE = true;
	normalize = true;
	save_data = false;
	show_data = false;
	
	
	feature_list = cell(nc,1);
	
	
	
	SVM_AUC = zeros(nc,nl);
	SVM_acc = zeros(nc,nl);
	
	RF_AUC = zeros(nc,nl);
	RF_acc = zeros(nc,nl);
	
	for k2 = 1:nc
		for k3=1:nl
			feats = [];
			
			t_feat_n01 = [];
			t_cl01 = [];
			e_feat_n01 = [];
			e_cl01 = [];
			
			for k4=1:nf
				if combinations(k2,k4) == '1'
					feats = strcat(feats,features_type(k4));
					t_feat_n01 = [t_feat_n01,te_data{k4,k3,1}];
					e_feat_n01 = [e_feat_n01,te_data{k4,k3,3}];
					
					if isempty(t_cl01)
						t_cl01 = te_data{k4,k3,2};
					end
					
					if isempty(e_cl01)
						e_cl01 = te_data{k4,3,4};
					end
				end
			end
			
			curr_exp = k3 + nl * (k2-1) + nl * nc * (k1 -1);
			pc = floor(curr_exp / tot_exp * 100);
			
						
			if getappdata(h,'canceling')
				break
			end
			
			if pc ~= old_pc
				waitbar(pc/100,h,sprintf('Progress: %d%%',pc))
				old_pc = pc;
			end
			
			
			params = struct;
			params.SMVstd = '-q';
			params.SMVprob = '-q';
			
			res = classify_data( 'pr', params, t_feat_n01, t_cl01, e_feat_n01, e_cl01, extendE, show_data, save_data, strcat('class_',feats,'_norm_extA.mat'), strcat('feat_',feats,'-extA-ds_norm') );
			
			SVM_AUC(k2,k3) = res(1,1);
			SVM_acc(k2,k3) = res(2,1);
			RF_AUC(k2,k3) = res(1,2);
			RF_acc(k2,k3) = res(2,2);
			
		end
		
		feature_list(k2) = feats;
	end
	
	save(strcat(features_type,'_L_results,mat','-regexp','^SVM|^RF|^SC','feature_list'));
	
	switch k1
		case 1
			clear features_MSidHLV.mat
		case 2
			clear features_MSidHUV.mat
		case 3
			clear features_MSidHRV.mat
	end
	
end

% diary off
