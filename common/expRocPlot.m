function expRocPlot(sens, spec, hull,accM, accMind, name) 

f1 = figure('visible','off');
set(f1, 'Position', [50 50 1100 1000])
hold on


plot(1- spec, sens,'LineWidth',2,'Color',[0.1 0.1 1])
plot(1- spec(hull), sens(hull),'Color',[0 0.5 0.1],'LineWidth',1.5)
plot(1 - spec(accMind), sens(accMind),'ro','MarkerSize',12,'MarkerFaceColor','r')
h1 = line([0 1],[0 1]);
set(h1,'LineStyle','-.');
set(h1,'LineWidth',1.5);
set(h1,'Color',[0.7 0.1 0.1])
l1 = legend('ROC curve','convex hull',['Max Accuracy = ',num2str(accM)],'Location','SouthEast');
set(l1,'FontName','Courier New','FontSize',14,'FontWeight','bold')
axis([0 1 0 1])
xlabel('1-specificity','FontName','Courier New','FontSize',14,'FontWeight','bold')
ylabel('sensitivity','FontName','Courier New','FontSize',14,'FontWeight','bold')
title('ROC curve','FontName','Courier New','FontSize',18,'FontWeight','bold','FontAngle','italic');
set(gca,'YTick',0:.2:1)
set(gca,'XTick',0:.2:1)
set(gca,'FontName','Courier New','FontSize',14,'FontWeight','bold')
grid
axis equal
axis square
hold off

print(f1,'-dpng','-r300',strcat(name,'.png'))
% print(f1,'-depsc2','-r300','ROC1')
saveas(gcf,name,'fig')