data = dir('./*_results.mat');

n = length(data);

for k1=1:1%n
	
	switch k1
		case 1
			perf = load(data(k1).name);
			
			feats = strtok(data(k1).name,'_');
			
			name = strcat(feats,'_L');
			
			cumul = sum(perf.SVM_AUC(:,1:5),2);
			[~, ind] = sort(cumul);
			
			SVM_AUC_H = perf.SVM_AUC(ind(1:66),:);
			SVM_AUC_oth = perf.SVM_AUC(ind(67:127),:);
			
			cm1 = sum(SVM_AUC_H,2);
			[~, ind1] = sort(cm1);
			
			f1 = figure(1);
			set(f1, 'Position', [50 50 1200 800])
			surf(10:10:100,3:66,SVM_AUC_H(ind1(3:66),:))
			hc = colorbar('EastOutside');
			xlabel('L [pixel]','FontName','Courier New','FontSize',13,'FontWeight','bold')
			ylabel('feature set','FontName','Courier New','FontSize',13,'FontWeight','bold')
			zlabel('AUC','FontName','Courier New','FontSize',13,'FontWeight','bold')
			title('AUC for SVM - with Color Histogram','FontName','Courier New','FontSize',16,'FontWeight','bold','FontAngle','italic')
			set(gca,'FontName','Courier New','FontSize',12,'FontWeight','bold')
			set(gca,'YTick',[])
			set(gca,'XTick',10:10:100)
			xlim([10 100])
			
			cm2 = sum(SVM_AUC_oth,2);
			[~, ind2] = sort(cm2);
			
			f1 = figure(2);
			set(f1, 'Position', [50 50 1200 800])
			surf(10:10:100,112:127,SVM_AUC_oth(ind2(end-15:end),:))
			hc = colorbar('EastOutside');
			xlabel('L [pixel]','FontName','Courier New','FontSize',13,'FontWeight','bold')
			ylabel('feature set','FontName','Courier New','FontSize',13,'FontWeight','bold')
			zlabel('AUC','FontName','Courier New','FontSize',13,'FontWeight','bold')
			title('AUC for SVM - with LV','FontName','Courier New','FontSize',16,'FontWeight','bold','FontAngle','italic')
			set(gca,'FontName','Courier New','FontSize',12,'FontWeight','bold')
			set(gca,'YTick',[])
			set(gca,'XTick',10:10:100)
			xlim([10 100])
			
			cumul_rf = sum(perf.RF_AUC,2);
			[~, ind_rf] = sort(cumul_rf);
			
			f1 = figure(3);
			set(f1, 'Position', [50 50 1200 800])
			surf(10:10:100,88:127,perf.RF_AUC(ind_rf(88:127),:))
			hc = colorbar('EastOutside');
			xlabel('L [pixel]','FontName','Courier New','FontSize',13,'FontWeight','bold')
			ylabel('feature set','FontName','Courier New','FontSize',13,'FontWeight','bold')
			zlabel('AUC','FontName','Courier New','FontSize',13,'FontWeight','bold')
			title('AUC for RF - with HLV','FontName','Courier New','FontSize',16,'FontWeight','bold','FontAngle','italic')
			set(gca,'FontName','Courier New','FontSize',12,'FontWeight','bold')
			set(gca,'YTick',[])
			set(gca,'XTick',10:10:100)
			xlim([10 100])

% 			f1 = figure(4);
% 			set(f1, 'Position', [50 50 1200 800])
% 			surf(10:10:100,2:10,perf.RF_AUC(2:10,:))
% 			xlabel('L [pixel]','FontName','Courier New','FontSize',13,'FontWeight','bold')
% 			ylabel('feature set','FontName','Courier New','FontSize',13,'FontWeight','bold')
% 			zlabel('AUC','FontName','Courier New','FontSize',13,'FontWeight','bold')
% 			title('AUC for RF - with HLV','FontName','Courier New','FontSize',16,'FontWeight','bold','FontAngle','italic')
% 			set(gca,'FontName','Courier New','FontSize',12,'FontWeight','bold')
% 			% set(gca,'YTick',[])
% 			set(gca,'XTick',10:10:100)
% 			xlim([10 100])
			
			
		case 2
			
			
	end
	
% 	h = figure('visible','off');
% 	set(h, 'Position', [50 50 1200 800])
% 	subplot(2,1,1)
% 	hold on
% 	plot(cumsum(perf.explained),perf.SVM_AUC,'Color',[0 0 0.8],'LineWidth',2)
% 	plot(cumsum(perf.explained),perf.RF_AUC,'Color',[0.8 0 0],'LineWidth',2)
% 	l1 = legend('SVM','RF','Location','SouthEast');
% 	set(l1,'FontName','Courier New','FontSize',12,'FontWeight','bold')
% 	xlabel('% of explained variance','FontName','Courier New','FontSize',14,'FontWeight','bold')
% 	ylabel('AUC','FontName','Courier New','FontSize',14,'FontWeight','bold')
% 	xlim([perf.explained(1) 100])
% 	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
% 	grid
% 	
% 	hold off
% 	subplot(2,1,2)
% 	hold on
% 	plot(1:length(perf.SVM_AUC),perf.SVM_AUC,'Color',[0 0 0.8],'LineWidth',2)
% 	plot(1:length(perf.RF_AUC),perf.RF_AUC,'Color',[0.8 0 0],'LineWidth',2)
% 	l1 = legend('SVM','RF','Location','SouthEast');
% 	set(l1,'FontName','Courier New','FontSize',12,'FontWeight','bold')
% 	xlabel('# of components considered','FontName','Courier New','FontSize',14,'FontWeight','bold')
% 	ylabel('AUC','FontName','Courier New','FontSize',14,'FontWeight','bold')
% 	xlim([1 length(perf.SVM_AUC)])
% 	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
% 	grid
% 	hold off
% 	
% 	saveas(h,strcat('pca_AUC_',feats),'png');
% 	saveas(h,strcat('pca_AUC_',feats),'fig');
% 	
% 	h = figure('visible','off');
% 	set(h, 'Position', [50 50 1200 800])
% 	subplot(2,1,1)
% 	hold on
% 	plot(cumsum(perf.explained),perf.SVM_acc,'Color',[0 0 0.8],'LineWidth',2)
% 	plot(cumsum(perf.explained),perf.RF_acc,'Color',[0.8 0 0],'LineWidth',2)
% 	l1 = legend('SVM','RF','Location','SouthEast');
% 	set(l1,'FontName','Courier New','FontSize',12,'FontWeight','bold')
% 	xlabel('% of explained variance','FontName','Courier New','FontSize',14,'FontWeight','bold')
% 	ylabel('accuracy','FontName','Courier New','FontSize',14,'FontWeight','bold')
% 	xlim([perf.explained(1) 100])
% 	grid
% 	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
% 	
% 	hold off
% 	subplot(2,1,2)
% 	hold on
% 	plot(1:length(perf.SVM_acc),perf.SVM_acc,'Color',[0 0 0.8],'LineWidth',2)
% 	plot(1:length(perf.RF_acc),perf.RF_acc,'Color',[0.8 0 0],'LineWidth',2)
% 	l1 = legend('SVM','RF','Location','SouthEast');
% 	set(l1,'FontName','Courier New','FontSize',12,'FontWeight','bold')
% 	xlabel('# of components considered','FontName','Courier New','FontSize',14,'FontWeight','bold')
% 	ylabel('accuracy','FontName','Courier New','FontSize',14,'FontWeight','bold')
% 	set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
% 	xlim([1 length(perf.SVM_AUC)])
% 	grid
% 	hold off
% 	
% 	saveas(h,strcat('pca_acc_',feats),'png');
% 	saveas(h,strcat('pca_acc_',feats),'fig');
end