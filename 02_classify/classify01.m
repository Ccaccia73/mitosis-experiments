% load data

load('../extTrainDataSet.mat');
load('../extEvalDataSet.mat');

% memo : extend train - extend eval - normalize - save

% mean std - norm features - std datasets
[ t_feat01, t_cl01, e_feat01, e_cl01, t_feat_n01, e_feat_n01 ] = extractFeatures(extTrainDataSet, extEvalDataSet, 'ms', false, false, true, true, 'ms_norm.mat' );

disp('Standard Features')

disp('--------------------------')
disp(' ')
disp('Classify with SVM standard')

SVMmodel = libsvmtrain(t_cl01, t_feat01,'-q');
[SVM_01.predicted_label, SVM_01.accuracy, SVM_01.dec_values] = libsvmpredict(e_cl01, e_feat01, SVMmodel,'-q');

disp(' ')
disp('Standard dataset:')
disp(['Error rate: ',num2str(sum(SVM_01.predicted_label~=e_cl01)/length(SVM_01.predicted_label)*100),'%'])

[SVM_01.sensitivity, SVM_01.specificity, SVM_01.precision, SVM_01.recall, SVM_01.F1score, SVM_01.error_rate] = computePerformances(e_cl01, SVM_01.predicted_label, true);


disp(' ')
disp('Classify with SVM probabilistic')

SVMmodel = libsvmtrain(t_cl01, t_feat01,'-q -b 1');
[SVM_p01.predicted_label, SVM_p01.accuracy, SVM_p01.prob_estimates] = libsvmpredict(e_cl01, e_feat01, SVMmodel,'-q -b 1');

figure(1)
[SVM_p01.AUC, SVM_p01.AUH, SVM_p01.acc0, SVM_p01.accM ,SVM_p01.thrM, SVM_p01.thr, SVM_p01.acc, SVM_p01.sens, SVM_p01.spec, SVM_p01.hull] = rocplot(SVM_p01.prob_estimates(:,1),e_cl01 == 1, 1);

disp(['AUC: ',num2str(SVM_p01.AUC)])

disp(' ')
disp('Classify with Random Forest')

RF_model = classRF_train(t_feat01, t_cl01);
[RF_01.predicted_label, RF_01.votes] = classRF_predict(e_feat01, RF_model);

figure(2)
% subplot(2,1,2)

[RF_01.AUC, RF_01.AUH, RF_01.acc0, RF_01.accM, RF_01.thrM, RF_01.thr, RF_01.acc, RF_01.sens, RF_01.spec, RF_01.hull] = rocplot(RF_01.votes(:,2)./sum(RF_01.votes,2),e_cl01 == 1, 1);

disp(['AUC: ',num2str(RF_01.AUC)])


disp('Normalized Features')

disp('--------------------------')
disp(' ')
disp('Classify with SVM standard')

SVMmodel = libsvmtrain(t_cl01, t_feat_n01,'-q');
[SVM_n01.predicted_label, SVM_n01.accuracy, SVM_n01.dec_values] = libsvmpredict(e_cl01, e_feat_n01, SVMmodel,'-q');

disp(' ')
disp('Standard dataset:')
disp(['Error rate: ',num2str(sum(SVM_n01.predicted_label~=e_cl01)/length(SVM_n01.predicted_label)*100),'%'])

[SVM_n01.sensitivity, SVM_n01.specificity, SVM_n01.precision, SVM_n01.recall, SVM_n01.F1score, SVM_n01.error_rate] = computePerformances(e_cl01, SVM_n01.predicted_label, true);


disp(' ')
disp('Classify with SVM probabilistic')

SVMmodel = libsvmtrain(t_cl01, t_feat_n01,'-q -b 1');
[SVM_np01.predicted_label, SVM_np01.accuracy, SVM_np01.prob_estimates] = libsvmpredict(e_cl01, e_feat_n01, SVMmodel,'-q -b 1');

figure(3)
[SVM_np01.AUC, SVM_np01.AUH, SVM_np01.acc0, SVM_np01.accM ,SVM_np01.thrM, SVM_np01.thr, SVM_np01.acc, SVM_np01.sens, SVM_np01.spec, SVM_np01.hull] = rocplot(SVM_np01.prob_estimates(:,1),e_cl01 == 1, 1);

disp(['AUC: ',num2str(SVM_p01.AUC)])

disp(' ')
disp('Classify with Random Forest')

RF_model = classRF_train(t_feat_n01, t_cl01);
[RF_n01.predicted_label, RF_n01.votes] = classRF_predict(e_feat_n01, RF_model);

figure(4)
% subplot(2,1,2)

[RF_n01.AUC, RF_n01.AUH, RF_n01.acc0, RF_n01.accM, RF_n01.thrM, RF_n01.thr, RF_n01.acc, RF_n01.sens, RF_n01.spec, RF_n01.hull] = rocplot(RF_n01.votes(:,2)./sum(RF_n01.votes,2),e_cl01 == 1, 1);

disp(['AUC: ',num2str(RF_n01.AUC)])

