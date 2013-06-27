load TrainDataSet.mat

im = trainDataSet(3).data;

img = rgb2gray(im);

imcgs = imresize(cont(img(26:75,26:75),1,8),[6 6]);


f1 = figure(1);
set(f1, 'Position', [50 50 1500 460])
% hold on
% 
subplot(1,3,1)
subimage(im)
hl = title('Image');
set(hl,'FontName','Courier New','FontSize',16,'FontWeight','bold')
set(gca,'XTickLabel',[])
set(gca,'YTickLabel',[])

% subplot(2,2,2)
% subimage(img)
% hl = xlabel('Grayscale');
% set(hl,'FontName','Courier New','FontSize',15,'FontWeight','bold')
% set(gca,'XTickLabel',[])
% set(gca,'YTickLabel',[])


subplot(1,3,2)
subimage(img)

hold on

for k1=0:6
	line([25 25]+k1*(75-25)/6,[25 75],'Color','y')
end

for k1=0:6
	line([25 75],[25 25]+k1*(75-25)/6,'Color','y')
end


hold off

hl = title('Central part');
set(hl,'FontName','Courier New','FontSize',16,'FontWeight','bold')

subplot(1,3,3)
hsi4 = subimage(imcgs,[min(imcgs(:)) max(imcgs(:))]);
%uistack(gca,'top')
hold on
set(gca,'XTick',1:6)
set(gca,'YTick',1:6)
% set(hl,'FontName','Courier New','FontSize',15,'FontWeight','bold')
hl = title('Mean VAR(8,1)');
set(hl,'FontName','Courier New','FontSize',16,'FontWeight','bold')




hold off

% print(f1,'-dpng','-r300','GS_VAR.png')


