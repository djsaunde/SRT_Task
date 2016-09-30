function [block, locblock] = createBlock(type,session)
block = zeros(12,10);
locblock = zeros(12,10);
if strcmp(type,'sequence')
    if strcmp(session,'A')
        for i = 1:length(block(:,1))
            block(i,:)    = [4 3 1 4 2 1 3 4 1 2];
            locblock(i,:) = [1 4 2 1 3 2 4 3 1 4];
        end
    elseif strcmp(session,'B')
        for i = 1:length(block(:,1))
            block(i,:)    = [4 3 1 4 2 1 3 4 1 2];
            locblock(i,:) = [2 3 4 2 1 4 3 1 2 4];
        end
    end
          
elseif strcmp(type,'random')
    % cue block
    block = zeros(12,10);
    for i = 1:length(block(:,1))
        block(i,:)        = [3 1 4 2 1 4 1 3 2 4];
    end
    % location block
    locblock = zeros(1,120);
    for i = 1:length(locblock)
        nextNum = randi(4);
        if i>2
            while nextNum == locblock(i-1) || nextNum == locblock(i-2)
                nextNum = randi(4);
            end
        elseif i==2
            while nextNum == locblock(i-1)
                nextNum = randi(4);
            end
        end
        locblock(i) = nextNum;
    end
elseif strcmp(type,'contextual')
    if strcmp(session,'A')
        for i = 1:length(block(:,1))
            block(i,:)    = [2 4 1 3 4 2 3 1];
            locblock(i,:) = [3 1 4 2 1 3 2 4];
        end
    elseif strcmp(session,'B')
        for i = 1:length(block(:,1))
            block(i,:)    = [3 1 4 2 1 3 2 4];
            locblock(i,:) = [1 2 3 4 2 1 4 3];
        end
              
    end
        
end
block = block';
block = block(:);
locblock = locblock';
locblock = locblock(:);