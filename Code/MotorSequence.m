% This is a modification done in order to repurpose this task for a new
% study involving preschool-aged children.
% Modifications done by Dan Saunders (djsaunde@umass.edu), in May of 2016

function MotorSequence()
% Close open instance of GUI, if it exists.

c = allchild(0);
for i = 1:length(c)
    if strcmp(get(c,'Tag'),'MotorSequnceApp');
        close(c);
    end
end

userNum = 0;
quitApp = 0;

while sum(isstrprop(userNum,'digit'))~=3
    userNum = custom_inputdlg('Please enter a 3-digit subject code:');
    try
        userNum = userNum{1};
    catch
        quitApp = 1;
        break
    end
end

if quitApp ~= 1
    choiceList = {'Standard'}; % first modification. we only care to use a single mode of the task.
    choice = custom_menu('Please Choose a Mode',choiceList);
    
    if choice ~= 0
        choiceList2 = {'A','B'};

        choice2 = custom_menu('Please Choose a Session','Session A','Session B');
     
        if choice2 ~= 0
            % Check to see if file exists
            currDir = mfilename('fullpath');
            dirName = '';
            while ~strcmp(dirName,'Code')
                [currDir,dirName,~] = fileparts(currDir);
            end
            filepath = fullfile(currDir,'Results');
            if ~exist(filepath,'dir')
                mkdir(filepath);
            end
            if exist(fullfile(filepath,[num2str(userNum) '_' choiceList{choice} '_' choiceList2{choice2} '.txt']),'file');
                difficult_choice = custom_menu({'Test case already exists.', 'Would you like to overwrite it?','WARNING: This cannot be undone.'},{'Yes','Cancel'});
                if difficult_choice == 0 || difficult_choice ==  2 % if cancel
                    choice = 0; % Quit
                end
            end

            if choice
                if choice2 == 1
                    MotorSequenceAppA(choiceList{choice},userNum,choiceList2{choice2});
                else
                    MotorSequenceAppB(choiceList{choice},userNum,choiceList2{choice2});
                end
            end
        end
    end
end
    