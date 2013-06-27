load trainDataSet.mat

thick = 2;

nrows = 5;

ncols = 8;

dims = size(trainDataSet(1).data);

posTrainImage = ones( nrows*dims(1) + (nrows-1)*thick, ncols*dims(2) + (ncols-1)*thick, dims(3) );

% size(posTrainImage)

kim = 1;

for k1=1:nrows
	for k2=1:ncols
		while trainDataSet(kim).class ~= 1
			kim = kim + 1;
		end
		posTrainImage((dims(1)+thick)*(k1-1) + 1:(dims(1)+thick)*(k1-1) + dims(1), ...
			(dims(2)+thick)*(k2-1) + 1:(dims(2)+thick)*(k2-1) + dims(1), : ) = trainDataSet(kim).data;
		kim = kim + 1;
	end
end

imshow(posTrainImage)

imwrite(posTrainImage,'posTrainDataSet.png');


negTrainImage = ones( nrows*dims(1) + (nrows-1)*thick, ncols*dims(2) + (ncols-1)*thick, dims(3) );

% size(posTrainImage)

kim = 1;

for k1=1:nrows
	for k2=1:ncols
		while trainDataSet(kim).class ~= -1
			kim = kim + 1;
		end
		negTrainImage((dims(1)+thick)*(k1-1) + 1:(dims(1)+thick)*(k1-1) + dims(1), ...
			(dims(2)+thick)*(k2-1) + 1:(dims(2)+thick)*(k2-1) + dims(1), : ) = trainDataSet(kim).data;
		kim = kim + 1;
	end
end

imshow(negTrainImage)

imwrite(negTrainImage,'negTrainDataSet.png');
