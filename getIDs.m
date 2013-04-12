%% load training

traindir = '../02_Paper/training/';


load(strcat(traindir,'posTrainSamples.mat'));
load(strcat(traindir,'negTrainSamples.mat'));


%% process train positives

ntr = length(posTrainSamples);


id = 1;		% global id for all
id_tr = 1;	% id for train


for k=1:ntr
	trainDataSet(id).id = id;
	trainDataSet(id).data =  im2double(posTrainSamples{k}.data);
	trainDataSet(id).x = (posTrainSamples{k}.region(1) + posTrainSamples{k}.region(2))/2;
	trainDataSet(id).y = (posTrainSamples{k}.region(3) + posTrainSamples{k}.region(4))/2;
	trainDataSet(id).region = posTrainSamples{k}.region;
	trainDataSet(id).image = posTrainSamples{k}.name(1:6);
	trainDataSet(id).class = 1;	
	
	globalDataSet(id_tr).id = id_tr;
	globalDataSet(id_tr).data =  im2double(posTrainSamples{k}.data);
	globalDataSet(id_tr).x = (posTrainSamples{k}.region(1) + posTrainSamples{k}.region(2))/2;
	globalDataSet(id_tr).y = (posTrainSamples{k}.region(3) + posTrainSamples{k}.region(4))/2;
	globalDataSet(id_tr).image = posTrainSamples{k}.name(1:6);
	globalDataSet(id_tr).region = posTrainSamples{k}.region;
	globalDataSet(id_tr).class = 1;
	globalDataSet(id_tr).train = 1;
	
	id = id + 1;
	id_tr = id_tr + 1;
end


%% process train negatives

% random
rng('default');

tmp_arr = randperm(length(negTrainSamples));

ind = sort(tmp_arr(1:ntr));

for k=1:ntr
	trainDataSet(id).id = id;
	trainDataSet(id).data =  im2double(negTrainSamples{ind(k)}.data);
	trainDataSet(id).x = (negTrainSamples{ind(k)}.region(1) + negTrainSamples{ind(k)}.region(2))/2;
	trainDataSet(id).y = (negTrainSamples{ind(k)}.region(3) + negTrainSamples{ind(k)}.region(4))/2;
	trainDataSet(id).region = negTrainSamples{ind(k)}.region;
	trainDataSet(id).image = negTrainSamples{ind(k)}.name(1:6);
	trainDataSet(id).class = -1;	
	
	globalDataSet(id_tr).id = id_tr;
	globalDataSet(id_tr).data = im2double(negTrainSamples{ind(k)}.data);
	globalDataSet(id_tr).x = (negTrainSamples{ind(k)}.region(1) + negTrainSamples{ind(k)}.region(2))/2;
	globalDataSet(id_tr).y = (negTrainSamples{ind(k)}.region(3) + negTrainSamples{ind(k)}.region(4))/2;
	globalDataSet(id_tr).image = negTrainSamples{ind(k)}.name(1:6);
	globalDataSet(id_tr).region = negTrainSamples{k}.region;
	globalDataSet(id_tr).class = -1;
	globalDataSet(id_tr).train = 1;
	
	id = id + 1;
	id_tr = id_tr + 1;
end

save('trainDataSet.mat','trainDataSet');

%% load evaluation

evaldir = '../02_Paper/evaluation/';

eval_ids_file = '../02_Paper/Performances/IDSIA_ids.csv';

load(strcat(evaldir,'posEvalSamples.mat'));
load(strcat(evaldir,'negEvalSamples.mat'));


fid = fopen(eval_ids_file);
% ID,image,x,y,type,classification(IDSIA)
data = textscan(fid,'%d%s%d%d%d%d','Delimiter',',');
fclose(fid);

%% process evaluation


for k=1:length(data{1})
	
	poss = [posEvalSamples{:}];
	negs = [negEvalSamples{:}];
	
	tmpnames = vertcat(poss.name);
	posnames = cellstr(tmpnames(:,1:6));
	
	
	posreg = vertcat(poss.region);
	
	posx = (posreg(:,1) + posreg(:,2))/2;
	posy = (posreg(:,3) + posreg(:,4))/2;
	
	tmpnames = vertcat(negs.name);
	negnames = cellstr(tmpnames(:,1:6));
	
	negreg = vertcat(negs.region);
	
	negx = (negreg(:,1) + negreg(:,2))/2;
	negy = (negreg(:,3) + negreg(:,4))/2;
	
	
	
	if data{5}(k) == 1
		a1 = find(strcmp(posnames,data{2}(k)));
		a2 = find(posx == data{3}(k));
		a3 = find(posy == data{4}(k));
		
		idfound = intersect(intersect(a1,a2),a3);
		
		n = length(idfound);
		
		switch n
			case 0
				disp('Pos Ahia, non trovato')
			case 1
				disp('Pos OK!')
				tmp_data = im2double(posEvalSamples{idfound}.data);
				tmp_region = posEvalSamples{idfound}.region;
			otherwise
				disp('Pos Troppi!')
		end
	else
		a1 = find(strcmp(negnames,data{2}(k)));
		a2 = find(negx == data{3}(k));
		a3 = find(negy == data{4}(k));
		
		idfound = intersect(intersect(a1,a2),a3);
		
		n = length(idfound);
		
		switch n
			case 0
				disp('Ahia, non trovato')
			case 1
				disp('OK!')
				tmp_data = im2double(negEvalSamples{idfound}.data);
				tmp_region = negEvalSamples{idfound}.region;
				
			otherwise
				disp('Troppi!')
		end
						
	end
	
	if data{5}(k) == 1
		tmp_class = 1;
	else
		tmp_class = -1;
	end

	
	evalDataSet(data{1}(k)).id = double(data{1}(k));
	evalDataSet(data{1}(k)).data =  tmp_data;
	evalDataSet(data{1}(k)).x = double(data{3}(k));
	evalDataSet(data{1}(k)).y = double(data{4}(k));
	evalDataSet(data{1}(k)).region = tmp_region;
	evalDataSet(data{1}(k)).image = data{2}(k);
	evalDataSet(data{1}(k)).class = tmp_class; %double(data{5}(k));	
	
	globalDataSet(2*ntr+data{1}(k)).id = 2*ntr+double(data{1}(k));
	globalDataSet(2*ntr+data{1}(k)).data =  tmp_data;
	globalDataSet(2*ntr+data{1}(k)).x = double(data{3}(k));
	globalDataSet(2*ntr+data{1}(k)).y = double(data{4}(k));
	globalDataSet(2*ntr+data{1}(k)).region = tmp_region;
	globalDataSet(2*ntr+data{1}(k)).image = data{2}(k);
	globalDataSet(2*ntr+data{1}(k)).class = tmp_class; %double(data{5}(k));
	globalDataSet(2*ntr+data{1}(k)).train = 0;
	
end



save('evalDataSet.mat','evalDataSet');
save('globalDataSet.mat','globalDataSet');


	