function varargout = robot_positions(varargin)
% ROBOT_POSITIONS MATLAB code for robot_positions.fig
%      ROBOT_POSITIONS, by itself, creates a new ROBOT_POSITIONS or raises the existing
%      singleton*.
%
%      H = ROBOT_POSITIONS returns the handle to a new ROBOT_POSITIONS or the handle to
%      the existing singleton*.
%
%      ROBOT_POSITIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROBOT_POSITIONS.M with the given input arguments.
%
%      ROBOT_POSITIONS('Property','Value',...) creates a new ROBOT_POSITIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before robot_positions_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to robot_positions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help robot_positions

% Last Modified by GUIDE v2.5 01-Dec-2013 14:06:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @robot_positions_OpeningFcn, ...
                   'gui_OutputFcn',  @robot_positions_OutputFcn, ...
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

% --- Executes just before robot_positions is made visible.
function robot_positions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to robot_positions (see VARARGIN)

% Choose default command line output for robot_positions
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using robot_positions.
if strcmp(get(hObject,'Visible'),'off')
    plot(0);
else
    clf;
end

clc

% UIWAIT makes robot_positions wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = robot_positions_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)

% --- Executes on selection change in team1_popup.
function team1_popup_Callback(hObject, eventdata, handles)
% hObject    handle to team1_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns team1_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from team1_popup
    handles.team1 = get(hObject, 'Value');
    guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function team1_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to team1_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
    handles.team1 = 1;
    guidata(hObject, handles);


% --- Executes on selection change in team2_popup.
function team2_popup_Callback(hObject, eventdata, handles)
% hObject    handle to team2_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns team2_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from team2_popup
    handles.team2 = get(hObject, 'Value');
    guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function team2_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to team2_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
    handles.team2 = 2;
    guidata(hObject, handles);


% --- Executes on button press in connect_button.
function connect_button_Callback(hObject, eventdata, handles)
% hObject    handle to connect_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    plot(handles.output, 0);
    if(isfield(handles, 'm2'))
        [handles.m2, handles.h1, handles.h2] = connect_m2(handles.m2,...
            [handles.team1, handles.team2]);
    else
        [handles.m2, handles.h1, handles.h2] = connect_m2([], [handles.team1, handles.team2]);
    end
    guidata(hObject, handles);


% --- Executes on button press in play_button.
function play_button_Callback(hObject, eventdata, handles)
% hObject    handle to play_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    play(handles.m2, handles.h1, handles.h2);

% --- Executes on button press in pause_button.
function pause_button_Callback(hObject, eventdata, handles)
% hObject    handle to stop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    fwrite(handles.m2, 'x', 'char');
    
% --- Executes on button press in stop_button.
function stop_button_Callback(hObject, eventdata, handles)
% hObject    handle to stop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    fwrite(handles.m2, 'x', 'char');
    pause(0.5);
    fclose(handles.m2);
    set(handles.h1, 'XData', 0, 'YData', 0);
    set(handles.h2, 'XData', 0, 'YData', 0);
