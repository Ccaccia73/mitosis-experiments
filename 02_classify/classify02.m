% load data

load('../extTrainDataSet.mat');
load('../extEvalDataSet.mat');

% memo : extend train - extend eval - normalize - save

% mean std - norm features - ext train
[ t_feat02, t_cl02, e_feat02, e_cl02, t_feat_n02, e_feat_n02 ] = extractFeatures(extTrainDataSet, extEvalDataSet, 'ms', true, false, true, true, 'ms_norm_extT.mat' );









