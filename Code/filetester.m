handles.mode = 'Standard';
handles.userNum = 848;

handles.blockMat = zeros(8,56);
handles.keypress = zeros(8,56);
handles.tArray = zeros(8,56);

for i = 1:8
    for j = 1:56;
        handles.blockMat(i,j) = randi(4);
        handles.keypress(i,j) = randi(4);
        handles.tArray(i,j) = randi(10000)/100;
    end
end

currDir = mfilename('fullpath');
dirName = '';
while ~strcmp(dirName,'MotorSequence')
    [currDir,dirName,~] = fileparts(currDir);
end
filepath = fullfile(currDir,'MotorSequence','Results');
if ~exist(filepath,'dir')
    mkdir(filepath);
end
f = fopen(fullfile(filepath,[num2str(handles.userNum) '_' handles.mode '.txt']),'wt');
fprintf(f,'COL 1: TARGET\nCOL 2: RESPONSE\nCOL 3: REACTION TIME (SECONDS)');
fprintf(f,'\n\n');
for blocknum = 1:8
    fprintf(f,['----------BLOCK ' num2str(blocknum) '----------']);
    fprintf(f,'\n');
    for j = 1:56
        fprintf(f,'%d\t%d\t%2.2f\n',handles.blockMat(blocknum,j),handles.keypress(blocknum,j),handles.tArray(blocknum,j));
    end
    fprintf(f,'\n');
end
fclose(f);