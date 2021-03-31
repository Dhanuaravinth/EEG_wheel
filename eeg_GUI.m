function varargout = eeg_GUI(varargin)
% EEG_GUI MATLAB code for eeg_GUI.fig
%      EEG_GUI, by itself, creates a new EEG_GUI or raises the existing
%      singleton*.
%
%      H = EEG_GUI returns the handle to a new EEG_GUI or the handle to
%      the existing singleton*.
%
%      EEG_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EEG_GUI.M with the given input arguments.
%
%      EEG_GUI('Property','Value',...) creates a new EEG_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before eeg_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to eeg_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help eeg_GUI

% Last Modified by GUIDE v2.5 26-Jan-2021 15:21:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @eeg_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @eeg_GUI_OutputFcn, ...
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


% --- Executes just before eeg_GUI is made visible.
function eeg_GUI_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to eeg_GUI (see VARARGIN)

% Choose default command line output for eeg_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes eeg_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = eeg_GUI_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in smart.
function smart_Callback(hObject, eventdata, handles)
% hObject    handle to smart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function smart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Right.
function Right_Callback(hObject, eventdata, handles)
% hObject    handle to Right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t=(0:0.01:10);
x=square(t);
plot(t,x,'LineWidth',5)
 hold on
axis([0 20 -2 2])
global s;
fopen(s);
fwrite(s,'r'); %Right
fclose(s);



% --- Executes on button press in Left.
function Left_Callback(hObject, eventdata, handles)
% hObject    handle to Left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t=(10:0.01:20);
x=square(t);
plot(t,x,'LineWidth',5)
 hold on
axis([0 20 -2 2])
global s;
fopen(s);
fwrite(s,'l'); %Left
fclose(s);


% --- Executes on button press in Emergency.
function Emergency_Callback(hObject, eventdata, handles)
% hObject    handle to Emergency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla reset;
x=0:12;
y=5;
plot(x,y*ones(size(x)),'LineWidth',10)
global s;
fopen(s);
fwrite(s,'s'); %stop
fclose(s);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on mouse press over axes background.
function axes_Callback(hObject, eventdata, handles)
 xlabel(handles.axes,'Time');
 ylabel(handles.axes,'Voltage');
 


% --- Executes on button press in connect.
function connect_Callback(hObject, eventdata, handles)
% hObject    handle to connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of connect
global s;
port=get(handles.port,'String');
port=str2num(port);
ip=get(handles.IP,'String');
s=tcpip(ip,port,'NetworkRole','client');%IP is server address at ESP
fopen(s);
set(handles.status,'String','Connected!!','FontSize', 20);
set(handles.status,'ForegroundColor','g');
fclose(s); 


% --- Executes on button press in forward.
function forward_Callback(hObject, eventdata, handles)
% hObject    handle to forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s;
fopen(s);
t=(5:0.01:16);
x=square(t);
plot(t,x,'LineWidth',5)
 hold on
axis([0 20 -2 2])
fwrite(s,'f'); %forward
fclose(s);


% --- Executes on button press in disconnect.
function disconnect_Callback(hObject, eventdata, handles)
% hObject    handle to disconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s;
fclose(s);
set(handles.status,'String','Disconnected!!','FontSize', 20);
set(handles.status,'ForegroundColor','r');
fopen(s);
fwrite(s,'h'); %MOTOR L & R OFF
fclose(s);


function IP_Callback(hObject, eventdata, handles)
% hObject    handle to IP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IP as text
%        str2double(get(hObject,'String')) returns contents of IP as a double


% --- Executes during object creation, after setting all properties.
function IP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function port_Callback(hObject, eventdata, handles)
% hObject    handle to port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of port as text
%        str2double(get(hObject,'String')) returns contents of port as a double


% --- Executes during object creation, after setting all properties.
function port_CreateFcn(hObject, eventdata, handles)
% hObject    handle to port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
