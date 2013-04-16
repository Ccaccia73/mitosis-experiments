% load data

logfile = strcat('log_exp04_',datestr(now),'.txt');

if ~exist('class','dir')
	mkdir('class')
end

diary(logfile)

load('../../extTrainDataSet.mat');
load('../../extEvalDataSet.mat');

feats = 'iVHL';
extendT = true;
extendE = true;
normalize = true;
save_data = true;
show_data = false;

mkdir(feats);

% mean std intensity - norm features - ext train
[ ~, t_cl_all, ~, e_cl_all, t_feat_n_all, e_feat_n_all ] = extractFeatures(extTrainDataSet, extEvalDataSet, feats, extendT, extendE, normalize, save_data, strcat(feats,'_norm_extA.mat'));


params = struct;
params.SMVprob = '-t 3';

if extendT
	numdata = length(extTrainDataSet) * 8;
else
	numdata = length(extTrainDataSet);
end

subset_size = [0.01,0.02:0.02:1];

% subset_size = [0.01 0.02 0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];

sample_size = floor(numdata * subset_size );

n_trials = ceil(3 * numdata ./ sample_size );

n_trials(end) = 1;


results = cell(length(subset_size),1);

for j1 = 1:length(subset_size)
	results{j1} = zeros(n_trials(j1),4);
end


rng('default');

for k1 = 1:length(subset_size)
	
	disp(['Subset size: ', num2str(subset_size(k1))])
	
	for k2=1:n_trials(k1)
		disp(['Iter: ',num2str(k2),' of ',num2str(n_trials(k1))])
		selection = randperm(numdata);
		
		t_feat_n = t_feat_n_all(selection(1:sample_size(k1)),:);
		
		kstart = 0;
		t_cl = t_cl_all(selection(kstart*sample_size(k1)+1:(kstart+1)*sample_size(k1)));
		
		while abs(sum(t_cl)) == length(t_cl)
			disp('all equal, selecting again')
			kstart = kstart + 1;
			t_cl = t_cl_all(selection(kstart*sample_size(k1)+1:(kstart+1)*sample_size(k1)));
		end
		
		disp(['sample size: ',num2str(length(t_cl))])
		
		res = classify_data( 'pr', params, t_feat_n, t_cl, e_feat_n_all, e_cl_all, extendE, show_data, save_data, strcat('class_',feats,'_p',num2str(subset_size(k1)*100,'%03d'),'_e',num2str(k2,'%03d'),'_norm_extA.mat'), strcat('extA-ds_norm-feat_',feats) );
		
		results{k1}(k2,:) = res(:)';
		
		
	end
end

SVM_AUC = zeros(length(subset_size),2);
SVM_acc = zeros(length(subset_size),2);

RF_AUC = zeros(length(subset_size),2);
RF_acc = zeros(length(subset_size),2);

for j1 = 1:length(subset_size)
	SVM_AUC(j1,1) = mean(results{j1}(:,1));
	SVM_AUC(j1,2) = std(results{j1}(:,1));
	SVM_acc(j1,1) = mean(results{j1}(:,2));
	SVM_acc(j1,2) = std(results{j1}(:,2));
	RF_AUC(j1,1) = mean(results{j1}(:,3));
	RF_AUC(j1,2) = std(results{j1}(:,3));
	RF_acc(j1,1) = mean(results{j1}(:,4));
	RF_acc(j1,2) = std(results{j1}(:,4));
end

h = figure(1);
hold on
title('AUC')
plot(subset_size*100, SVM_AUC(:,1),'b')
plot(subset_size*100, RF_AUC(:,1),'r')
legend('SVM AUC','RF AUC')
ylim([0 1])
hold off

saveas(h,strcat(feats,'/','AUC'),'png');

h =figure(2);
hold on
title('max Accuracy')
plot(subset_size*100, SVM_acc(:,1),'b')
plot(subset_size*100, RF_acc(:,1),'r')
legend('SVM max acc','RF max acc')
ylim([0 1])
hold off

saveas(h,strcat(feats,'/','accuracy'),'png');

h = figure(3);
hold on
title('SVM AUC')
for j1=1:length(subset_size)
	x = ones(n_trials(j1),1) * subset_size(j1)*100;
	plot(x,results{j1}(:,1),'*','Color',[0 0 j1/length(subset_size)])
end
plot(subset_size*100, SVM_AUC(:,1),'b','LineWidth',2)
ylim([0 1])
hold off

saveas(h,strcat(feats,'/','SVM_AUC'),'png');

h = figure(4);
hold on
title('SVM max Accuracy')
for j1=1:length(subset_size)
	x = ones(n_trials(j1),1) * subset_size(j1)*100;
	plot(x,results{j1}(:,2),'*','Color',[0 0 j1/length(subset_size)])
end
plot(subset_size*100, SVM_acc(:,1),'b','LineWidth',2)
ylim([0 1])
hold off

saveas(h,strcat(feats,'/','SVM_accuracy'),'png');


h = figure(5);
hold on
title('RF AUC')
for j1=1:length(subset_size)
	x = ones(n_trials(j1),1) * subset_size(j1)*100;
	plot(x,results{j1}(:,3),'*','Color',[j1/length(subset_size) 0 0])
end
plot(subset_size*100, RF_AUC(:,1),'r','LineWidth',2)
ylim([0 1])
hold off

saveas(h,strcat(feats,'/','RF_AUC'),'png');


h = figure(6);
hold on
title('RF max Accuracy')
for j1=1:length(subset_size)
	x = ones(n_trials(j1),1) * subset_size(j1)*100;
	plot(x,results{j1}(:,4),'*','Color',[j1/length(subset_size) 0 0])
end
plot(subset_size*100, RF_acc(:,1),'r','LineWidth',2)
ylim([0 1])
hold off

saveas(h,strcat(feats,'/','RF_accuracy'),'png');


save('var_size.mat','-regexp','^SVM|^RF|^SC');

diary off