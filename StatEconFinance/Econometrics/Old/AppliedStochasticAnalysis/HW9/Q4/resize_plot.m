flds = {'Position', 'PaperPosition'};
for f = 1:length(flds)
  pos = get(gcf, flds{f});
  set(gcf, flds{f}, [pos(1) pos(2)-pos(2) pos(3) pos(4)*2]);
end
psize = get(gcf, 'PaperSize');
%set(gcf, 'PaperSize', [psize(1), psize(2)*2]);
