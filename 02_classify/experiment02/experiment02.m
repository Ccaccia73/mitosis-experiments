% load data

logfile = strcat('log_exp02_',datestr(now),'.txt');

diary logfile

load('../../extTrainDataSet.mat');
load('../../extEvalDataSet.mat');


if ~exist('class','dir')
	mkdir('class')
end

% memo : extend train - extend eval - normalize - save

feats = 'MSiHR';
normalize = true;
save_data = true;
show_data = true;



extendT = false;
extendE = false;

[ ~, t_cl01, ~, e_cl01, t_feat_n01, e_feat_n01 ] = extractFeatures(extTrainDataSet, extEvalDataSet, feats, extendT, extendE, normalize, save_data, strcat(feats,'_norm_def.mat'));

params = struct;

disp(' ')
disp(' ')
disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
disp(' ')
disp('Classifying mean+std+intensities with normalized features default datasets')
disp(' ')
classify_data( 'pr', params, t_feat_n01, t_cl01, e_feat_n01, e_cl01, extendE, show_data, save_data, strcat('class_',feats,'_norm_def.mat'), strcat('feat_',feats,'-def-ds_norm') );


%------------------------------------------

extendT = true;
extendE = false;


% mean std intensity - norm features - ext train
[ ~, t_cl02, ~, e_cl02, t_feat_n02, e_feat_n02 ] = extractFeatures(extTrainDataSet, extEvalDataSet, feats, extendT, extendE, normalize, save_data, strcat(feats,'_norm_extT.mat'));

params = struct;

disp(' ')
disp(' ')
disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
disp(' ')
disp('Classifying mean+std+intensities with normalized features extended train set')
disp(' ')
classify_data( 'pr', params, t_feat_n02, t_cl02, e_feat_n02, e_cl02, extendE, show_data, save_data, strcat('class_',feats,'_norm_extT.mat'), strcat('feat_',feats,'-extT-ds_norm') );



%------------------------------------------

extendT = false;
extendE = true;


% mean std intensity - norm features - ext train
[ ~, t_cl03, ~, e_cl03, t_feat_n03, e_feat_n03 ] = extractFeatures(extTrainDataSet, extEvalDataSet, feats, extendT, extendE, normalize, save_data, strcat(feats,'_norm_extE.mat'));

params = struct;

disp(' ')
disp(' ')
disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
disp(' ')
disp('Classifying mean+std+intensities with normalized features extended test set')
disp(' ')
classify_data( 'pr', params, t_feat_n03, t_cl03, e_feat_n03, e_cl03, extendE, show_data, save_data, strcat('class_',feats,'_norm_extE.mat'), strcat('feat_',feats,'-extE-ds_norm') );


%------------------------------------------

extendT = true;
extendE = true;


% mean std intensity - norm features - ext train
[ ~, t_cl04, ~, e_cl04, t_feat_n04, e_feat_n04 ] = extractFeatures(extTrainDataSet, extEvalDataSet, feats, extendT, extendE, normalize, save_data, strcat(feats,'_norm_extA.mat'));

params = struct;

disp(' ')
disp(' ')
disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
disp(' ')
disp('Classifying mean+std+intensities with normalized features extended All sets')
disp(' ')
classify_data( 'pr', params, t_feat_n04, t_cl04, e_feat_n04, e_cl04, extendE, show_data, save_data, strcat('class_',feats,'_norm_extA.mat'), strcat('feat_',feats,'-extA-ds_norm') );



%°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°


feats = 'MSiHU';
normalize = true;
save_data = true;
show_data = true;

extendT = false;
extendE = false;

[ ~, t_cl11, ~, e_cl11, t_feat_n11, e_feat_n11 ] = extractFeatures(extTrainDataSet, extEvalDataSet, feats, extendT, extendE, normalize, save_data, strcat(feats,'_norm_def.mat'));

params = struct;

disp(' ')
disp(' ')
disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
disp(' ')
disp('Classifying mean+std+intensities with normalized features default datasets')
disp(' ')
classify_data( 'pr', params, t_feat_n11, t_cl11, e_feat_n11, e_cl11, extendE, show_data, save_data, strcat('class_',feats,'_norm_def.mat'), strcat('feat_',feats,'-def-ds_norm') );


%------------------------------------------

extendT = true;
extendE = false;


% mean std intensity - norm features - ext train
[ ~, t_cl12, ~, e_cl12, t_feat_n12, e_feat_n12 ] = extractFeatures(extTrainDataSet, extEvalDataSet, feats, extendT, extendE, normalize, save_data, strcat(feats,'_norm_extT.mat'));

params = struct;

disp(' ')
disp(' ')
disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
disp(' ')
disp('Classifying mean+std+intensities with normalized features extended train set')
disp(' ')
classify_data( 'pr', params, t_feat_n12, t_cl12, e_feat_n12, e_cl12, extendE, show_data, save_data, strcat('class_',feats,'_norm_extT.mat'), strcat('feat_',feats,'-extT-ds_norm') );



%------------------------------------------

extendT = false;
extendE = true;


% mean std intensity - norm features - ext train
[ ~, t_cl13, ~, e_cl13, t_feat_n13, e_feat_n13 ] = extractFeatures(extTrainDataSet, extEvalDataSet, feats, extendT, extendE, normalize, save_data, strcat(feats,'_norm_extE.mat'));

params = struct;

disp(' ')
disp(' ')
disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
disp(' ')
disp('Classifying mean+std+intensities with normalized features extended test set')
disp(' ')
classify_data( 'pr', params, t_feat_n13, t_cl13, e_feat_n13, e_cl13, extendE, show_data, save_data, strcat('class_',feats,'_norm_extE.mat'), strcat('feat_',feats,'-extE-ds_norm') );


%------------------------------------------

extendT = true;
extendE = true;


% mean std intensity - norm features - ext train
[ ~, t_cl14, ~, e_cl14, t_feat_n14, e_feat_n14 ] = extractFeatures(extTrainDataSet, extEvalDataSet, feats, extendT, extendE, normalize, save_data, strcat(feats,'_norm_extA.mat'));

params = struct;

disp(' ')
disp(' ')
disp('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°')
disp(' ')
disp('Classifying mean+std+intensities with normalized features extended All sets')
disp(' ')
classify_data( 'pr', params, t_feat_n14, t_cl14, e_feat_n14, e_cl14, extendE, show_data, save_data, strcat('class_',feats,'_norm_extA.mat'), strcat('feat_',feats,'-extA-ds_norm') );

diary off
