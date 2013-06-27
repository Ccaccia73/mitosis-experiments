data = dir('./*.mat');

n = length(data);

for k1=1:n
	perf = load(data(k1).name);
	
	feats = strtok(data(k1).name,'_');
	
	% results: SVM AUC - SVM acc - RF AUC - RF acc
	
	name = strcat(feats,'_trials');
	
	f1 = figure('visible','off');
	plot(perf.subset_size * 100, perf.n_trials,'-x','LineWidth',2,'Color',[0 0 .5])
	xlim([0 100])
	ylim([1 310])
	xlabel('Subset size [%]','FontName','Courier New','FontSize',14,'FontWeight','bold')
	ylabel('# Trials','FontName','Courier New','FontSize',14,'FontWeight','bold')
	title('Sample size and Trials','FontName','Courier New','FontSize',18,'FontWeight','bold','FontAngle','italic')
	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
	
	print(f1,'-dpng','-r300',strcat(name,'.png'))
	% print(f1,'-depsc2','-r300','ROC1')
	saveas(gcf,name,'fig')
	
	ntr = length(perf.results);
	
	SVM_AUC = zeros(ntr,2);
	SVM_acc = zeros(ntr,2);
	
	RF_AUC = zeros(ntr,2);
	RF_acc = zeros(ntr,2);
	
	for j1 = 1:ntr
		
		tmp_SVM_AUC = perf.results{j1}(:,1);
		tmp_SVM_acc = perf.results{j1}(:,2);
		tmp_RF_AUC = perf.results{j1}(:,3);
		tmp_RF_acc = perf.results{j1}(:,4);
		
% 		if j1>5
% 			SVM_AUC(j1,1) = mean(tmp_SVM_AUC(tmp_SVM_AUC>0.5));
% 			SVM_AUC(j1,2) = std(tmp_SVM_AUC(tmp_SVM_AUC>0.5));
% 			SVM_acc(j1,1) = mean(tmp_SVM_acc(tmp_SVM_acc>0.5));
% 			SVM_acc(j1,2) = std(tmp_SVM_acc(tmp_SVM_acc>0.5));
% 			RF_AUC(j1,1) = mean(tmp_RF_AUC(tmp_RF_AUC>0.5));
% 			RF_AUC(j1,2) = std(tmp_RF_AUC(tmp_RF_AUC>0.5));
% 			RF_acc(j1,1) = mean(tmp_RF_acc(tmp_RF_acc>0.5));
% 			RF_acc(j1,2) = std(tmp_RF_acc(tmp_RF_acc>0.5));
% 		else
			SVM_AUC(j1,1) = mean(tmp_SVM_AUC);
			SVM_AUC(j1,2) = std(tmp_SVM_AUC);
			SVM_acc(j1,1) = mean(tmp_SVM_acc);
			SVM_acc(j1,2) = std(tmp_SVM_acc);
			RF_AUC(j1,1) = mean(tmp_RF_AUC);
			RF_AUC(j1,2) = std(tmp_RF_AUC);
			RF_acc(j1,1) = mean(tmp_RF_acc);
			RF_acc(j1,2) = std(tmp_RF_acc);
% 		end
	end
	
	f1 = figure('visible','off');
	hold on
	title('AUC','FontName','Courier New','FontSize',18,'FontWeight','bold','FontAngle','italic')
	plot(perf.subset_size*100, SVM_AUC(:,1),'b')
	plot(perf.subset_size*100, RF_AUC(:,1),'r')
	l1 = legend('SVM AUC','RF AUC','Location','SouthEast');
	set(l1,'FontName','Courier New','FontSize',12,'FontWeight','bold')
	xlabel('Subset size [%]','FontName','Courier New','FontSize',14,'FontWeight','bold')
	ylabel('AUC','FontName','Courier New','FontSize',14,'FontWeight','bold')
	ylim([0 1])
	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
	hold off
	
	name = strcat(feats,'_AUC_tot');
	print(f1,'-dpng','-r300',strcat(name,'.png'))
	% print(f1,'-depsc2','-r300','ROC1')
	saveas(gcf,name,'fig')
	
	f1 =figure('visible','off');
	hold on
	title('max Accuracy','FontName','Courier New','FontSize',18,'FontWeight','bold','FontAngle','italic')
	plot(perf.subset_size*100, SVM_acc(:,1),'b')
	plot(perf.subset_size*100, RF_acc(:,1),'r')
	xlabel('Subset size [%]','FontName','Courier New','FontSize',14,'FontWeight','bold')
	ylabel('accuracy','FontName','Courier New','FontSize',14,'FontWeight','bold')
	l1 = legend('SVM max acc','RF max acc','Location','SouthEast');
	set(l1,'FontName','Courier New','FontSize',12,'FontWeight','bold')
	ylim([0 1])
	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
	hold off
	
	name = strcat(feats,'_acc_tot');
	print(f1,'-dpng','-r300',strcat(name,'.png'))
	% print(f1,'-depsc2','-r300','ROC1')
	saveas(gcf,name,'fig')

	
	f1 = figure('visible','off');
	hold on
	title('SVM AUC','FontName','Courier New','FontSize',18,'FontWeight','bold','FontAngle','italic')
	for j1=1:length(perf.subset_size)
		x = ones(perf.n_trials(j1),1) * perf.subset_size(j1)*100;
		plot(x,perf.results{j1}(:,1),'*','Color',[0 0 j1/length(perf.subset_size)])
	end
	plot(perf.subset_size*100, SVM_AUC(:,1),'b','LineWidth',2)
	ylim([0 1])
	xlabel('Subset size [%]','FontName','Courier New','FontSize',14,'FontWeight','bold')
	ylabel('AUC','FontName','Courier New','FontSize',14,'FontWeight','bold')
	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
	hold off
	
	name = strcat(feats,'_SVM_AUC');
	print(f1,'-dpng','-r300',strcat(name,'.png'))
	% print(f1,'-depsc2','-r300','ROC1')
	saveas(gcf,name,'fig')
	
	f1 = figure('visible','off');
	hold on
	title('SVM max Accuracy','FontName','Courier New','FontSize',18,'FontWeight','bold','FontAngle','italic')
	for j1=1:length(perf.subset_size)
		x = ones(perf.n_trials(j1),1) * perf.subset_size(j1)*100;
		plot(x,perf.results{j1}(:,2),'*','Color',[0 0 j1/length(perf.subset_size)])
	end
	plot(perf.subset_size*100, SVM_acc(:,1),'b','LineWidth',2)
	ylim([0 1])
	xlabel('Subset size [%]','FontName','Courier New','FontSize',14,'FontWeight','bold')
	ylabel('max accuracy','FontName','Courier New','FontSize',14,'FontWeight','bold')
	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
	hold off
	
	name = strcat(feats,'_SVM_acc');
	print(f1,'-dpng','-r300',strcat(name,'.png'))
	% print(f1,'-depsc2','-r300','ROC1')
	saveas(gcf,name,'fig')
	
	
	f1 = figure('visible','off');
	hold on
	title('RF AUC','FontName','Courier New','FontSize',18,'FontWeight','bold','FontAngle','italic')
	for j1=1:length(perf.subset_size)
		x = ones(perf.n_trials(j1),1) * perf.subset_size(j1)*100;
		plot(x,perf.results{j1}(:,3),'*','Color',[j1/length(perf.subset_size) 0 0])
	end
	plot(perf.subset_size*100, RF_AUC(:,1),'r','LineWidth',2)
	ylim([0 1])
	xlabel('Subset size [%]','FontName','Courier New','FontSize',14,'FontWeight','bold')
	ylabel('AUC','FontName','Courier New','FontSize',14,'FontWeight','bold')
	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
	hold off
	
	name = strcat(feats,'_RF_AUC');
	print(f1,'-dpng','-r300',strcat(name,'.png'))
	% print(f1,'-depsc2','-r300','ROC1')
	saveas(gcf,name,'fig')
	
	
	f1 = figure('visible','off');
	hold on
	title('RF max Accuracy','FontName','Courier New','FontSize',18,'FontWeight','bold','FontAngle','italic')
	for j1=1:length(perf.subset_size)
		x = ones(perf.n_trials(j1),1) * perf.subset_size(j1)*100;
		plot(x,perf.results{j1}(:,4),'*','Color',[j1/length(perf.subset_size) 0 0])
	end
	plot(perf.subset_size*100, RF_acc(:,1),'r','LineWidth',2)
	ylim([0 1])
	xlabel('Subset size [%]','FontName','Courier New','FontSize',14,'FontWeight','bold')
	ylabel('max accuracy','FontName','Courier New','FontSize',14,'FontWeight','bold')
	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
	hold off
	
	name = strcat(feats,'_RF_acc');
	print(f1,'-dpng','-r300',strcat(name,'.png'))
	% print(f1,'-depsc2','-r300','ROC1')
	saveas(gcf,name,'fig')
	
end
