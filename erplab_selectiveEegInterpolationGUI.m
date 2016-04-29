function varargout = erplab_selectiveEegInterpolationGUI(varargin)
% erplab_selectiveEegInterpolationGUI MATLAB code for erplab_selectiveEegInterpolationGUI.fig
%      erplab_selectiveEegInterpolationGUI, by itself, creates a new erplab_selectiveEegInterpolationGUI or raises the existing
%      singleton*.
%
%      H = erplab_selectiveEegInterpolationGUI returns the handle to a new erplab_selectiveEegInterpolationGUI or the handle to
%      the existing singleton*.
%
%      erplab_selectiveEegInterpolationGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in erplab_selectiveEegInterpolationGUI.M with the given input arguments.
%
%      erplab_selectiveEegInterpolationGUI('Property','Value',...) creates a new erplab_selectiveEegInterpolationGUI or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before erplab_selectiveEegInterpolationGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to erplab_selectiveEegInterpolationGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help erplab_selectiveEegInterpolationGUI

% Last Modified by GUIDE v2.5 29-Apr-2016 12:10:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @erplab_selectiveEegInterpolationGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @erplab_selectiveEegInterpolationGUI_OutputFcn, ...
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

% --- Executes just before erplab_selectiveEegInterpolationGUI is made visible.
function erplab_selectiveEegInterpolationGUI_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<*INUSL>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to erplab_selectiveEegInterpolationGUI (see VARARGIN)

% Choose default command line output for erplab_selectiveEegInterpolationGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes erplab_selectiveEegInterpolationGUI wait for user response (see UIRESUME)
uiwait(handles.gui_figure);


% --- Outputs from this function are returned to the command line.
function varargout = erplab_selectiveEegInterpolationGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The figure can be deleted now
delete(handles.gui_figure);
pause(0.5)




% --- Executes on button press in pushbutton_interpolate.
function pushbutton_interpolate_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
% hObject    handle to pushbutton_interpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% mass = handles.metricdata.density * handles.metricdata.volume;
% set(handles.mass, 'String', mass);

% Command-line feedback to user
display('Interpolating Channels');


% Save the input variables to output
handles.output = {        ...
    handles.replaceChannels,   ...
    handles.ignoreChannels,    ...
    handles.interpolationMethod ...
    };

% Update handles structure
guidata(hObject, handles);
uiresume(handles.gui_figure);

% --- Executes on button press in pushbutton_cancel.
function pushbutton_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Command-line feedback to user
disp('User selected Cancel')

% Clear all input variables
handles.output = []; 

% Update handles structure
guidata(hObject, handles);
uiresume(handles.gui_figure);



% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset) %#ok<*INUSD>
% If the metricdata field is present and the pushbutton_cancel flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to pushbutton_cancel the data.


handles.replaceChannels    = '[]';
handles.ignoreChannels     = '[]';
handles.interpolationMethod = 'spherical';
 
set(handles.editbox_replaceChannels,     'String',         num2str(handles.replaceChannels));
set(handles.editbox_ignoreChannels,      'String',         num2str(handles.ignoreChannels));
set(handles.uipanel_interpolationMethod, 'SelectedObject', handles.radiobutton_spherical);


%
% Name & version
%
version = geterplabversion;
set(handles.gui_figure,'Name', ['ERPLAB ' version '   -   EXTRACT BINEPOCHS GUI'])

%
% Color GUI
%
handles = painterplab(handles);

%
% Set font size
%
handles = setfonterplab(handles);


% Update handles structure
guidata(handles.gui_figure, handles);




function editbox_replaceChannels_Callback(hObject, eventdata, handles)
% hObject    handle to editbox_replaceChannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editbox_replaceChannels as text
%        str2double(get(hObject,'String')) returns contents of editbox_replaceChannels as a double

% Using `str2num` (vs `str2double`) to handle both string arrray input and
% single string/character input

% Strip any non-numeric token and replace w/ whitespace (' ')
editString              = regexprep(get(hObject,'String'), '[\D]', ' ');
handles.replaceChannels = str2num(editString);  %#ok<ST2NM>

% Display corrected channels back to GUI
set(handles.editbox_replaceChannels, 'String', editString);

% Save the new replace channels value
guidata(hObject,handles)


function editbox_ignoreChannels_Callback(hObject, eventdata, handles)
% hObject    handle to editbox_ignoreChannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editbox_ignoreChannels as text
%        str2double(get(hObject,'String')) returns contents of editbox_ignoreChannels as a double

% Strip any non-numeric token and replace w/ whitespace (' ')
editString             = regexprep(get(hObject,'String'), '[\D]', ' ');
handles.ignoreChannels = str2num(editString);  %#ok<ST2NM>

% Display corrected channels back to GUI
set(handles.editbox_ignoreChannels, 'String', editString);

% Save the new ignore channels value
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editbox_ignoreChannels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editbox_ignoreChannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanel_interpolationMethod.
function uipanel_interpolationMethod_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_interpolationMethod 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

% Set interpolation method input value depending on which radial button was selected
if (hObject == handles.radiobutton_spherical)
    handles.interpolationMethod = 'spherical';
elseif (hObject == handles.radiobutton_inverseDistance)
    handles.interpolationMethod = 'invdist';
elseif (hObject == handles.radiobutton_spaceTime)
    handles.interpolationMethod = 'spacetime';
end

% Save the new interpolation method value
guidata(hObject,handles)
