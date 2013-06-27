load TrainDataSet.mat

f1 = figure(1);

nr = 5;
nc = 5;
f1 = figure(1);
hold on
for k1 = 1:nr
	for k2=1:nc
		nact = nc*(k1-1)+k2;
		subplot(nr,nc,nact)
		im = trainDataSet(nact).data;
		imshow(im)
		xlabel(num2str(nact))
	end
end
hold off
		


im = trainDataSet(21).data;

flipim = flipdim(im,2);

f2 = figure(2);
set(f2, 'Position', [50 50 1100 400])
hold on

set(gca,'FontName','Courier New','FontSize',12,'FontWeight','bold')

subplot(2,4,1)
imshow(im)
hl = xlabel('Orginal');
set(hl,'FontName','Courier New','FontSize',12,'FontWeight','bold')


subplot(2,4,2)
imshow(imrotate(im,-90))
hl = xlabel('(a)');
set(hl,'FontName','Courier New','FontSize',12,'FontWeight','bold')

subplot(2,4,3)
imshow(imrotate(im,-180))
hl = xlabel('(b)');
set(hl,'FontName','Courier New','FontSize',12,'FontWeight','bold')

subplot(2,4,4)
imshow(imrotate(im,-270))
hl = xlabel('(c)');
set(hl,'FontName','Courier New','FontSize',12,'FontWeight','bold')

subplot(2,4,5)
imshow(flipim)
hl = xlabel('Mirrored');
set(hl,'FontName','Courier New','FontSize',12,'FontWeight','bold')

subplot(2,4,6)
imshow(imrotate(flipim,-90))
hl = xlabel('(d)');
set(hl,'FontName','Courier New','FontSize',12,'FontWeight','bold')

subplot(2,4,7)
imshow(imrotate(flipim,-180))
hl = xlabel('(e)');
set(hl,'FontName','Courier New','FontSize',12,'FontWeight','bold')

subplot(2,4,8)
imshow(imrotate(flipim,-270))
hl = xlabel('(f)');
set(hl,'FontName','Courier New','FontSize',12,'FontWeight','bold')

% title('Extended Dataset','FontName','Courier New','FontSize',14,'FontWeight','bold','FontAngle','italic');
% set(gca,'FontName','Courier New','FontSize',12,'FontWeight','bold')

hold off

print(f2,'-dpng','-r300','rotDataset.png')
% {\pi}/2 clockwise rotation