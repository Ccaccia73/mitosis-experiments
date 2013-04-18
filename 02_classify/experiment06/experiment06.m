
logfile = strcat('log_exp06_',datestr(now),'.txt');


if ~exist('class','dir')
	mkdir('class')
end

diary(logfile)


load('../../extTrainDataSet.mat');
load('../../extEvalDataSet.mat');


old_pc = -1;

hwb = waitbar(0,'1','Name','Running experiments.. ','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');

for j1=1:3
	
	switch j1
		case 1
			feats = 'MSidHUV';
		case 2
			feats = 'MSidHRV';
		case 3
			feats = 'MSidHLV';
	end
	
	extendT = true;
	extendE = true;
	normalize = true;
	save_data = true;
	show_data = false;
	
	% load MSidHLV_norm_extA.mat
	%
	% t_cl01 = train_classes;
	% e_cl01 = eval_classes;
	% t_feat_n01 = train_features_norm;
	% e_feat_n01 = eval_features_norm;
	
	[ ~, t_cl01, ~, e_cl01, t_feat_n01, e_feat_n01 ] = extractFeatures(extTrainDataSet, extEvalDataSet, feats, extendT, extendE, normalize, save_data, strcat(feats,'_norm_def.mat'));
	
	
	disp(['Tot number of features: ',num2str(size(t_feat_n01,2))])
	
	
	[coeff, t_feat_pca, latent, Tsquared, explained, mu] = pca(t_feat_n01);
	
	e_feat_pca = e_feat_n01 * coeff;
	
	nt = length(explained);
	
	SVM_AUC = zeros(nt,1);
	SVM_acc = zeros(nt,1);
	RF_AUC = zeros(nt,1);
	RF_acc = zeros(nt,1);
	
	for k1=1:nt
		
		disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
		disp(' ')
		disp(['experiment ',num2str(k1),' of ',num2str(nt),' - features: ',feats])
		
		
		params = struct;
		% 	params.SMVstd = '-q';
		% 	params.SMVprob = '-q';
		
		res = classify_data( 'pr', params, t_feat_pca(:,1:k1), t_cl01, e_feat_pca(:,1:k1), e_cl01, extendE, show_data, save_data, strcat('class_',feats,'_norm_extA.mat'), strcat('feat_',feats,'-extA-ds_norm') );
		
		SVM_AUC(k1) = res(1,1);
		SVM_acc(k1) = res(2,1);
		RF_AUC(k1) = res(1,2);
		RF_acc(k1) = res(2,2);
		
		
		pc = floor( ( (j1 - 1)*nt + k1)/(3*nt) * 100);
		
		if getappdata(hwb,'canceling')
			break
		end
		
		if pc ~= old_pc
			waitbar(pc/100,hwb,sprintf('Progress: %d%%',pc))
			old_pc = pc;
		end
		
		
	end
	
	save(strcat(feats,'_perf.mat'),'-regexp','^SVM|^RF|^SC','coeff','t_feat_pca','latent','Tsquared','explained','mu');
	
	h = figure(1);
	subplot(2,1,1)
	plot(cumsum(explained),SVM_AUC,cumsum(explained),RF_AUC)
	legend('SVM','RF')
	xlabel('% of explained variance')
	ylabel('AUC')
	subplot(2,1,2)
	plot(1:length(SVM_AUC),SVM_AUC,1:length(RF_AUC),RF_AUC)
	legend('SVM','RF')
	xlabel('# of components considered')
	ylabel('AUC')
	
	saveas(h,strcat('pca_AUC_',feats),'png');
	
	figure(2)
	subplot(2,1,1)
	plot(cumsum(explained),SVM_acc,cumsum(explained),RF_acc)
	legend('SVM','RF')
	xlabel('% of explained variance')
	ylabel('accuracy')
	subplot(2,1,2)
	plot(1:length(SVM_acc),SVM_acc,1:length(RF_acc),RF_acc)
	legend('SVM','RF')
	xlabel('# of components considered')
	ylabel('accuracy')
	
	saveas(h,strcat('pca_acc_',feats),'png');
	
end

close(hwb);