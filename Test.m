function varargout = Test(varargin)
% TEST MATLAB code for Test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Test

% Last Modified by GUIDE v2.5 13-Mar-2020 23:25:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Test_OpeningFcn, ...
                   'gui_OutputFcn',  @Test_OutputFcn, ...
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


% --- Executes just before Test is made visible.
function Test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Test (see VARARGIN)

% Choose default command line output for Test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Loadimg.
function Loadimg_Callback(hObject, eventdata, handles)
% hObject    handle to Loadimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
[a, b]=uigetfile({'*.jpg';'*.jpeg';'*.png';'*.*'},'Select Image File');
    img = strcat(b,a);
    img = imread(img);
    axes(handles.axes1);
  imshow(img);


% --- Executes on button press in sigextract.
function sigextract_Callback(hObject, eventdata, handles)
% hObject    handle to sigextract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
dat = img;
dat = rgb2gray(dat);
dat = imbinarize(dat,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
dat = 1-dat;
dat = bwareaopen(dat,100);

[tRow, tCol] = size(dat);

%Edge Cutting
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
%End of edge cutting


dat = imresize(dat, [80 300]);
imshow(dat);

load templates;

comp=[];
sz = size(templates,2);

 for n=1:sz
    
    sem=corr2(templates{1,n},dat);
    comp=[comp sem];
    
    %pause(1)
 end
 
 average = [];
 sum = 0;
 threshold = 0.15;
 count = 0;
 pos = 0;
 for i = 1:5:sz
     for j = i:i+5
         pos = (floor(i/5)+1);
         sum = sum+comp((i-1)+pos);
        
     end
      average = [average (sum/5)];
      sum = 0;
      if average(pos)>=threshold
%           sprintf("Signature matched with %d",pos);
          count = count + 1;
          break;
      end
 end

 Sig_Template;
 global clients;
 global output;
 
 if count == 0
     output  = sprintf("Signature did not match");
 else
     name = clients(pos);
     output = sprintf("Signature matched with [%s]",name);
 end
 set(handles.edit1,'String',output);

% --- Executes on button press in home.
function home_Callback(hObject, eventdata, handles)
% hObject    handle to home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI
close Test



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1,'reset');
set(handles.edit1,'string',"");
