load evalDataSet.mat
load difficulty_groups.mat

thick = 2;

nrows1 = 3;

nrows2 = 6;

ncols = 8;

dims = size(evalDataSet(1).data);

easyC1Image = ones( nrows1*dims(1) + (nrows1-1)*thick, ncols*dims(2) + (ncols-1)*thick, dims(3) );

medC1Image = ones( nrows2*dims(1) + (nrows2-1)*thick, ncols*dims(2) + (ncols-1)*thick, dims(3) );

hardC1Image = ones( nrows1*dims(1) + (nrows1-1)*thick, ncols*dims(2) + (ncols-1)*thick, dims(3) );


easyC0Image = ones( nrows1*dims(1) + (nrows1-1)*thick, ncols*dims(2) + (ncols-1)*thick, dims(3) );

medC10mage = ones( nrows2*dims(1) + (nrows2-1)*thick, ncols*dims(2) + (ncols-1)*thick, dims(3) );

hardC0Image = ones( nrows1*dims(1) + (nrows1-1)*thick, ncols*dims(2) + (ncols-1)*thick, dims(3) );
% size(posTrainImage)

kim = 1;

for k1=1:nrows1
	for k2=1:ncols
		while groups_c1(kim) ~= 0
			kim = kim + 1;
		end
		
		if kim > length(groups_c1)
			break;
		end
			
		easyC1Image((dims(1)+thick)*(k1-1) + 1:(dims(1)+thick)*(k1-1) + dims(1), ...
			(dims(2)+thick)*(k2-1) + 1:(dims(2)+thick)*(k2-1) + dims(1), : ) = evalDataSet(kim).data;
		kim = kim + 1;
		
		if kim > length(groups_c1)
			break;
		end
	end
end

imshow(easyC1Image)

imwrite(easyC1Image,'C1_easy.png');



kim = 1;


for k1=1:nrows2
	for k2=1:ncols
		while groups_c1(kim) ~= 1
			kim = kim + 1;
			if kim > length(groups_c1)
				break;
			end
		end
		
		if kim > length(groups_c1)
			break;
		end
		
		medC1Image((dims(1)+thick)*(k1-1) + 1:(dims(1)+thick)*(k1-1) + dims(1), ...
			(dims(2)+thick)*(k2-1) + 1:(dims(2)+thick)*(k2-1) + dims(1), : ) = evalDataSet(kim).data;
		kim = kim + 1;
		if kim > length(groups_c1)
			break;
		end
	end
end

imshow(medC1Image)

imwrite(medC1Image,'C1_med.png');


kim = 1;

for k1=1:nrows1
	for k2=1:ncols
		while groups_c1(kim) ~= 2
			kim = kim + 1;
			if kim > length(groups_c1)
				break;
			end
		end
		
		if kim > length(groups_c1)
			break;
		end
		
		hardC1Image((dims(1)+thick)*(k1-1) + 1:(dims(1)+thick)*(k1-1) + dims(1), ...
			(dims(2)+thick)*(k2-1) + 1:(dims(2)+thick)*(k2-1) + dims(1), : ) = evalDataSet(kim).data;
		kim = kim + 1;
		
		if kim > length(groups_c1)
			break;
		end
	end
end

imshow(hardC1Image)

imwrite(hardC1Image,'C1_hard.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% trucchetto

groups_c0(2) = 1;
groups_c0(7) = 1;

kim = 1;
cnt = 0;

for k1=1:nrows1
	for k2=1:ncols
		while groups_c0(kim) ~= 0
			kim = kim + 1;
			if kim > length(groups_c0)
				disp('break?????')
				break;
			end
		end
		
		if kim > length(groups_c0)
			disp('break?????')
			break;
		end
		
% 		cnt = cnt + 1
% 		kim + 87
		easyC0Image((dims(1)+thick)*(k1-1) + 1:(dims(1)+thick)*(k1-1) + dims(1), ...
			(dims(2)+thick)*(k2-1) + 1:(dims(2)+thick)*(k2-1) + dims(1), : ) = evalDataSet(kim+87).data;
		kim = kim + 1;
		
		if kim > length(groups_c0)
			break;
		end
	end
end

imshow(easyC0Image)

imwrite(easyC0Image,'C0_easy.png');



kim = 1;

for k1=1:nrows2
	for k2=1:ncols
		while groups_c0(kim) ~= 1  && kim <= length(groups_c0)
			kim = kim + 1;
		end
		
		if kim > length(groups_c0)
			break;
		end
		
		medC0Image((dims(1)+thick)*(k1-1) + 1:(dims(1)+thick)*(k1-1) + dims(1), ...
			(dims(2)+thick)*(k2-1) + 1:(dims(2)+thick)*(k2-1) + dims(1), : ) = evalDataSet(kim+87).data;
		kim = kim + 1;
		
		if kim > length(groups_c0)
			break;
		end
	end
end

imshow(medC0Image)

imwrite(medC0Image,'C0_med.png');


kim = 1;

for k1=1:nrows1
	for k2=1:ncols
		while groups_c0(kim) ~= 2
			kim = kim + 1;
			if kim > length(groups_c0)
				break;
			end
		end
		
		if kim > length(groups_c0)
			break;
		end
		
		
		hardC0Image((dims(1)+thick)*(k1-1) + 1:(dims(1)+thick)*(k1-1) + dims(1), ...
			(dims(2)+thick)*(k2-1) + 1:(dims(2)+thick)*(k2-1) + dims(1), : ) = evalDataSet(kim+87).data;
		kim = kim + 1;
		
		if kim > length(groups_c0)
			break;
		end
	end
end

imshow(hardC0Image)

imwrite(hardC0Image,'C0_hard.png');


