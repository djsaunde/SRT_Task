function setProgressBar(pBar,status)
pPatch = getappdata(pBar,'pPatch');
if status <=0
    set(pPatch,'visible','off');
else
    set(pPatch,'visible','on');
    set(pPatch, 'YData', [0 0 status status])
end
drawnow;
