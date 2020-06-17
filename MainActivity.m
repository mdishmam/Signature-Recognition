function varargout = MainActivity(varargin)
% MAINACTIVITY MATLAB code for MainActivity.fig
%      MAINACTIVITY, by itself, creates a new MAINACTIVITY or raises the existing
%      singleton*.
%
%      H = MAINACTIVITY returns the handle to a new MAINACTIVITY or the handle to
%      the existing singleton*.
%
%      MAINACTIVITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINACTIVITY.M with the given input arguments.
%
%      MAINACTIVITY('Property','Value',...) creates a new MAINACTIVITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainActivity_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainActivity_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainActivity

% Last Modified by GUIDE v2.5 13-Mar-2020 23:11:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainActivity_OpeningFcn, ...
                   'gui_OutputFcn',  @MainActivity_OutputFcn, ...
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


% --- Executes just before MainActivity is made visible.
function MainActivity_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainActivity (see VARARGIN)

% Choose default command line output for MainActivity
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainActivity wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainActivity_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function imageName_Callback(hObject, eventdata, handles)
% hObject    handle to imageName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imageName as text
%        str2double(get(hObject,'String')) returns contents of imageName as a double


% --- Executes during object creation, after setting all properties.
function imageName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imageName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadimg.
function loadimg_Callback(hObject, eventdata, handles)
% hObject    handle to loadimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
[a, b]=uigetfile({'*.jpg';'*.jpeg';'*.png';'*.*'},'Select Image File');
    img = strcat(b,a);
    img = imread(img);
    axes(handles.axes1);
  imshow(img);
    




% --- Executes on button press in createdb.
function createdb_Callback(hObject, eventdata, handles)
% hObject    handle to createdb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Sig_Template


% --- Executes on button press in home.
function home_Callback(hObject, eventdata, handles)
% hObject    handle to home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI
close MainActivity


% --- Executes on button press in submit.
function submit_Callback(hObject, eventdata, handles)
% hObject    handle to submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global strOp;
strOp = get(handles.imageName,'String');
global dat;
global img;
dat = img;
dat = rgb2gray(dat);

dat = imbinarize(dat,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
dat = 1-dat;
dat = bwareaopen(dat,100);

[tRow, tCol] = size(dat);

%Beginnings Horizontal Edge Cutting
while 1
    tmp = 0;
    for j = 1:tRow
        tmp = tmp + dat(j,1);
    end
    if tmp == 0
        dat(:,1) = [];
    else
        break
    end
    
end

%Endings Horizontal Edge Cutting
dat = imrotate(dat,180);

while 1
    tmp = 0;
    for j = 1:tRow
        tmp = tmp + dat(j,1);
    end
    if tmp == 0
        dat(:,1) = [];
    else
        break
    end
    
end
dat = imrotate(dat,180);

%Top vertical edge cutting
[tRow, tCol] = size(dat);

while 1
    tmp = 0;
    for j = 1:tCol
        tmp = tmp + dat(1,j);
    end
    if tmp == 0
        dat(1,:) = [];
    else
        break
    end
    
end

dat = imrotate(dat,180);
while 1
    tmp = 0;
    for j = 1:tCol
        tmp = tmp + dat(1,j);
    end
    if tmp == 0
        dat(1,:) = [];
    else
        break
    end
    
end
dat = imrotate(dat,180);
axes(handles.axes1);
imshow(dat); 
snum = get(handles.signum,'String');
% num = str2num(snum);
imwrite(dat,sprintf('%s%s%s.jpg','DataSets/',strOp ,snum));

% imwrite(dat,strOp);


% --- Executes on button press in newbtn.
function newbtn_Callback(hObject, eventdata, handles)
% hObject    handle to newbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.axes1,'reset');
set(handles.imageName,'string',"");
set(handles.signum,'string',"");



function signum_Callback(hObject, eventdata, handles)
% hObject    handle to signum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of signum as text
%        str2double(get(hObject,'String')) returns contents of signum as a double


% --- Executes during object creation, after setting all properties.
function signum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
