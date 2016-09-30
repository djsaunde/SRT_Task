function varargout = MotorSequenceAppA(varargin)
% MOTORSEQUENCEAPP MATLAB code for MotorSequenceApp.fig
%      MOTORSEQUENCEAPP, by itself, creates a new MOTORSEQUENCEAPP or raises the existing
%      singleton*.
%
%      H = MOTORSEQUENCEAPP returns the handle to a new MOTORSEQUENCEAPP or the handle to
%      the existing singleton*.
%
%      MOTORSEQUENCEAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOTORSEQUENCEAPP.M with the given input arguments.
%
%      MOTORSEQUENCEAPP('Property','Value',...) creates a new MOTORSEQUENCEAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MotorSequenceApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MotorSequenceApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MotorSequenceApp

% Last Modified by GUIDE v2.5 26-Jan-2015 17:31:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MotorSequenceAppA_OpeningFcn, ...
                   'gui_OutputFcn',  @MotorSequenceAppA_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MotorSequenceApp is made visible.
function MotorSequenceAppA_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MotorSequenceApp (see VARARGIN)

% Choose default command line output for MotorSequenceApp
handles.mode = varargin{1};
handles.userNum = varargin{2};
handles.session = varargin{3};
handles.currBlock = 0;
buttonList = {'ONE', 'TWO', 'THREE', 'FOUR'};
colorList = {'red', 'yellow', 'green', 'blue'};
for buttonNum = 1:4
    button = findobj('Tag',buttonList{buttonNum});
    if strcmp(handles.mode,'Contextual')
        changeColor(button,colorList{buttonNum});
    else
        changeColor(button,'white');
    end
end

boxList = {'box_one','box_two','box_three','box_four'};
for i = 1:4
    ax = findobj('Tag',boxList{i});
    axes(ax); hold on;
    X(1) = plot([0.1 0.9],[0.1 0.9], 'LineWidth',8,'Color',[0 0 0]);
    X(2) = plot([0.9 0.1],[0.1 0.9], 'LineWidth',8,'Color',[0 0 0]);
    set(ax,'Color','k');
    setappdata(ax,'X',X);
    box(ax,'on');
    set(ax,'XTick',[],'YTick',[]);
    set(ax,'XColor',[1 1 1]);
    set(ax,'YColor',[1 1 1]);
end

pBar = findobj('Tag','progressBar');
set(pBar,'XTick',[]);
axes(pBar);
pPatch = patch([0 1 1 0],[0 0 1 1],[221 26 26]./255);
set(pPatch,'visible','off');
setappdata(pBar,'pPatch',pPatch);

tagList = {'subnum1', 'subnum2', 'subnum3'};
for i=1:length(tagList)
    h = findobj(hObject,'Tag',tagList{i});
    set(h,'String',handles.userNum(i));
end

handles.output = hObject;

% 1 - Sequential
% 2 - Contextual
% 3 - Direct

switch handles.mode
    case 'Standard'
        handles.blockOrder = [1 1 1 1 1 1 1 2 1 2 1];
end

handles.seconds = 10;
handles.numBlocks = 11;

set(gcbo, 'units','normalized','outerposition',[0 0 1 1]);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MotorSequenceApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MotorSequenceAppA_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ONE.
function ONE_Callback(hObject, ~, handles)
% hObject    handle to ONE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if getappdata(handles.start,'waiting')
    handles.tArray(handles.currBlock,handles.currCue) = toc(handles.tStart);
    handles.correct(handles.currBlock,handles.currCue)...
        = (handles.blockMat(handles.currBlock,handles.currCue)==1);
    handles.keypress(handles.currBlock,handles.currCue) = 1;
    setappdata(handles.start,'waiting',0)
    guidata(hObject,handles);
    currBlock = handles.currBlock;
    if ~nextCue(hObject,handles);
        handles = guidata(hObject);
        nextBlock = handles.currBlock;
        if currBlock~=nextBlock
            set(handles.start,'visible','on','enable','on','String','Continue')
        else
            run(hObject,handles);
        end
    end
end


% --- Executes on button press in TWO.
function TWO_Callback(hObject, ~, handles)
% hObject    handle to TWO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if getappdata(handles.start,'waiting')
    handles.tArray(handles.currBlock,handles.currCue) = toc(handles.tStart);
    handles.correct(handles.currBlock,handles.currCue)...
        = (handles.blockMat(handles.currBlock,handles.currCue)==2);
    handles.keypress(handles.currBlock,handles.currCue) = 2;
    setappdata(handles.start,'waiting',0)
    guidata(hObject,handles);
    currBlock = handles.currBlock;
    if ~nextCue(hObject,handles);
        handles = guidata(hObject);
        nextBlock = handles.currBlock;
        if currBlock~=nextBlock
            set(handles.start,'visible','on','enable','on','String','Continue')
        else
            run(hObject,handles);
        end
    end
%     if ~nextCue(hObject,handles);
%         handles = guidata(hObject);
%         run(hObject,handles);
%     end
end


% --- Executes on button press in THREE.
function THREE_Callback(hObject, ~, handles)
% hObject    handle to THREE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if getappdata(handles.start,'waiting')
    handles.tArray(handles.currBlock,handles.currCue) = toc(handles.tStart);
    handles.correct(handles.currBlock,handles.currCue)...
        = (handles.blockMat(handles.currBlock,handles.currCue)==3);
    handles.keypress(handles.currBlock,handles.currCue) = 3;
    setappdata(handles.start,'waiting',0)
    guidata(hObject,handles);
    currBlock = handles.currBlock;
    if ~nextCue(hObject,handles);
        handles = guidata(hObject);
        nextBlock = handles.currBlock;
        if currBlock~=nextBlock
            set(handles.start,'visible','on','enable','on','String','Continue')
        else
            run(hObject,handles);
        end
    end
end


% --- Executes on button press in FOUR.
function FOUR_Callback(hObject, ~, handles)
% hObject    handle to FOUR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if getappdata(handles.start,'waiting')
    handles.tArray(handles.currBlock,handles.currCue) = toc(handles.tStart);
    handles.correct(handles.currBlock,handles.currCue)...
        = (handles.blockMat(handles.currBlock,handles.currCue)==4);
    handles.keypress(handles.currBlock,handles.currCue) = 4;
    setappdata(handles.start,'waiting',0)
    guidata(hObject,handles);
    currBlock = handles.currBlock;
    if ~nextCue(hObject,handles);
        handles = guidata(hObject);
        nextBlock = handles.currBlock;
        if currBlock~=nextBlock
            set(handles.start,'visible','on','enable','on','String','Continue')
        else
            run(hObject,handles);
        end
    end
end



function subnum1_Callback(~, ~, ~)
% hObject    handle to subnum1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subnum1 as text
%        str2double(get(hObject,'String')) returns contents of subnum1 as a double


% --- Executes during object creation, after setting all properties.
function subnum1_CreateFcn(hObject, ~, ~)
% hObject    handle to subnum1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function subnum2_Callback(~, ~, ~)
% hObject    handle to subnum2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subnum2 as text
%        str2double(get(hObject,'String')) returns contents of subnum2 as a double


% --- Executes during object creation, after setting all properties.
function subnum2_CreateFcn(hObject, ~, ~)
% hObject    handle to subnum2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function subnum3_Callback(~, ~, ~)
% hObject    handle to subnum3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subnum3 as text
%        str2double(get(hObject,'String')) returns contents of subnum3 as a double


% --- Executes during object creation, after setting all properties.
function subnum3_CreateFcn(hObject, ~, ~)
% hObject    handle to subnum3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in start.
function start_Callback(hObject, ~, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.currBlock == 0
    pause(0.1)
    set(handles.start,'visible','off');
    handles.buttonHList = [handles.ONE handles.TWO handles.THREE handles.FOUR];
    handles.boxHList = [handles.box_one handles.box_two handles.box_three handles.box_four];
    handles.colorList = {'red', 'yellow', 'green', 'blue'};
    blockOrder = handles.blockOrder;
    handles.complete = 0;
    for j = 1:handles.seconds
        set(handles.dialogbox,'String',['Application starting in ' num2str(handles.seconds-j+1) '...']);
        pause(1);
    end
    set(handles.dialogbox,'String','');
    for blocknum = 1:handles.numBlocks
        % Read in Block
        if blockOrder(blocknum) == 1
            [handles.blockMat(blocknum,:), handles.locblockMat(blocknum,:)] = createBlock('sequence',handles.session);
        elseif blockOrder(blocknum) == 2
            [handles.blockMat(blocknum,:), handles.locblockMat(blocknum,:)] = createBlock('random',handles.session);
        else
            [handles.blockMat(blocknum,:), handles.locblockMat(blocknum,:)] = createBlock('contextual',handles.session);
        end
    end

    handles.currBlock = 1;
    handles.currCue = 1;
else
    set(handles.start,'visible','off');
    for j = 1:handles.seconds
        set(handles.dialogbox,'String',['Block ' num2str(handles.currBlock) ' starting in ' num2str(handles.seconds-j+1) '...']);
        pause(1);
    end
    set(handles.dialogbox,'String','');
end

run(hObject,handles);

    
function run(hObject,handles)
% Runs the next cue/button press set
if handles.complete ~= 1
    setappdata(handles.start,'waiting',1)
    if strcmp(handles.mode,'Standard')
        makeX(handles.boxHList(handles.blockMat(handles.currBlock,handles.currCue)),'red');
    elseif strcmp(handles.mode,'Direct')
        changeColor(handles.buttonHList(handles.blockMat(handles.currBlock,handles.currCue)),'yellow');
    elseif strcmp(handles.mode,'Contextual')
        makeX(handles.boxHList(handles.locblockMat(handles.currBlock,handles.currCue)),handles.colorList{handles.blockMat(handles.currBlock,handles.currCue)})
    end
    handles.tStart = tic;
end
guidata(hObject,handles);

function complete = nextCue(hObject,handles)
% Assigns new cue/button press set
if strcmp(handles.mode,'Standard')
    makeX(handles.boxHList(handles.blockMat(handles.currBlock,handles.currCue)),'black')
elseif strcmp(handles.mode,'Direct')
    changeColor(handles.buttonHList(handles.blockMat(handles.currBlock,handles.currCue)),'white');
elseif strcmp(handles.mode,'Contextual')
    makeX(handles.boxHList(handles.locblockMat(handles.currBlock,handles.currCue)),'black')
end
if handles.currCue == 120
    handles.currBlock
    handles.numBlocks
    if handles.currBlock == handles.numBlocks;
        % complete
        set(handles.ONE,'enable','inactive');
        set(handles.TWO,'enable','inactive');
        set(handles.THREE,'enable','inactive');
        set(handles.FOUR,'enable','inactive');
        
        handles.ONE
        
        setappdata(handles.start,'waiting',0)
        
        handles.start
        
        handles.complete = 1;
        setProgressBar(handles.progressBar,handles.numBlocks);
        set(handles.dialogbox,'String',['Block ' num2str(handles.currBlock) ': Time = ' num2str(sum(handles.tArray(handles.currBlock,:)),'%2.1f') ' seconds (' ...
                num2str(sum(~handles.correct(handles.currBlock,:))) ' Errors). Application closing in ' num2str(handles.seconds) '...' ])
        createOutputFile(hObject,handles);
        for j = 1:handles.seconds
            set(handles.dialogbox,'String',['Block ' num2str(handles.currBlock) ': Time = ' num2str(sum(handles.tArray(handles.currBlock,:)),'%2.1f') ' seconds (' ...
                num2str(sum(~handles.correct(handles.currBlock,:))) ' Errors). Application closing in ' num2str(handles.seconds-j+1) '...'])
            pause(1);
        end
  
        close(handles.output);
    else
        % print block info
        setProgressBar(handles.progressBar,handles.currBlock);
        set(handles.dialogbox,'String',{['Block ' num2str(handles.currBlock) ': Time = ' num2str(sum(handles.tArray(handles.currBlock,:)),'%2.1f') ' seconds (' ...
                num2str(sum(~handles.correct(handles.currBlock,:))) ' Errors)'],['Press Continue to begin Block ' num2str(handles.currBlock+1) '.']})
        handles.currBlock = handles.currBlock + 1;
        handles.currCue = 1;
        guidata(hObject,handles);
    end
else
    handles.currCue = handles.currCue + 1;
    guidata(hObject,handles);
end
complete = handles.complete;

function createOutputFile(hObject, handles)
currDir = mfilename('fullpath');
dirName = '';
while ~strcmp(dirName,'SRT_Task')
    [currDir,dirName,~] = fileparts(currDir);
end
filepath = fullfile(currDir,'SRT_Task','Results');
if ~exist(filepath,'dir')
    mkdir(filepath);
end
f = fopen(fullfile(filepath,[num2str(handles.userNum) '_' handles.mode '_' handles.session '.txt']),'wt');
if strcmp(handles.mode,'Contextual')
    fprintf(f,'COL 1: LOCATION\nCOL 2: TARGET\nCOL 3: RESPONSE\nCOL 4: REACTION TIME (SECONDS)');
else
    fprintf(f,'COL 1: TARGET\nCOL 2: RESPONSE\nCOL 3: REACTION TIME (SECONDS)');
end
fprintf(f,'\n\n');
for blocknum = 1:handles.numBlocks
    fprintf(f,['----------BLOCK ' num2str(blocknum) '----------']);
    fprintf(f,'\n');
    for j = 1:120
        if strcmp(handles.mode,'Contextual')
            fprintf(f,'%d\t%d\t%d\t%2.2f\n',handles.locblockMat(blocknum,j),handles.blockMat(blocknum,j),handles.keypress(blocknum,j),handles.tArray(blocknum,j));
        else
            fprintf(f,'%d\t%d\t%2.2f\n',handles.blockMat(blocknum,j),handles.keypress(blocknum,j),handles.tArray(blocknum,j));
        end
    end
    fprintf(f,'\n');
end
fclose(f);


% --- Executes during object creation, after setting all properties.
function start_CreateFcn(~, ~, ~)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gcbo,'visible','on');
