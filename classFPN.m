load evalDataSet.mat
load class_diffic.mat

figure(1)

for k1=1:length(common_fn)
	subplot(2,3,k1)
	
	subimage(evalDataSet(common_fn(k1)).data)
	switch fn_diffic(k1)
		case 0
			Etype = 'easy';
		case 1
			Etype = 'medium';
		case 2
			Etype = 'hard';
	end
	
	title(strcat(Etype,' f=',num2str(fn_freq(k1))),'FontName','Courier New','FontSize',16,'FontWeight','bold');
	set(gca,'YTick',[])
	set(gca,'XTick',[])
end

figure(2)

for k1=1:length(common_fp)
	subplot(4,4,k1)
	
	subimage(evalDataSet(common_fp(k1)+87).data)
	switch fp_diffic(k1)
		case 0
			Etype = 'easy';
		case 1
			Etype = 'medium';
		case 2
			Etype = 'hard';
	end
	
	title(strcat(Etype,' f=',num2str(fp_freq(k1))),'FontName','Courier New','FontSize',15,'FontWeight','bold');
	set(gca,'YTick',[])
	set(gca,'XTick',[])
end



