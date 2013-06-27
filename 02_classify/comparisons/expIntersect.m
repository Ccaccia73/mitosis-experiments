load exp03results.mat

% SVMprob

cl = {'SVMprob','RF'};

feats = {'H','MSiVH','SiU','SiVHU';
	    'iVHL','MSHL','MSiVHR','SHL'};

FNs = cell(size(feats));
FPs = cell(size(feats));


for k1=1:length(cl)
	
	for kf=1:4
		for k2=1:length(expresults)
			% disp([num2str(k2),' search ',feats{k1,kf},' ',cl{k1},' act: ',expresults(k2).feats,'cl: ',expresults(k2).type])
			if strcmp(expresults(k2).type,cl{k1})
				if strcmp(expresults(k2).feats,feats{k1,kf})
					
					FNs{k1,kf} = expresults(k2).FNind;
					FPs{k1,kf} = expresults(k2).FPind;
					
					disp(['found: ',cl{k1},' - feats :',expresults(k2).feats,' at ',num2str(k2)])
					
					break;
				end
			end
		end
	end
end

SVM_FN = [];
SVM_FP = [];

RF_FN = [];
RF_FP = [];


for kk=1:4
	SVM_FN = [SVM_FN;FNs{1,kk}];
	SVM_FP = [SVM_FP;FPs{1,kk}];

	RF_FN = [RF_FN;FNs{2,kk}];
	RF_FP = [RF_FP;FPs{2,kk}];
end

nSVM_FN = hist(SVM_FN,1:87);
nSVM_FP = hist(SVM_FP,88:174);

nRF_FN = hist(RF_FN,1:87);
nRF_FP = hist(RF_FP,88:174);

tot_FN = [SVM_FN;RF_FN];
tot_FP = [SVM_FP;RF_FP];

n_tot_FN = hist(tot_FN,1:87);
n_tot_FP = hist(tot_FP,88:174);
