classifications = dir('./class_*.mat');

n = length(classifications);

cl = cell(n,1);



jj = 1;

for k2=1:n
	
	disp(['step ',num2str(k2),' of ',num2str(n)])
	
	cl = load(classifications(k2).name);
	
	fn = fieldnames(cl);
	
	[~, remaind] = strtok(classifications(k2).name,'_');
	feats = strtok(remaind(2:end),'_');

	for k3=1:length(fn)
		if(isempty(strfind(fn{k3},'model')))
			% no model
			res = cl.(fn{k3});
			
			if(~isempty(strfind(classifications(k2).name,'def')))
				expresults(jj).mode = 'def';
			elseif(~isempty(strfind(classifications(k2).name,'extA')))
				expresults(jj).mode = 'extA';
			elseif(~isempty(strfind(classifications(k2).name,'extE')))
				expresults(jj).mode = 'extE';
			elseif(~isempty(strfind(classifications(k2).name,'extT')))
				expresults(jj).mode = 'extT';
			else
				disp(['MODE not recognized! ',classifications(k2).name])
			end

			
			switch fn{k3}
				case 'SVMstd_ext'
					disp 'SVM std ext'
										
					expresults(jj).type = 'SVMstd_ext';
					expresults(jj).feats = feats;
					
					expresults(jj).TPind = find(res.prob_estimates(1:87,1) >= res.thrM );
					expresults(jj).FNind = find(res.prob_estimates(1:87,1) < res.thrM );
					expresults(jj).TNind = find(res.prob_estimates(88:end,1) < res.thrM ) + 87;
					expresults(jj).FPind = find(res.prob_estimates(88:end,1) >= res.thrM ) + 87;
										
				case 'SVMprob'
					disp 'SVM probabilistic'
					
					expresults(jj).type = 'SVMprob';
					expresults(jj).feats = feats;
					
					expresults(jj).TPind = find(res.prob_estimates(1:87,1) >= res.thrM );
					expresults(jj).FNind = find(res.prob_estimates(1:87,1) < res.thrM );
					expresults(jj).TNind = find(res.prob_estimates(88:end,1) < res.thrM ) + 87;
					expresults(jj).FPind = find(res.prob_estimates(88:end,1) >= res.thrM ) + 87;
					
				case 'RF'
					disp 'Random Forests'
					
					expresults(jj).type = 'RF';
					expresults(jj).feats = feats;
					
					expresults(jj).TPind = find(res.probabilities(1:87,1) >= res.thrM );
					expresults(jj).FNind = find(res.probabilities(1:87,1) < res.thrM );
					expresults(jj).TNind = find(res.probabilities(88:end,1) < res.thrM ) + 87;
					expresults(jj).FPind = find(res.probabilities(88:end,1) >= res.thrM ) + 87;
					
				otherwise
					disp(['Classification data not recognized!',fn{k3}])
			end
						
			expresults(jj).TP = length(expresults(jj).TPind);
			expresults(jj).FN = length(expresults(jj).FNind);
			expresults(jj).TN = length(expresults(jj).TNind);
			expresults(jj).FP = length(expresults(jj).FPind);
			
			expresults(jj).AUC = res.AUC;
			expresults(jj).AUH = res.AUH;
			
			expresults(jj).accuracy = res.accM;
			expresults(jj).accuracy_ext = (expresults(jj).TP + expresults(jj).TN) / 174;
			
			expresults(jj).precision = expresults(jj).TP / ( expresults(jj).TP + expresults(jj).FP );
			
			expresults(jj).F1 = 2*expresults(jj).TP / ( 2*expresults(jj).TP + expresults(jj).FN + expresults(jj).FP );
			
			expresults(jj).specificity = expresults(jj).TN / ( expresults(jj).TN + expresults(jj).FP );
			
			expresults(jj).sensitivity = expresults(jj).TP / ( expresults(jj).TP + expresults(jj).FN );
			
			% expRocPlot(sens, spec, hull,accM, accMind, name)
			expRocPlot(res.sens, res.spec, res.hull, res.accM, find(res.thr == res.thrM), strcat(expresults(jj).type,'_',expresults(jj).feats,'_',expresults(jj).mode));

		    jj = jj+1;

		end
		
		
	end
	
	clear(classifications(k2).name);
	
end

fid = fopen('exp03res.txt','w');

fprintf(fid,'Type of exp\tTP\tFN\tTN\tFP\tAUC\tAUH\taccuracy\tprecision\tF1 score\tspecificity\tsensitivity\tacc est\n');

for jj=1:length(expresults)
	fprintf(fid,'%s-%s-%s\t%d\t%d\t%d\t%d\t%6.2f\t%6.2f\t%6.2f%%\t%6.2f%%\t%6.2f\t%6.2f%%\t%6.2f%%\t%6.2f%%\n',...
	expresults(jj).type,expresults(jj).feats,expresults(jj).mode,expresults(jj).TP,expresults(jj).FN,expresults(jj).TN,expresults(jj).FP,...
	expresults(jj).AUC,expresults(jj).AUH,expresults(jj).accuracy*100,expresults(jj).precision*100,expresults(jj).F1,...
	expresults(jj).specificity*100,expresults(jj).sensitivity*100,expresults(jj).accuracy_ext*100);
end

fclose(fid);
% writeTable(expresults);

save('exp01results.mat','expresults')

type exp03res.txt