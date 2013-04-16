
load('../../extTrainDataSet.mat');
load('../../extEvalDataSet.mat');

% features_type = 'MSidHLV';
% features_type = 'MSidHUV';
features_type = 'MSidHRV';


% number of features
n = length(features_type);

LL = 11:10:101;

nl = length(LL);


combinations = dec2bin(1:2^n-1,n);


extendT = true;
extendE = true;
normalize = true;
save_data = false;
show_data = true;


te_data = cell(n,nl,4);

for j1=1:n
	for j2=1:nl
	% (train - features STD) - train class - (eval features STD) - eval class - train
	% features NORM - eval features NORM
	[ ~, te_data{j1,j2,2}, ~, te_data{j1,j2,4}, te_data{j1,j2,1}, te_data{j1,j2,3} ] = ...
	L_extractFeatures(extTrainDataSet, extEvalDataSet, features_type(j1), extendT, extendE, normalize, save_data, strcat(features_type(j1),'_norm_extA.mat'),LL(j2) );
	end
end

save(strcat('features_',features_type,'.mat'),'te_data');

