classifications = dir('./*.mat');

fid = fopen('exp03res_tot.txt','w');

for k1=1:length(classifications)
	feats = strtok(classifications(k1).name,'_');
	
	res = load(classifications(k1).name);
	
	% AUC
	
	[~,ind] = sort(res.RF_AUC);
	
	f1 = figure('visible','off');
	hold on
	plot(1:63,res.RF_AUC(ind),'LineWidth',2,'Color',[0 0 .75])
	plot(1:63,res.SVM_AUC(ind),'LineWidth',2,'Color',[0.75 0 0])
	xlim([1 63])
	ylim([0 1])
	l1 = legend('RF AUC','SVM AUC','Location','SouthEast');
	set(l1,'FontName','Courier New','FontSize',12,'FontWeight','bold')
	xlabel('Features','FontName','Courier New','FontSize',14,'FontWeight','bold')
	ylabel('AUC','FontName','Courier New','FontSize',14,'FontWeight','bold')
	title('AUC for SVM and RF','FontName','Courier New','FontSize',18,'FontWeight','bold','FontAngle','italic')
	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
	set(gca, 'XTick', []);
	hold off
	
	name = strcat(feats,'_sortAUC');
	
	print(f1,'-dpng','-r300',strcat(name,'.png'))
	% print(f1,'-depsc2','-r300','ROC1')
	saveas(gcf,name,'fig')
	
	fprintf(fid,'Best RF AUC: %8.4f - features: %s',res.RF_AUC(ind(end)),res.feat_list{ind(end)});
	fprintf(fid,'Worst RF AUC: %8.4f - features: %s',res.RF_AUC(ind(1)),res.feat_list{ind(1)});
	
	[~,ma] = max(res.SVM_AUC); 
	[~,mi] = min(res.SVM_AUC);
	

	
	fprintf(fid,'Best SVM AUC: %8.4f - features: %s',res.SVM_AUC(ma),res.feat_list{ma});
	fprintf(fid,'Worst SVM AUC: %8.4f - features: %s',res.RF_AUC(mi),res.feat_list{mi});
	
	
	% acc
	
	[~,ind] = sort(res.RF_acc);
	
	f1 = figure('visible','off');
	hold on
	plot(1:63,res.RF_acc(ind),'LineWidth',2,'Color',[0 0 .75])
	plot(1:63,res.SVM_acc(ind),'LineWidth',2,'Color',[0.75 0 0])
	xlim([1 63])
	ylim([0 1])
	l1 = legend('RF accuracy','SVM accuracy','Location','SouthEast');
	set(l1,'FontName','Courier New','FontSize',12,'FontWeight','bold')
	xlabel('Features','FontName','Courier New','FontSize',14,'FontWeight','bold')
	ylabel('accuracy','FontName','Courier New','FontSize',14,'FontWeight','bold')
	title('accuracy for SVM and RF','FontName','Courier New','FontSize',18,'FontWeight','bold','FontAngle','italic')
	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
	set(gca, 'XTick', []);
	hold off
	
	name = strcat(feats,'_sortAccuracy');
	
	print(f1,'-dpng','-r300',strcat(name,'.png'))
	% print(f1,'-depsc2','-r300','ROC1')
	saveas(gcf,name,'fig')
	
	fprintf(fid,'Best RF acc: %8.4f - features: %s',res.RF_acc(ind(end)),res.feat_list{ind(end)});
	fprintf(fid,'Worst RF acc: %8.4f - features: %s',res.RF_acc(ind(1)),res.feat_list{ind(1)});
	
	[~,ma] = max(res.SVM_acc); 
	[~,mi] = min(res.SVM_acc);
	
	fprintf(fid,'Best SVM acc: %8.4f - features: %s',res.SVM_acc(ma),res.feat_list{ma});
	fprintf(fid,'Worst SVM acc: %8.4f - features: %s',res.RF_acc(mi),res.feat_list{mi});
	
	
end



fclose(fid);