load('trainDataSet.mat');


for k1=1:length(trainDataSet)
	% id,data, x, y, region, image, class
	extTrainDataSet(k1).id = trainDataSet(k1).id;
	extTrainDataSet(k1).x = trainDataSet(k1).x;
	extTrainDataSet(k1).y = trainDataSet(k1).y;
	extTrainDataSet(k1).region = trainDataSet(k1).region;
	extTrainDataSet(k1).image = trainDataSet(k1).image;
	extTrainDataSet(k1).data{1} = trainDataSet(k1).data;
	extTrainDataSet(k1).class = trainDataSet(k1).class;
	
	for k2=2:4
		extTrainDataSet(k1).data{k2} = imrotate(extTrainDataSet(k1).data{k2-1},90);
	end
	
	for k3=5:8
		extTrainDataSet(k1).data{k3} = flipdim(extTrainDataSet(k1).data{k3-4},2);
	end
end

save('extTrainDataSet.mat','extTrainDataSet');

clear

load('evalDataSet.mat');


for k1=1:length(evalDataSet)
	% id,data, x, y, region, image, class
	extEvalDataSet(k1).id = evalDataSet(k1).id;
	extEvalDataSet(k1).x = evalDataSet(k1).x;
	extEvalDataSet(k1).y = evalDataSet(k1).y;
	extEvalDataSet(k1).region = evalDataSet(k1).region;
	extEvalDataSet(k1).image = evalDataSet(k1).image;
	extEvalDataSet(k1).data{1} = evalDataSet(k1).data;
	extEvalDataSet(k1).class = evalDataSet(k1).class;
	
	for k2=2:4
		extEvalDataSet(k1).data{k2} = imrotate(extEvalDataSet(k1).data{k2-1},90);
	end
	
	for k3=5:8
		extEvalDataSet(k1).data{k3} = flipdim(extEvalDataSet(k1).data{k3-4},2);
	end
end

save('extEvalDataSet.mat','extEvalDataSet');

clear

load('globalDataSet.mat');


for k1=1:length(globalDataSet)
	% id,data, x, y, region, image, class
	extGlobalDataSet(k1).id = globalDataSet(k1).id;
	extGlobalDataSet(k1).x = globalDataSet(k1).x;
	extGlobalDataSet(k1).y = globalDataSet(k1).y;
	extGlobalDataSet(k1).region = globalDataSet(k1).region;
	extGlobalDataSet(k1).image = globalDataSet(k1).image;
	extGlobalDataSet(k1).data{1} = globalDataSet(k1).data;
	extGlobalDataSet(k1).class = globalDataSet(k1).class;
	extGlobalDataSet(k1).train = globalDataSet(k1).train;
	
	for k2=2:4
		extGlobalDataSet(k1).data{k2} = imrotate(extGlobalDataSet(k1).data{k2-1},90);
	end
	
	for k3=5:8
		extGlobalDataSet(k1).data{k3} = flipdim(extGlobalDataSet(k1).data{k3-4},2);
	end
end

save('extGlobalDataSet.mat','extGlobalDataSet');



