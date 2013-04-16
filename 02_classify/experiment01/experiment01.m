% load data

% normalization

logfile = strcat('log_exp01_',datestr(now),'.txt');

diary(logfile)

% load data

load('../../extTrainDataSet.mat');
load('../../extEvalDataSet.mat');


if ~exist('class','dir')
	mkdir('class')
end

extendT = true;
extendE = true;
normalize = true;
save_data = true;
show_data = true;


for k1=1:5
	switch k1
		case 1
			feats = 'MSi';
		case 2
			feats = 'MSiHLV';
		case 3
			feats = 'MSiHrV';
		case 4
			feats = 'MSiHuV';
	end
	
	[ t_feat01, t_cl01, e_feat01, e_cl01, t_feat_n01, e_feat_n01 ] = extractFeatures(extTrainDataSet, extEvalDataSet, feats, extendT, extendE, normalize, save_data, strcat(feats,'_norm_extA.mat'));
	
	params = struct;
	
	disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
	disp(['Classifying ',feats,' with standard features extended all datasets'])
	disp(' ')
	classify_data( 'spr', params, t_feat01, t_cl01, e_feat01, e_cl01, extendE, show_data, save_data, strcat('class_',feats,'_std_extA.mat'), strcat('feat_',feats,'-extA-ds_std') );
	
	disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
	disp(['Classifying ',feats,' with normalized features extended all datasets'])
	disp(' ')
	classify_data( 'spr', params, t_feat_n01, t_cl01, e_feat_n01, e_cl01, extendE, show_data, save_data, strcat('class_',feats,'_norm_extA.mat'), strcat('feat_',feats,'-extA-ds_norm') );

end