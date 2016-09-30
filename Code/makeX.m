function makeX(box,color)
if strcmp(color,'white')
    colorset = [1 1 1];
elseif strcmp(color,'red')
    colorset = [221 26 26]./255;
elseif strcmp(color,'blue')
    colorset = [51 102 255]./255;
elseif strcmp(color,'green')
    colorset = [46 166 47]./255;
elseif strcmp(color,'yellow')
    colorset = [255 212 36]./255;
elseif strcmp(color,'black')
    colorset = [0 0 0];
end

X = getappdata(box,'X');
set(X(1),'Color',colorset);
set(X(2),'Color',colorset);
drawnow;

