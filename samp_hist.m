load TrainDataSet.mat

im = trainDataSet(1).data;

tmp_im = im(:,:,1);

imR = tmp_im(:);

tmp_im = im(:,:,2);

imG = tmp_im(:);

tmp_im = im(:,:,3);

imB = tmp_im(:);


% [cR,xR] = imhist(im(:,:,1),16);
% 
% [cG,xG] = imhist(im(:,:,2),16);
% 
% [cB,xB] = imhist(im(:,:,3),16);




f1 = figure(1);
set(f1, 'Position', [50 50 1600 400])
hold on

subplot(1,4,1)
imshow(im)
hl = xlabel('Image');
set(hl,'FontName','Courier New','FontSize',16,'FontWeight','bold')

subplot(1,4,2)
hist(round(imR*256),16)
hh1 = findobj(gca,'Type','patch');
set(hh1,'FaceColor',[1 .15 .15],'EdgeColor',[1 .5 .5]);
xlim([0 256])
ylim([0 2000])
set(gca,'XTick',0:64:256)
set(gca,'FontName','Courier New','FontSize',12,'FontWeight','bold')
hl = xlabel('intensity value');
set(hl,'FontName','Courier New','FontSize',14,'FontWeight','bold')
h2 = ylabel('px count');
set(h2,'FontName','Courier New','FontSize',14,'FontWeight','bold')
h3 = title('Red histogram');
set(h3,'FontName','Courier New','FontSize',16,'FontWeight','bold')


subplot(1,4,3)
hist(round(imG*256),16,'Color','g')
hh1 = findobj(gca,'Type','patch');
set(hh1,'FaceColor',[.15 1 .15],'EdgeColor',[.5 1 .5]);
xlim([0 256])
ylim([0 2000])
set(gca,'XTick',0:64:256)
set(gca,'FontName','Courier New','FontSize',12,'FontWeight','bold')
hl = xlabel('intensity value');
set(hl,'FontName','Courier New','FontSize',14,'FontWeight','bold')
h2 = ylabel('px count');
set(h2,'FontName','Courier New','FontSize',14,'FontWeight','bold')
h3 = title('Green histogram');
set(h3,'FontName','Courier New','FontSize',16,'FontWeight','bold')

subplot(1,4,4)
hist(round(imB*256),16,'Color','b')
hh1 = findobj(gca,'Type','patch');
set(hh1,'FaceColor',[.15 .15 1],'EdgeColor',[.5 .5 1]);
xlim([0 256])
ylim([0 2000])
set(gca,'XTick',0:64:256)
set(gca,'FontName','Courier New','FontSize',12,'FontWeight','bold')
hl = xlabel('intensity value');
set(hl,'FontName','Courier New','FontSize',14,'FontWeight','bold')
h2 = ylabel('px count');
set(h2,'FontName','Courier New','FontSize',14,'FontWeight','bold')
h3 = title('Blue histogram');
set(h3,'FontName','Courier New','FontSize',16,'FontWeight','bold')

hold off

print(f1,'-dpng','-r300','histIM.png')


