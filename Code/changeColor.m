function changeColor(button,color)
if strcmp(color,'white')
    colorset = cat(3,ones(500)*0.95,ones(500)*0.95,ones(500)*0.95);
elseif strcmp(color,'red')
    colorset = cat(3,ones(500)*221,ones(500)*26,ones(500)*26)./255;
elseif strcmp(color,'blue')
    colorset = cat(3,ones(500)*51,ones(500)*102,ones(500)*255)./255;
elseif strcmp(color,'green')
    colorset = cat(3,ones(500)*46,ones(500)*166,ones(500)*47)./255;
elseif strcmp(color,'yellow')
    colorset = cat(3,ones(500)*255,ones(500)*212,ones(500)*36)./255;
end

set(button,'cdata',colorset);
