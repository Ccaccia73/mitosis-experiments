data = dir('./*_perf.mat');

n = length(data);

for k1=1:n
	perf = load(data(k1).name);
	
	feats = strtok(data(k1).name,'_');
	
	name = strcat(feats,'_PCA');
	
	h = figure('visible','off');
	set(h, 'Position', [50 50 1200 800])
	subplot(2,1,1)
	hold on
	plot(cumsum(perf.explained),perf.SVM_AUC,'Color',[0 0 0.8],'LineWidth',2)
	plot(cumsum(perf.explained),perf.RF_AUC,'Color',[0.8 0 0],'LineWidth',2)
	l1 = legend('SVM','RF','Location','SouthEast');
	set(l1,'FontName','Courier New','FontSize',12,'FontWeight','bold')
	xlabel('% of explained variance','FontName','Courier New','FontSize',14,'FontWeight','bold')
	ylabel('AUC','FontName','Courier New','FontSize',14,'FontWeight','bold')
	xlim([perf.explained(1) 100])
	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
	grid
	
	hold off
	subplot(2,1,2)
	hold on
	plot(1:length(perf.SVM_AUC),perf.SVM_AUC,'Color',[0 0 0.8],'LineWidth',2)
	plot(1:length(perf.RF_AUC),perf.RF_AUC,'Color',[0.8 0 0],'LineWidth',2)
	l1 = legend('SVM','RF','Location','SouthEast');
	set(l1,'FontName','Courier New','FontSize',12,'FontWeight','bold')
	xlabel('# of components considered','FontName','Courier New','FontSize',14,'FontWeight','bold')
	ylabel('AUC','FontName','Courier New','FontSize',14,'FontWeight','bold')
	xlim([1 length(perf.SVM_AUC)])
	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
	grid
	hold off
	
	saveas(h,strcat('pca_AUC_',feats),'png');
	saveas(h,strcat('pca_AUC_',feats),'fig');
	
	h = figure('visible','off');
	set(h, 'Position', [50 50 1200 800])
	subplot(2,1,1)
	hold on
	plot(cumsum(perf.explained),perf.SVM_acc,'Color',[0 0 0.8],'LineWidth',2)
	plot(cumsum(perf.explained),perf.RF_acc,'Color',[0.8 0 0],'LineWidth',2)
	l1 = legend('SVM','RF','Location','SouthEast');
	set(l1,'FontName','Courier New','FontSize',12,'FontWeight','bold')
	xlabel('% of explained variance','FontName','Courier New','FontSize',14,'FontWeight','bold')
	ylabel('accuracy','FontName','Courier New','FontSize',14,'FontWeight','bold')
	xlim([perf.explained(1) 100])
	grid
	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
	
	hold off
	subplot(2,1,2)
	hold on
	plot(1:length(perf.SVM_acc),perf.SVM_acc,'Color',[0 0 0.8],'LineWidth',2)
	plot(1:length(perf.RF_acc),perf.RF_acc,'Color',[0.8 0 0],'LineWidth',2)
	l1 = legend('SVM','RF','Location','SouthEast');
	set(l1,'FontName','Courier New','FontSize',12,'FontWeight','bold')
	xlabel('# of components considered','FontName','Courier New','FontSize',14,'FontWeight','bold')
	ylabel('accuracy','FontName','Courier New','FontSize',14,'FontWeight','bold')
	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
	xlim([1 length(perf.SVM_AUC)])
	grid
	hold off
	
	saveas(h,strcat('pca_acc_',feats),'png');
	saveas(h,strcat('pca_acc_',feats),'fig');
end