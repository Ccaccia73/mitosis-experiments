load 'simpleFeatures.mat'


SVMmodel_sd = libsvmtrain(train_class, train_features,'');

[predicted_label_sd, accuracy_sd, dec_values_sd] = libsvmpredict(eval_class, eval_features, SVMmodel_sd,'');

% figure(1)
% % subplot(2,1,1)
% 
% [AUC_sd AUH_sd acc0_sd accM_sd thrM_sd thr_sd acc_sd sens_sd spec_sd hull_sd] = rocplot(prob_estimates_sd(:,1),eval_class == 1, 1);
% 
% title('Default features, std implementation')



SVMmodel_pd = libsvmtrain(train_class, train_features,'-b 1');

[predicted_label_pd, accuracy_pd, prob_estimates_pd] = libsvmpredict(eval_class, eval_features, SVMmodel_pd,'-b 1');

figure(1)
% subplot(2,1,2)

[AUC_svm_d, AUH_svm_d, acc0_svm_d, accM_svm_d ,thrM_svm_d, thr_svm_d, acc_svm_d, sens_svm_d, spec_svm_d, hull_svm_d] = rocplot(prob_estimates_pd(:,1),eval_class == 1, 1);

title('SVM : Default features')


% SVMmodel_sn = libsvmtrain(train_class, train_features_norm,'');
% 
% [predicted_label_sn, accuracy_sn, dec_values_sn] = libsvmpredict(eval_class, eval_features_norm, SVMmodel_sn,'');
% 
% figure(3)
% % subplot(2,1,1)
% 
% [AUC_sn AUH_sn acc0_sn accM_sn thrM_sn thr_sn acc_sn sens_sn spec_sn hull_sn] = rocplot(prob_estimates_sn(:,1),eval_class == 1, 1);
% 
% title('Normalized features, std implementation')



SVMmodel_pn = libsvmtrain(train_class, train_features_norm,'-b 1');

[predicted_label_pn, accuracy_pn, prob_estimates_pn] = libsvmpredict(eval_class, eval_features_norm, SVMmodel_pn,'-b 1');

figure(2)
% subplot(2,1,2)

[AUC_svm_n, AUH_svm_n, acc0_svm_n, accM_svm_n, thrM_svm_n, thr_svm_n, acc_svm_n, sens_svm_n, spec_svm_n, hull_svm_n] = rocplot(prob_estimates_pn(:,1),eval_class == 1, 1);

title('SVM : Normalized features')


disp(' ')
disp('---------------------------')
disp(' ')

% disp(['AUC std - default features: ',num2str(AUC_sd)])
disp(['AUC SVM - default features: ',num2str(AUC_svm_d)])


% disp(['AUC std - normalized features: ',num2str(AUC_sn)])
disp(['AUC SVM - normalized features: ',num2str(AUC_svm_n)])

disp(' ')
disp('---------------------------')
disp(' ')

% Random Forest

RF_model_std = classRF_train(train_features, train_class);
[RF_predict_d, RF_votes_std] = classRF_predict(eval_features, RF_model_std);

figure(3)
% subplot(2,1,2)

[AUC_rf_d, AUH_rf_d, acc0_rf_d, accM_rf_d, thrM_rf_d, thr_rf_d, acc_rf_d, sens_rf_d, spec_rf_d, hull_rf_d] = rocplot(RF_votes_std(:,2)./sum(RF_votes_std,2),eval_class == 1, 1);

title('Random Forest: Default features')


fprintf('\nRF std: error rate %f\n',   length(find(RF_predict_d~=eval_class))/length(eval_class));


RF_model_norm = classRF_train(train_features_norm, train_class);
[RF_predict_n, RF_votes_norm]  = classRF_predict(eval_features_norm, RF_model_norm);

figure(4)
% subplot(2,1,2)

[AUC_rf_n, AUH_rf_n, acc0_rf_n, accM_rf_n, thrM_rf_n, thr_rf_n, acc_rf_n, sens_rf_n, spec_rf_n, hull_rf_n] = rocplot(RF_votes_norm(:,2)./sum(RF_votes_norm,2),eval_class == 1, 1);

title('Random Forest: Normalized features')


fprintf('\nRF norm: error rate %f\n',   length(find(RF_predict_n~=eval_class))/length(eval_class));

disp(' ')
disp('---------------------------')
disp(' ')

% disp(['AUC std - default features: ',num2str(AUC_sd)])
disp(['AUC RF - default features: ',num2str(AUC_rf_d)])


% disp(['AUC std - normalized features: ',num2str(AUC_sn)])
disp(['AUC RF - normalized features: ',num2str(AUC_rf_n)])

disp(' ')
disp('---------------------------')
disp(' ')
