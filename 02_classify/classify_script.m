%% load data

load('../extTrainDataSet.mat');
load('../extEvalDataSet.mat');

% memo : extend train - extend eval - normalize - save

% mean std - norm features - std datasets
[ t_feat01, t_cl01, e_feat01, e_cl01, t_feat_n01, e_feat_n01 ] = extractFeatures(extTrainDataSet, extEvalDataSet, 'ms', false, false, true, true, 'ms_norm.mat' );

%classify_data( classifiers, parameters, train_features, train_class, eval_features, eval_class, is_extended, show_data, save_data, filename );

params = struct;

disp('++++++++++++++++++++++++++++++++++++++++++++')
disp('Classifying mean+std with standard features')
disp(' ')
classify_data( 'spr', params, t_feat01, t_cl01, e_feat01, e_cl01, false, true, true, 'class_ms_std.mat' );

disp('++++++++++++++++++++++++++++++++++++++++++++')
disp('Classifying mean+std with normalized features')
disp(' ')
classify_data( 'spr', params, t_feat_n01, t_cl01, e_feat_n01, e_cl01, false, true, true, 'mclass_s_norm.mat' );


clear

load('../extTrainDataSet.mat');
load('../extEvalDataSet.mat');

% mean std - norm features - ext train
[ t_feat02, t_cl02, e_feat02, e_cl02, t_feat_n02, e_feat_n02 ] = extractFeatures(extTrainDataSet, extEvalDataSet, 'ms', true, false, true, true, 'ms_norm_extT.mat' );

params = struct;

disp('++++++++++++++++++++++++++++++++++++++++++++')
disp('Classifying mean+std with standard features extended train dataset')
disp(' ')
classify_data( 'spr', params, t_feat02, t_cl02, e_feat02, e_cl02, false, true, true, 'class_ms_std_extT.mat' );

disp('++++++++++++++++++++++++++++++++++++++++++++')
disp('Classifying mean+std with normalized features extended train dataset')
disp(' ')
classify_data( 'spr', params, t_feat_n02, t_cl02, e_feat_n02, e_cl02, false, true, true, 'class_ms_norm_extT.mat' );



clear

load('../extTrainDataSet.mat');
load('../extEvalDataSet.mat');

% mean std - norm features - ext all
[ t_feat03, t_cl03, e_feat03, e_cl03, t_feat_n03, e_feat_n03 ] = extractFeatures(extTrainDataSet, extEvalDataSet, 'ms', true, true, true, true, 'ms_norm_extA.mat' );

params = struct;

disp('++++++++++++++++++++++++++++++++++++++++++++')
disp('Classifying mean+std with standard features extended all datasets')
disp(' ')
classify_data( 'spr', params, t_feat03, t_cl03, e_feat03, e_cl03, true, true, true, 'class_ms_std_extA.mat' );

disp('++++++++++++++++++++++++++++++++++++++++++++')
disp('Classifying mean+std with normalized features extended all datasets')
disp(' ')
classify_data( 'spr', params, t_feat_n03, t_cl03, e_feat_n03, e_cl03, true, true, true, 'class_ms_norm_extA.mat' );



clear

load('../extTrainDataSet.mat');
load('../extEvalDataSet.mat');

% mean std intensity - norm features - std datasets
[ t_feat04, t_cl04, e_feat04, e_cl04, t_feat_n04, e_feat_n04 ] = extractFeatures(extTrainDataSet, extEvalDataSet, 'msi', false, false, true, true, 'msi_norm.mat' );

params = struct;

disp('++++++++++++++++++++++++++++++++++++++++++++')
disp('Classifying mean+std+intensities with standard features')
disp(' ')
classify_data( 'spr', params, t_feat04, t_cl04, e_feat04, e_cl04, false, true, true, 'class_msi_std.mat' );

disp('++++++++++++++++++++++++++++++++++++++++++++')
disp('Classifying mean+std+intensities with normalized features')
disp(' ')
classify_data( 'spr', params, t_feat_n04, t_cl04, e_feat_n04, e_cl04, false, true, true, 'class_msi_norm.mat' );

clear

load('../extTrainDataSet.mat');
load('../extEvalDataSet.mat');

% mean std intensity - norm features - ext train
[ t_feat05, t_cl05, e_feat05, e_cl05, t_feat_n05, e_feat_n05 ] = extractFeatures(extTrainDataSet, extEvalDataSet, 'msi', true, false, true, true, 'msi_norm_extT.mat' );

params = struct;

disp('++++++++++++++++++++++++++++++++++++++++++++')
disp('Classifying mean+std+intensities with normalized features extended train dataset')
disp(' ')
classify_data( 'spr', params, t_feat05, t_cl05, e_feat05, e_cl05, false, true, true, 'class_msi_std_extT.mat' );

disp('++++++++++++++++++++++++++++++++++++++++++++')
disp('Classifying mean+std+intensities with normalized features extended train dataset')
disp(' ')
classify_data( 'spr', params, t_feat_n05, t_cl05, e_feat_n05, e_cl05, false, true, true, 'class_msi_norm_extT.mat' );

clear

load('../extTrainDataSet.mat');
load('../extEvalDataSet.mat');

% mean std intensity - norm features - ext all
[ t_feat06, t_cl06, e_feat06, e_cl06, t_feat_n06, e_feat_n06 ] = extractFeatures(extTrainDataSet, extEvalDataSet, 'msi', true, true, true, true, 'msi_norm_extA.mat' );

params = struct;

disp('++++++++++++++++++++++++++++++++++++++++++++')
disp('Classifying mean+std+intensities with standard features extended all datasets')
disp(' ')
classify_data( 'spr', params, t_feat06, t_cl06, e_feat06, e_cl06, true, true, true, 'class_msi_std_extA.mat' );

disp('++++++++++++++++++++++++++++++++++++++++++++')
disp('Classifying mean+std+intensities with normalized features extended all datasets')
disp(' ')
classify_data( 'spr', params, t_feat_n06, t_cl06, e_feat_n06, e_cl06, true, true, true, 'class_msi_norm_extA.mat' );

