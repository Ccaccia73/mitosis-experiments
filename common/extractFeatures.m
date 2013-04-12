function [ train_features, train_classes, eval_features, eval_classes, train_features_norm, eval_features_norm ] = extractFeatures(extTrainDataSet, extEvalDataSet, selected_features, ext_train, ext_eval, normalize, save_data, filename )
%extractFeatures extract selected features from dataset
%
%   Parameters:
%	
%	extTrainDataSet: structure containing extended Train Dataset
%	extEvalDataSet: structure containing extended Eval Dataset
%
%	selected_features: string indicating type of features
%	-	m: mean
%	-	s: standard deviation
%	-	i: mean intensity in 25 central regions of the image
%	-	l: lbp 18 features
%	-	v: mean pixel variance
%	-	M: mean per color
%	-	S: std per color
%	-	d: median per color
%	-	H: color histograms
%
%	ext_train: if to use extended trainset (4 rotations and 4 mirrorings)
%
%	ext_eval: if to use extended evalset (4 rotations and 4 mirrorings)
%
%	normalize: if to normalize on the basis of trainset
%
%	save_data: if to save features and classes with name = filename
%				if name not provided filename = 'features.mat'
%
%	Returns:
%	features and classes for selected training and evaluation set
%	if normalize alsto normalized features are returned

%load('../extTrainDataSet.mat');
%load('../extEvalDataSet.mat');


if ext_train
	max_train = 8;
else
	max_train = 1;
end

if ext_eval
	max_eval = 8;
else
	max_eval = 1;
end

neighbors = 8;

train_features = [];
train_classes = zeros(length(extTrainDataSet)*max_train,1);
eval_features = [];
eval_classes = zeros(length(extEvalDataSet)*max_eval,1);

% classes
for k1 = 1:length(extTrainDataSet)
	for k2=1:max_train
		train_classes(max_train*(k1-1) + k2) = extTrainDataSet(k1).class;
	end
end

for k1 = 1:length(extEvalDataSet)
	for k2=1:max_eval
		eval_classes(max_eval*(k1-1) + k2) = extEvalDataSet(k1).class;
	end
end


for j1 = 1:length(selected_features)
	switch (selected_features(j1))
		case 'm'
			disp('Feature <mean> selected')
			
			tmp_train_feat = zeros(length(extTrainDataSet)*max_train,1);
			tmp_eval_feat = zeros(length(extEvalDataSet)*max_eval,1);
			
			for k1 = 1:length(extTrainDataSet)
				for k2=1:max_train
					tmp_train_feat(max_train*(k1-1) + k2) = mean(extTrainDataSet(k1).data{k2}(:));
				end
			end
			
			for k1 = 1:length(extEvalDataSet)
				for k2=1:max_eval
					tmp_eval_feat(max_eval*(k1-1) + k2) = mean(extEvalDataSet(k1).data{k2}(:));
				end
			end
			
			train_features = [train_features, tmp_train_feat];
			eval_features = [eval_features, tmp_eval_feat];
			
		case 's'
			disp('Feature <std> selected')
			
			tmp_train_feat = zeros(length(extTrainDataSet)*max_train,1);
			tmp_eval_feat = zeros(length(extEvalDataSet)*max_eval,1);
			
			for k1 = 1:length(extTrainDataSet)
				for k2=1:max_train
					tmp_train_feat(max_train*(k1-1) + k2) = std(extTrainDataSet(k1).data{k2}(:));
				end
			end
			
			for k1 = 1:length(extEvalDataSet)
				for k2=1:max_eval
					tmp_eval_feat(max_eval*(k1-1) + k2) = std(extEvalDataSet(k1).data{k2}(:));
				end
			end
			
			train_features = [train_features, tmp_train_feat];
			eval_features = [eval_features, tmp_eval_feat];
			
		case 'i'
			disp('Feature <25 central intensities> selected')
			
			tmp_train_feat = zeros(length(extTrainDataSet)*max_train,25);
			tmp_eval_feat = zeros(length(extEvalDataSet)*max_eval,25);
			
			for k1 = 1:length(extTrainDataSet)
				for k2=1:max_train					
					imc = extTrainDataSet(k1).data{k2}(26:75,26:75,:);	%central part of image
					imcg = rgb2gray(imc);								% grayscale
					imcgs = imresize(imcg,[5 5]);						% resized 5x5
					tmp_train_feat(max_train*(k1-1) + k2,:) = imcgs(:)';
				end
			end
			
			for k1 = 1:length(extEvalDataSet)
				for k2=1:max_eval
					imc = extEvalDataSet(k1).data{k2}(26:75,26:75,:);	%central part of image
					imcg = rgb2gray(imc);								% grayscale
					imcgs = imresize(imcg,[5 5]);						% resized 5x5
					tmp_eval_feat(max_eval*(k1-1) + k2,:) = imcgs(:)';
				end
			end
			
			train_features = [train_features, tmp_train_feat];
			eval_features = [eval_features, tmp_eval_feat];
			
		case 'l'
			disp('Feature <18 riu2 local binary pattern> selected')
			
			mapping=getmapping(neighbors,'riu2');
			
			nf = length(lbp(extEvalDataSet(1).data{1},1,neighbors,mapping,'nh'));
			
			tmp_train_feat = zeros(length(extTrainDataSet)*max_train,nf);
			tmp_eval_feat = zeros(length(extEvalDataSet)*max_eval,nf);
			
			for k1 = 1:length(extTrainDataSet)
				for k2=1:max_train
					tmp_train_feat(max_train*(k1-1) + k2,:) = lbp(rgb2gray(extTrainDataSet(k1).data{k2}(26:75,26:75,:)),1,neighbors,mapping,'nh');
				end
			end
			
			for k1 = 1:length(extEvalDataSet)
				for k2=1:max_eval
					tmp_eval_feat(max_eval*(k1-1) + k2,:) = lbp(rgb2gray(extEvalDataSet(k1).data{k2}(26:75,26:75,:)),1,neighbors,mapping,'nh');
				end
			end
			
			train_features = [train_features, tmp_train_feat];
			eval_features = [eval_features, tmp_eval_feat];
			
		case 'v'
			disp('Feature <mean of pixel Variance> selected')
			
			tmp_train_feat = zeros(length(extTrainDataSet)*max_train,1);
			tmp_eval_feat = zeros(length(extEvalDataSet)*max_eval,1);
			
			for k1 = 1:length(extTrainDataSet)
				for k2=1:max_train
					c1 = cont(rgb2gray(extTrainDataSet(k1).data{k2}(26:75,26:75,:)),4,16);
					tmp_train_feat(max_train*(k1-1) + k2) = mean(c1(:));
				end
			end
			
			for k1 = 1:length(extEvalDataSet)
				for k2=1:max_eval
					c1 = cont(cont(rgb2gray(extEvalDataSet(k1).data{k2}(26:75,26:75,:)),4,16));
					tmp_eval_feat(max_eval*(k1-1) + k2) = mean(c1(:));
				end
			end
			
			train_features = [train_features, tmp_train_feat];
			eval_features = [eval_features, tmp_eval_feat];
		case 'M'
			disp('Feature <mean per color> selected')
						
			tmp_train_feat = zeros(length(extTrainDataSet)*max_train,3);
			tmp_eval_feat = zeros(length(extEvalDataSet)*max_eval,3);
			
			for k1 = 1:length(extTrainDataSet)
				for k2=1:max_train
					for k3=1:3
						tmp_im = extTrainDataSet(k1).data{k2}(:,:,k3);
						tmp_train_feat(max_train*(k1-1) + k2,k3) = mean(tmp_im(:));
					end
				end
			end
			
			for k1 = 1:length(extEvalDataSet)
				for k2=1:max_eval
					for k3=1:3
						tmp_im = extEvalDataSet(k1).data{k2}(:,:,k3);
						tmp_eval_feat(max_eval*(k1-1) + k2,k3) = mean(tmp_im(:));
					end
				end
			end
			
			train_features = [train_features, tmp_train_feat];
			eval_features = [eval_features, tmp_eval_feat];
	
		case 'S'
			disp('Feature <std per color> selected')
						
			tmp_train_feat = zeros(length(extTrainDataSet)*max_train,3);
			tmp_eval_feat = zeros(length(extEvalDataSet)*max_eval,3);
			
			for k1 = 1:length(extTrainDataSet)
				for k2=1:max_train
					for k3=1:3
						tmp_im = extTrainDataSet(k1).data{k2}(:,:,k3);
						tmp_train_feat(max_train*(k1-1) + k2,k3) = std(tmp_im(:));
					end
				end
			end
			
			for k1 = 1:length(extEvalDataSet)
				for k2=1:max_eval
					for k3=1:3
						tmp_im = extEvalDataSet(k1).data{k2}(:,:,k3);
						tmp_eval_feat(max_eval*(k1-1) + k2,k3) = std(tmp_im(:));
					end
				end
			end
			
			train_features = [train_features, tmp_train_feat];
			eval_features = [eval_features, tmp_eval_feat];
	
			
		case 'd'
			disp('Feature <median per color> selected')
						
			tmp_train_feat = zeros(length(extTrainDataSet)*max_train,3);
			tmp_eval_feat = zeros(length(extEvalDataSet)*max_eval,3);
			
			for k1 = 1:length(extTrainDataSet)
				for k2=1:max_train
					for k3=1:3
						tmp_train_feat(max_train*(k1-1) + k2,k3) = median(median(extTrainDataSet(k1).data{k2}(:,:,k3),1),2);
					end
				end
			end
			
			for k1 = 1:length(extEvalDataSet)
				for k2=1:max_eval
					for k3=1:3
						tmp_eval_feat(max_eval*(k1-1) + k2,k3) = median(median(extEvalDataSet(k1).data{k2}(:,:,k3),1),2);
					end
				end
			end
			
			train_features = [train_features, tmp_train_feat];
			eval_features = [eval_features, tmp_eval_feat];

		case 'H'
			disp('Feature <histograms of color distributions> selected')
			
			nbins = 16;
			
			tmp_train_feat = zeros(length(extTrainDataSet)*max_train,3*nbins);
			tmp_eval_feat = zeros(length(extEvalDataSet)*max_eval,3*nbins);
			
			for k1 = 1:length(extTrainDataSet)
				for k2=1:max_train
					for k3=1:3
						tmp_train_feat(max_train*(k1-1) + k2,nbins*(k3-1)+1:nbins*k3) = imhist(extTrainDataSet(k1).data{k2}(:,:,k3),nbins);
					end
				end
			end
			
			for k1 = 1:length(extEvalDataSet)
				for k2=1:max_eval
					for k3=1:3
						tmp_eval_feat(max_eval*(k1-1) + k2,nbins*(k3-1)+1:nbins*k3) = imhist(extEvalDataSet(k1).data{k2}(:,:,k3),nbins);
					end
				end
			end
			
			train_features = [train_features, tmp_train_feat];
			eval_features = [eval_features, tmp_eval_feat];
			
		case 'L'
			disp('Feature <18 riu2 local binary pattern> selected 3 different RADII 1-2-3')
			
			mapping=getmapping(neighbors,'riu2');
			
			nf = length(lbp(extEvalDataSet(1).data{1},1,neighbors,mapping,'nh'))*3;
			
			disp(['number of features: ',num2str(nf)]);
			
			tmp_train_feat = zeros(length(extTrainDataSet)*max_train,nf);
			tmp_eval_feat = zeros(length(extEvalDataSet)*max_eval,nf);
			
			for k1 = 1:length(extTrainDataSet)
				for k2=1:max_train
					tmp_train_feat(max_train*(k1-1) + k2,:) = [lbp(rgb2gray(extTrainDataSet(k1).data{k2}(26:75,26:75,:)),1,neighbors,mapping,'nh'), ...
																lbp(rgb2gray(extTrainDataSet(k1).data{k2}(26:75,26:75,:)),2,neighbors,mapping,'nh'),...
																lbp(rgb2gray(extTrainDataSet(k1).data{k2}(26:75,26:75,:)),3,neighbors,mapping,'nh')];
				end
			end
			
			for k1 = 1:length(extEvalDataSet)
				for k2=1:max_eval
					tmp_eval_feat(max_eval*(k1-1) + k2,:) = [lbp(rgb2gray(extEvalDataSet(k1).data{k2}(26:75,26:75,:)),1,neighbors,mapping,'nh'), ...
															 lbp(rgb2gray(extEvalDataSet(k1).data{k2}(26:75,26:75,:)),2,neighbors,mapping,'nh'), ...
															 lbp(rgb2gray(extEvalDataSet(k1).data{k2}(26:75,26:75,:)),3,neighbors,mapping,'nh')];
				end
			end
			
			train_features = [train_features, tmp_train_feat];
			eval_features = [eval_features, tmp_eval_feat];
			
		case 'r'
			disp('Feature <ri local binary pattern> selected')
			
			mapping=getmapping(neighbors,'ri');
			
			nf = length(lbp(rgb2gray(extTrainDataSet(k1).data{k2}(26:75,26:75,:)),1,neighbors,mapping,'nh'));
			
			disp(['number of features: ',num2str(nf)]);
			
			tmp_train_feat = zeros(length(extTrainDataSet)*max_train,nf);
			tmp_eval_feat = zeros(length(extEvalDataSet)*max_eval,nf);
			
			for k1 = 1:length(extTrainDataSet)
				for k2=1:max_train
					tmp_train_feat(max_train*(k1-1) + k2,:) = lbp(rgb2gray(extTrainDataSet(k1).data{k2}(26:75,26:75,:)),1,neighbors,mapping,'nh');
				end
			end
			
			for k1 = 1:length(extEvalDataSet)
				for k2=1:max_eval
					tmp_eval_feat(max_eval*(k1-1) + k2,:) = lbp(rgb2gray(extEvalDataSet(k1).data{k2}(26:75,26:75,:)),1,neighbors,mapping,'nh');
				end
			end
			
			train_features = [train_features, tmp_train_feat];
			eval_features = [eval_features, tmp_eval_feat];
			
		case 'u'
			disp('Feature <u2 local binary pattern> selected')
			
			mapping=getmapping(neighbors,'u2');
			
			nf = length(lbp(extEvalDataSet(1).data{1},1,neighbors,mapping,'nh'));
			
			disp(['number of features: ',num2str(nf)]);
			
			tmp_train_feat = zeros(length(extTrainDataSet)*max_train,nf);
			tmp_eval_feat = zeros(length(extEvalDataSet)*max_eval,nf);
			
			for k1 = 1:length(extTrainDataSet)
				for k2=1:max_train
					tmp_train_feat(max_train*(k1-1) + k2,:) = lbp(rgb2gray(extTrainDataSet(k1).data{k2}(26:75,26:75,:)),1,neighbors,mapping,'nh');
				end
			end
			
			for k1 = 1:length(extEvalDataSet)
				for k2=1:max_eval
					tmp_eval_feat(max_eval*(k1-1) + k2,:) = lbp(rgb2gray(extEvalDataSet(k1).data{k2}(26:75,26:75,:)),1,neighbors,mapping,'nh');
				end
			end
			
			train_features = [train_features, tmp_train_feat];
			eval_features = [eval_features, tmp_eval_feat];
			
		case 'V'
			disp('Feature <pixel Variance - histogram> selected')
			
			tmp_train_feat = zeros(length(extTrainDataSet)*max_train,36);
			tmp_eval_feat = zeros(length(extEvalDataSet)*max_eval,36);
			
			for k1 = 1:length(extTrainDataSet)
				for k2=1:max_train
					tmp_feat01 = cont(rgb2gray(extTrainDataSet(k1).data{k2}(26:75,26:75,:)),1,neighbors);
					tmp_feat02 = imresize(tmp_feat01,[6 6]);
					tmp_train_feat(max_train*(k1-1) + k2,:) = tmp_feat02(:)';
				end
			end
			
			for k1 = 1:length(extEvalDataSet)
				for k2=1:max_eval
					tmp_feat01 = cont(rgb2gray(extEvalDataSet(k1).data{k2}(26:75,26:75,:)),2,neighbors);
					tmp_feat02 = imresize(tmp_feat01,[6 6]);
					tmp_eval_feat(max_eval*(k1-1) + k2,:) = tmp_feat02(:)';
				end
			end
			
			train_features = [train_features, tmp_train_feat];
			eval_features = [eval_features, tmp_eval_feat];
		otherwise
			disp('Feature not recognized')
	end
	
end


if normalize
	[train_features_norm, m_t, std_t] = normalizeF(train_features);
	eval_features_norm = normalizeF(eval_features, m_t, std_t);
end

if save_data
	if exist('filename','var')
		if isempty(strfind(filename,'.mat'))
			filename = strcat(filename,'.mat');
		end
	else
		filename = 'features.mat';
	end
	
	if normalize
		save(filename,'selected_features','train_features','train_classes','eval_features','eval_classes','train_features_norm','eval_features_norm');
	else
		save(filename,'selected_features','train_features','train_classes','eval_features','eval_classes');
	end
end

