function varargout = AnaReg_V1(varargin)
% ANAREG_V1 MATLAB code for AnaReg_V1.fig
%      ANAREG_V1, by itself, creates a new ANAREG_V1 or raises the existing
%      singleton*.
%
%      H = ANAREG_V1 returns the handle to a new ANAREG_V1 or the handle to
%      the existing singleton*.
%
%      ANAREG_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANAREG_V1.M with the given input arguments.
%
%      ANAREG_V1('Property','Value',...) creates a new ANAREG_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnaReg_V1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnaReg_V1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnaReg_V1

% Last Modified by GUIDE v2.5 10-Feb-2023 16:37:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnaReg_V1_OpeningFcn, ...
                   'gui_OutputFcn',  @AnaReg_V1_OutputFcn, ...
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


% --- Executes just before AnaReg_V1 is made visible.
function AnaReg_V1_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnaReg_V1 (see VARARGIN)

% Choose default command line output for AnaReg_V1
FotoEsqRegulacionProcesos = imread('FotoEsqRegulacionProcesos.jpg' ); %Leer imagen
axes(handles.Fig_Fondo);
axis off;
imshow(FotoEsqRegulacionProcesos);

%Para escalón de Referencia
set(handles.edit_Tiempo_Escalon_Ref,'String','');
set(handles.edit_Valor_Inicial_Ref,'String','0');
set(handles.edit_Valor_Inicial_Ref,'Enable','off');
set(handles.edit_Valor_Final_Ref,'String','');
%Fin escalón de Referencia
%Para Regulador
set(handles.edit_P,'String','');
set(handles.edit_I,'String','');
set(handles.edit_D,'String','');
%Fin Regulador
%Para Elemento de Acción Final Gv(s)
set(handles.edit_Kv,'String','');
set(handles.edit_Tv,'String','');
%Fin Elemento de Acción Final Gv(s)
%Para Proceso Gp(s)
set(handles.edit_Kp,'String','');
set(handles.edit_Tp,'String','');
%Fin Proceso Gp(s)
%Para Sensor/Transmisor Medición Hm(s)  
set(handles.edit_Km,'String','');
set(handles.edit_Tm,'String','');
%Fin Sensor/Transmisor Medición Hm(s)
%Para escalón en Perturbación
set(handles.edit_Tiempo_Escalon_Pert,'String','');
set(handles.edit_Valor_Inicial_Pert,'String','0');
set(handles.edit_Valor_Inicial_Pert,'Enable','off');
set(handles.edit_Valor_Final_Pert,'String','');
%Fin escalón en Perturbación
%Para Perturbación Gd(s)
set(handles.edit_Kd,'String','');
set(handles.edit_Td,'String','');
%Para Perturbación Gd(s)
%Inhabilitando Botones y menu
set(handles.Ajuste_Regulador,'Enable','off');
set(handles.Modelo_Aproximado,'Enable','off');
set(handles.Respuesta_Temporal,'Enable','off');
set(handles.pushbutton_Limpiar,'Enable','off');

handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnaReg_V1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AnaReg_V1_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%--------------Parámetros de Gr(s)-----------------------------------------

function edit_P_Callback(hObject, ~, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_P as text
%        str2double(get(hObject,'String')) returns contents of edit_P as a double
P=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(P,2);
if Val == 1
    set(handles.edit_P,'String','');
else
    handles.P=P;
    set(handles.pushbutton_Limpiar,'Enable','on');
end

%Validando para habilitar Menu Completo
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
    set(handles.Respuesta_Temporal,'Enable','on');
end

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_P_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_I_Callback(hObject, ~, handles)
% hObject    handle to edit_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_I as text
%        str2double(get(hObject,'String')) returns contents of edit_I as a double
I=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(I,2);
if Val == 1
    set(handles.edit_I,'String','');
else
    handles.I=I;
    set(handles.pushbutton_Limpiar,'Enable','on');
end

%Validando para habilitar Menu Completo
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_I_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_D_Callback(hObject, ~, handles)
% hObject    handle to edit_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_D as text
%        str2double(get(hObject,'String')) returns contents of edit_D as a double
D=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(D,2);
if Val == 1
    set(handles.edit_D,'String','');
else
    handles.D=D;
    set(handles.pushbutton_Limpiar,'Enable','on');
end

%Validando para habilitar Menu Completo
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_D_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%--------------Fin de Parámetros de Gr(s)----------------------------------


%--------------Parámetros de Gv(s)-----------------------------------------

function edit_Kv_Callback(hObject, ~, handles)
% hObject    handle to edit_Kv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Kv as text
%        str2double(get(hObject,'String')) returns contents of edit_Kv as a double
Kv=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(Kv,1);
if Val == 1
    set(handles.edit_Kv,'String','');
else
    handles.Kv=Kv;
    set(handles.pushbutton_Limpiar,'Enable','on');
end
%Validando para habilitar Menu Modelo Aprox. y Ajuste Reg.
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,1,1,1,1,1,1,1,1,1,1,1);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_Kv_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Kv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Tv_Callback(hObject, ~, handles)
% hObject    handle to edit_Tv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Tv as text
%        str2double(get(hObject,'String')) returns contents of edit_Tv as a double
Tv=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(Tv,0);
if Val == 1
    set(handles.edit_Tv,'String','');
else
    handles.Tv=Tv;
    set(handles.pushbutton_Limpiar,'Enable','on');
end

%Validando para habilitar Menu Modelo Aprox. y Ajuste Reg.
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,1,1,1,1,1,1,1,1,1,1,1);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_Tv_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Tv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-------------- Fin de Parámetros de Gv(s)---------------------------------

%--------------Parámetros de Gp(s)-----------------------------------------

function edit_Kp_Callback(hObject, ~, handles)
% hObject    handle to edit_Kp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Kp as text
%        str2double(get(hObject,'String')) returns contents of edit_Kp as a double
Kp=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(Kp,1);
if Val == 1
    set(handles.edit_Kp,'String','');
else
    handles.Kp=Kp;
    set(handles.pushbutton_Limpiar,'Enable','on');
end

%Validando para habilitar Menu Modelo Aprox. y Ajuste Reg.
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,1,1,1,1,1,1,1,1,1,1,1);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_Kp_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Kp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_Tp_Callback(hObject, ~, handles)
% hObject    handle to edit_Tp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Tp as text
%        str2double(get(hObject,'String')) returns contents of edit_Tp as a double
Tp=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(Tp,0);
if Val == 1
    set(handles.edit_Tp,'String','');
else
    handles.Tp=Tp;
    set(handles.pushbutton_Limpiar,'Enable','on');
end

%Validando para habilitar Menu Modelo Aprox. y Ajuste Reg.
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,1,1,1,1,1,1,1,1,1,1,1);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_Tp_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Tp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%--------------Fin de Parámetros de Gp(s)----------------------------------

%--------------Parámetros de Gd(s)-----------------------------------------

function edit_Kd_Callback(hObject,~, handles)
% hObject    handle to edit_Kd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Kd as text
%        str2double(get(hObject,'String')) returns contents of edit_Kd as a double
Kd=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(Kd,1);
if Val == 1
    set(handles.edit_Kd,'String','');
else
    handles.Kd=Kd;
    set(handles.pushbutton_Limpiar,'Enable','on');
end

%Validando para habilitar Menu Completo
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_Kd_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Kd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Td_Callback(hObject, ~, handles)
% hObject    handle to edit_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Td as text
%        str2double(get(hObject,'String')) returns contents of edit_Td as a double
Td=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(Td,0);
if Val == 1
    set(handles.edit_Td,'String','');
else
    handles.Td=Td;
    set(handles.pushbutton_Limpiar,'Enable','on');
end

%Validando para habilitar Menu Completo
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_Td_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%--------------Fin de Parámetros de Gp(s)----------------------------------

%--------------Parámetros de Hm(s)-----------------------------------------

function edit_Km_Callback(hObject, ~, handles)
% hObject    handle to edit_Km (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Km as text
%        str2double(get(hObject,'String')) returns contents of edit_Km as a double
Km=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(Km,1);
if Val == 1
    set(handles.edit_Km,'String','');
else
    handles.Km=Km;
    set(handles.pushbutton_Limpiar,'Enable','on');
end

%Validando para habilitar Menu Modelo Aprox. y Ajuste Reg.
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,1,1,1,1,1,1,1,1,1,1,1);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_Km_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Km (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Tm_Callback(hObject, ~, handles)
% hObject    handle to edit_Tm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Tm as text
%        str2double(get(hObject,'String')) returns contents of edit_Tm as a double
Tm=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(Tm,0);
if Val == 1
    set(handles.edit_Tm,'String','');
else
    handles.Tm=Tm;
    set(handles.pushbutton_Limpiar,'Enable','on');
end

%Validando para habilitar Menu Modelo Aprox. y Ajuste Reg.
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,1,1,1,1,1,1,1,1,1,1,1);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_Tm_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Tm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%--------------Fin de Parámetros de Hm(s)----------------------------------


%--------------Parámetros de Referencia(s)---------------------------------

function edit_Tiempo_Escalon_Ref_Callback(hObject, ~, handles)
% hObject    handle to edit_Tiempo_Escalon_Ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Tiempo_Escalon_Ref as text
%        str2double(get(hObject,'String')) returns contents of edit_Tiempo_Escalon_Ref as a double
Tiempo_Escalon_Ref=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(Tiempo_Escalon_Ref,0);
if Val == 1
    set(handles.edit_Tiempo_Escalon_Ref,'String','');
else
    handles.Tiempo_Escalon_Ref=Tiempo_Escalon_Ref;
    set(handles.pushbutton_Limpiar,'Enable','on');
end

%Validando para habilitar Menu Completo
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_Tiempo_Escalon_Ref_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Tiempo_Escalon_Ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Valor_Inicial_Ref_Callback(hObject, ~, handles)
% hObject    handle to edit_Valor_Inicial_Ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Valor_Inicial_Ref as text
%        str2double(get(hObject,'String')) returns contents of edit_Valor_Inicial_Ref as a double


% --- Executes during object creation, after setting all properties.
function edit_Valor_Inicial_Ref_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Valor_Inicial_Ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Valor_Final_Ref_Callback(hObject, ~, handles)
% hObject    handle to edit_Valor_Final_Ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Valor_Final_Ref as text
%        str2double(get(hObject,'String')) returns contents of edit_Valor_Final_Ref as a double
Valor_Final_Ref=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(Valor_Final_Ref,2);
if Val == 1
    set(handles.edit_Valor_Final_Ref,'String','');
else
    handles.Valor_Final_Ref=Valor_Final_Ref;
    set(handles.pushbutton_Limpiar,'Enable','on');
end

%Validando para habilitar Menu Completo
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_Valor_Final_Ref_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Valor_Final_Ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%--------------Fin de Parámetros de Referencia(s)--------------------------


%--------------Parámetros de Perturbación(s)-------------------------------

function edit_Tiempo_Escalon_Pert_Callback(hObject, ~, handles)
% hObject    handle to edit_Tiempo_Escalon_Pert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Tiempo_Escalon_Pert as text
%        str2double(get(hObject,'String')) returns contents of edit_Tiempo_Escalon_Pert as a double
Tiempo_Escalon_Pert=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(Tiempo_Escalon_Pert,0);
if Val == 1
    set(handles.edit_Tiempo_Escalon_Pert,'String','');
else
    handles.Tiempo_Escalon_Pert=Tiempo_Escalon_Pert;
    set(handles.pushbutton_Limpiar,'Enable','on');
end

%Validando para habilitar Menu Completo
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_Tiempo_Escalon_Pert_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Tiempo_Escalon_Pert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Valor_Inicial_Pert_Callback(hObject, ~, handles)
% hObject    handle to edit_Valor_Inicial_Pert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Valor_Inicial_Pert as text
%        str2double(get(hObject,'String')) returns contents of edit_Valor_Inicial_Pert as a double


% --- Executes during object creation, after setting all properties.
function edit_Valor_Inicial_Pert_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Valor_Inicial_Pert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Valor_Final_Pert_Callback(hObject, ~, handles)
% hObject    handle to edit_Valor_Final_Pert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Valor_Final_Pert as text
%        str2double(get(hObject,'String')) returns contents of edit_Valor_Final_Pert as a double
Valor_Final_Pert=str2double(get(hObject,'String'));
Val=Valida_AnaReg_V1(Valor_Final_Pert,2);
if Val == 1
    set(handles.edit_Valor_Final_Pert,'String','');
else
    handles.Valor_Final_Pert=Valor_Final_Pert;
    set(handles.pushbutton_Limpiar,'Enable','on');
end

%Validando para habilitar Menu Completo
P1=get(handles.edit_Kv,'String');
P2=get(handles.edit_Tv,'String');
P3=get(handles.edit_Kp,'String');
P4=get(handles.edit_Tp,'String');
P5=get(handles.edit_Km,'String');
P6=get(handles.edit_Tm,'String');
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(P1,P2,P3,P4,P5,P6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Modelo_Aproximado,'Enable','on');
    set(handles.Ajuste_Regulador,'Enable','on');
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_Valor_Final_Pert_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Valor_Final_Pert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%--------------Fin de Parámetros de Referencia(s)--------------------------


%----------------Area de Menues--------------------------------------------

% --------------------------------------------------------------------
function Menu_Analisis_Callback(hObject, ~, handles)
% hObject    handle to Menu_Analisis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Modelo_Aproximado_Callback(hObject, ~, handles)
% hObject    handle to Modelo_Aproximado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kv1=handles.Kv;
Kp1=handles.Kp;
Km1=handles.Km;
Tv1=handles.Tv;
Tp1=handles.Tp;
Tm1=handles.Tm;
% Obtención de los parámetros del Modelo Aproximado FOPTD
Tmodapr=max([Tv1,Tp1,Tm1]);
Kmodapr=Kv1*Kp1*Km1;
Thetamodapr=Tv1+Tp1+Tm1-Tmodapr;
% Fin de Obtención de los parámetros del Modelo Aproximado FOPTD
% Creación de la TF del modelo aproximado SysModApr
SysModApr=tf(Kmodapr,[Tmodapr 1],'ioDelay',Thetamodapr);
Sys=tf(Kv1,[Tv1 1])*tf(Kp1,[Tp1 1])*tf(Km1,[Tm1 1]);
vector_tiempo=0:Tmodapr/10:6*Tmodapr;
ySysModApr=step(SysModApr,vector_tiempo);
ySys=step(Sys,vector_tiempo);
fg1=figure(1);
set(fg1,'NumberTitle','off',...
    'Name','AnaReg _V1: Compara Modelos'),...
    hspt1=subplot(1,1,1,'FontName','Times New Roman','FontSize',12);
    hold(hspt1,'all'),...
    plot(vector_tiempo,ySys,'r',vector_tiempo,ySysModApr,'--bs','LineWidth',2,'MarkerSize',2,...
    'MarkerEdgeColor','b','MarkerFaceColor','r'),...
    grid,...
    legend('G_v(s)*G_p(s)*H_m(s)',...
    'G_{aprox}(s)=K_{aprox}*exp(-s*\theta)/(T_{aprox}*s+1)',...
    'Location','SouthEast'),...
    xlim([0 vector_tiempo(end)]),...
    title({'Compara G_v(s)*G_p(s)*H_m(s) vs. G_{aprox}(s)';['K_{aprox}= ',...
    num2str(Kmodapr),';  T_{aprox}= ',num2str(Tmodapr),...
    ';  \theta= ',num2str(Thetamodapr)]}),...
    ylabel('Variable medida(t)'),...
    xlabel('Tiempo')



% --------------------------------------------------------------------
function Respuesta_Temporal_Callback(hObject, ~, handles)
% hObject    handle to Respuesta_Temporal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Cargando regulador
P=handles.P;
I=handles.I;
D=handles.D;
Grs = tf([D P I],[1 0]);
% Cargando FT Gv(s)*Gp(s)*Hm(s)
Kv1=handles.Kv;
Tv1=handles.Tv;
Gvs = tf(Kv1,[Tv1 1]);
Kp1=handles.Kp;
Tp1=handles.Tp;
Gps= tf(Kp1,[Tp1 1]);
Km1=handles.Km;
Tm1=handles.Tm;
Hms= tf(Km1,[Tm1 1]);
Kd1=handles.Kd;
Td1=handles.Td;
Gds= tf(Kd1,[Td1 1]);
%Calculo de la FT directa
DTFs = Grs*Gvs*Gps;
%Calculo de la FTLC
CLTFsist = feedback(DTFs,Hms);
%Creación de los parámetros y variables de simulación
Tmodapr=max([Tv1,Tp1,Tm1]);
vector_tiempo=0:Tmodapr/40:4*Tmodapr;
long_vector_tiempo=length(vector_tiempo);
Tiempo_Escalon_Ref=handles.Tiempo_Escalon_Ref;
Valor_Final_Ref=handles.Valor_Final_Ref;
senal_Reft=zeros(1,long_vector_tiempo);
Tiempo_Escalon_Pert=handles.Tiempo_Escalon_Pert;
Valor_Final_Pert=handles.Valor_Final_Pert;
senal_Pert=zeros(1,long_vector_tiempo);
for item=1:long_vector_tiempo
    if vector_tiempo(item) >= Tiempo_Escalon_Ref
        senal_Reft(item)=Valor_Final_Ref;
    end
    if vector_tiempo(item) >= Tiempo_Escalon_Pert
        senal_Pert(item)=Valor_Final_Pert;
    end
end
%Simulando sistema con perturbación
y_Ref = lsim(CLTFsist,senal_Reft,vector_tiempo);
CLTFDist=feedback(1,Grs*Gvs*Gps*Hms);%FTPerturbacionLazoCerrado
y_PertLC= lsim(Gds*CLTFDist,senal_Pert,vector_tiempo);
y_sist=y_Ref+y_PertLC;
y_Pert= lsim(Gds,senal_Pert,vector_tiempo);
y_medida=lsim(Hms,y_sist,vector_tiempo);
error_sist=senal_Reft-y_medida.';
GrsPI=tf([P I],[1 0]);
senal_controlPI=lsim(GrsPI,error_sist,vector_tiempo);
GrsD=tf([100*D 0],[1 100]);
senal_controlD=lsim(GrsD,error_sist,vector_tiempo);
senal_control=senal_controlPI+senal_controlD;
variable_manipulada=lsim(Gvs,senal_control,vector_tiempo);
fg2=figure(2);
    clf(figure(2)),...
    set(fg2,'NumberTitle','off',...
    'Name','AnaReg _V1: Respuesta Temporal'),...
    hspt1=subplot(4,2,1,'FontName','Times New Roman','FontSize',12);
    hold(hspt1,'all'),...
    plot(vector_tiempo,senal_Reft,'r','LineWidth',2,'MarkerSize',2,...
    'MarkerEdgeColor','b','MarkerFaceColor','r'),...
    grid,...
    xlim([0 vector_tiempo(end)]),...
    ylabel('r(t)'),...
    xlabel('Tiempo'),...
    hspt2=subplot(4,2,2,'FontName','Times New Roman','FontSize',12);
    hold(hspt2,'all'),...
    plot(vector_tiempo,senal_Pert,'g','LineWidth',2,'MarkerSize',2,...
    'MarkerEdgeColor','b','MarkerFaceColor','r'),...
    grid,...
    xlim([0 vector_tiempo(end)]),...
    ylabel('Perturbación'),...
    xlabel('Tiempo')
    hspt3=subplot(4,2,3,'FontName','Times New Roman','FontSize',12);
    hold(hspt3,'all'),...
    plot(vector_tiempo,error_sist,'k','LineWidth',2,'MarkerSize',2,...
    'MarkerEdgeColor','b','MarkerFaceColor','r'),...
    grid,...
    xlim([0 vector_tiempo(end)]),...
    ylabel('e(t)'),...
    xlabel('Tiempo'),...
    hspt4=subplot(4,2,4,'FontName','Times New Roman','FontSize',12);
    hold(hspt4,'all'),...
    plot(vector_tiempo,y_Pert,'m','LineWidth',2,'MarkerSize',2,...
    'MarkerEdgeColor','b','MarkerFaceColor','r'),...
    grid,...
    xlim([0 vector_tiempo(end)]),...
    ylabel('yd(t)'),...
    xlabel('Tiempo'),...
    hspt5=subplot(4,2,5,'FontName','Times New Roman','FontSize',12);
    hold(hspt5,'all'),...
    plot(vector_tiempo,senal_control,'c','LineWidth',2,'MarkerSize',2,...
    'MarkerEdgeColor','b','MarkerFaceColor','r'),...
    grid,...
    xlim([0 vector_tiempo(end)]),...
    ylabel('u(t)'),...
    xlabel('Tiempo'),...
    hspt6=subplot(4,2,6,'FontName','Times New Roman','FontSize',12);
    hold(hspt6,'all'),...
    plot(vector_tiempo,variable_manipulada,'--k','LineWidth',2,'MarkerSize',2,...
    'MarkerEdgeColor','b','MarkerFaceColor','r'),...
    grid,...
    xlim([0 vector_tiempo(end)]),...
    ylabel('vm(t)'),...
    xlabel('Tiempo'),...
    hspt7=subplot(4,2,7,'FontName','Times New Roman','FontSize',12);
    hold(hspt7,'all'),...
    plot(vector_tiempo,y_sist,'--bs','LineWidth',2,'MarkerSize',2,...
    'MarkerEdgeColor','b','MarkerFaceColor','r'),...
    grid,...
    xlim([0 vector_tiempo(end)]),...
    ylabel('y(t)'),...
    xlabel('Tiempo')


% --------------------------------------------------------------------
function Ayuda_Callback(hObject, ~, handles)
% hObject    handle to Ayuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Ayuda_Acerca_de_Callback(hObject, ~, ~)
% hObject    handle to Ayuda_Acerca_de (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hmsgb=msgbox({'AnaReg_V1',...
    '---------------------------------------',...
    'AnaReg Versión 1.0.',...
    'Analiza sistemas de Regulación de tiempo continuo.',...
    'Programa que permite el ajuste de Reguladores de tiempo continuo ',...
    'basado   en   diferentes  criterios  y  la simulación  para   analizar  el',...
    'desempeño del lazo de regulación de procesos tecnológicos.',...
    '',...
    'Creado: 08/02/2023' '' 'Autores:' '-------------',...
    '* Est. Luis Alexis Rojas Rondan',...
    '* Est. Malena Arias Muños',...
    '* Dr.C. MSc. Ing. Henry Bory Prevez' ,...
    '* Ing. Angel Orlando Castellano Sanches'},'Acerca de:');


% --------------------------------------------------------------------
function Ayuda_Descripcion_Callback(hObject, ~, ~)
% hObject    handle to Ayuda_Descripcion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str={'AnaRed_V1',
   '-> ¿Qué es AnaRed_V1?',
   ' Programa de Análisis de los Sistemas de Regulación de Tiempo Continuo',
   'a lazo cerrado de Procesos Tecnológicos mediante simulación.',
   'AnaRed_V1 le permite al usuario entrar los parámetros de ajuste del regu_',
   'lador o ajustar dicho regulador según:',
   ' - Tipo de regulador.',
   ' - Criterio de Ajuste.',
   ' AnaRed_V1  ajusta  el  regulador  usando  el modelo de  primer orden con',
   'retraso de transporte que AnaRed_V1 determina.',
   ' AnaReg_V1 fue desarrollado con el programa profesional MatLab.',
   '',
   '-> Descripción de AnaRed_V1:',
   '  AnaRed_V1 funciona a partir de la ventana principal llamada: AnaRed_V1',
   'y constituida por una barra de menú con las opciones: Análisis y Ayuda.',
   '',
   ' En Análisis  se  brindan  las  opciones:  Modelo  Aproximado con  Retraso ',
   'de Transporte, Ajuste Regulador y Respuesta Temporal.',
   ' En Ayuda están las opciones Acerca de:, Descripción y Funcionamiento.',
   '  En el área central de la ventana se representa el diagrama de bloques',
   'de un lazo de regulación típico de procesos tecnalógicos. Los bloques',
   'nombrados: Gr(s), Gv(s), Gp(s), Hm(s), Gd(s), Referencia y P Perturbación',
   'representan respectivamente las funciones transferencia del Regulador,',
   'Elemento de Acción Final, Proceso, Medición y de la Perturbación del',
   'Proceso, y las señales en escalón de la referencia y la perturbación. Los',
   'parámetros de estos bloques el ususario puede entrarlos por medio de',
   'textos editables ubicados cercanos a su respectivo bloque.',
   ' Para el caso del bloque Gr(s) el usuario puede entrar los parámetros del',
   'regulador o indicarle al programa que haga el ajuste de este.',
   ' Los bloques r(t), e(t), u(t), vm(t), y(t) y yd(t), representan los visua_',
   'lizadores de las señales de Referencia, error, regulación, variable',
   'manipulada, variable regulada y la perturbación transformada por Gd(s).'
   '  En la parte  inferior derecha de la ventana principal están los botones',
   'Limpiar, se activa al introducir un dato y este borra los datos entrados ',
   'al programa, y Salir ->>, usado para finalizar AnaRed_V1.',
   '',};
handle_Descripcion_hlp=helpdlg(str,'Ayuda: Descripción de AnaRed_V1');
waitfor(handle_Descripcion_hlp);


% --------------------------------------------------------------------
function Ayuda_Funcionamiento_Callback(hObject, ~, ~)
% hObject    handle to Ayuda_Funcionamiento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handle_Funcionamiento_hlp=helpdlg({'¿Qué pasos debe seguir el usuario para usar AnaReg_V1?',...
    ' *  Si el usuario desea diseñar, ajustar el regulador y verificar mediante',...
    'simulación el desempeño del lazo, debe seguir los siguientes pasos:',...
    '',...
    '1ro. Introducir los valores de los parámetros de Gv(s), Gp(s) y Hm(s),',...
    'con lo cual se activarán las opciones del menú de Análisis:',...
    'Modelo Aproximado con Retraso de Transporte, y Ajuste Regulador',...
    '',...
    '2do. Presionar Modelo Aproximado y Retaso de Transporte, si desea obtener',...
    'los parámetros de este modelo y comparar las curvas de respuesta de este',...
    'con la del modelo Gv(s)*Gp(s)*Hm(s) ante escalón unitario aplicado en t=0,',...
    'y/o presionar Ajuste Regulador',...
    '',...
    '3ro. Presionar Ajuste Regulador, esto despliega un submenú en el cual el',...
    'usuario debe escoger el tipo de regulador a ajustar.',...
    '',...
    '4to. Presionar sobre uno de los tipos de reguladores, esto despliega el ',...
    'submenú para la selección de un criterio de ajuste.',...
    '',...
    '5to. Presionar  sobre  un  criterio de  ajuste, el  programa calcula los',...
    'parámetros del regulador seleccionado y muestra los valores en los textos ',...
    'editables debajo de la función transferencia del regulador Gr(s) siendo P ',...
    'la ganancia proporcioanal, I ganancia integral y D ganancia derivativa.',...
    '',...
    '6to. Entrar el resto de los parámetros solicitados en la ventana principal ',...
    'y luego presionar la opción Respuesta Temporal del menú Análisis lo cual',...
    'abre una ventana con las gráficas de las diferentes señales del diagrama.',...
    '',...
    ' *  Si el usuario desea verificar mediante simulación su ajuste:',...
    '1ro. Introducir los valores de todos los parámetros.',...
    '',...
    '2do. Presionar la opción Respuesta Temporal del menú Análisis.',...
    '',...
    'Para eliminar los datos introducidos, presionar el botón Limpiar,',...
    'esto desactiva las opciones del menú Análisis.',...
    'Para salir y cerrar el programa presione el botón Salir ->>'},...
    'Ayuda: Funcionamiento de AnaRed_V1');
waitfor(handle_Funcionamiento_hlp);

%----------------Fin de Area de Menues-------------------------------------

%--------------Botones Cargar, Limpar y Salir------------------------------

% --- Executes on button press in pushbutton_Salir.
function pushbutton_Salir_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_Salir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;


% --- Executes on button press in pushbutton_Limpiar.
function pushbutton_Limpiar_Callback(hObject, ~, handles)
% hObject    handle to pushbutton_Limpiar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Para escalón de Referencia
set(handles.edit_Tiempo_Escalon_Ref,'String','');
%set(handles.edit_Valor_Inicial_Ref,'String','');
set(handles.edit_Valor_Final_Ref,'String','');
%Fin escalón de Referencia
%Para Regulador
set(handles.edit_P,'String','');
set(handles.edit_I,'String','');
set(handles.edit_D,'String','');
%Fin Regulador
%Para Elemento de Acción Final Gv(s)
set(handles.edit_Kv,'String','');
set(handles.edit_Tv,'String','');
%Fin Elemento de Acción Final Gv(s)
%Para Proceso Gp(s)
set(handles.edit_Kp,'String','');
set(handles.edit_Tp,'String','');
%Fin Proceso Gp(s)
%Para Sensor/Transmisor Medición Hm(s)  
set(handles.edit_Km,'String','');
set(handles.edit_Tm,'String','');
%Fin Sensor/Transmisor Medición Hm(s)
%Para escalón en Perturbación
set(handles.edit_Tiempo_Escalon_Pert,'String','');
%set(handles.edit_Valor_Inicial_Pert,'String','');
set(handles.edit_Valor_Final_Pert,'String','');
%Fin escalón en Perturbación
%Para Perturbación Gd(s)
set(handles.edit_Kd,'String','');
set(handles.edit_Td,'String','');
%Para Perturbación Gd(s)
%Inhabilitando Botones y menu
%set(handles.pushbutton_Cargar,'Enable','off');
set(handles.Modelo_Aproximado,'Enable','off');
set(handles.Ajuste_Regulador,'Enable','off');
set(handles.Respuesta_Temporal,'Enable','off');
set(handles.pushbutton_Limpiar,'Enable','off');

%--------------Fin de Botones Limpar y Salir-------------------------------


%--------Ajuste de diferentes Reguladores y diversos criterios-------------

% --------------------------------------------------------------------
function Ajuste_Regulador_Callback(hObject, ~, handles)
% hObject    handle to Ajuste_Regulador (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Ajuste_Regulador_P_Callback(hObject, ~, handles)
% hObject    handle to Ajuste_Regulador_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Proporcional_Ziegler_Nichols_Callback(hObject, ~, handles)
% hObject    handle to Proporcional_Ziegler_Nichols (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kv1=handles.Kv;
Kp1=handles.Kp;
Km1=handles.Km;
Tv1=handles.Tv;
Tp1=handles.Tp;
Tm1=handles.Tm;
% Obtención de los parámetros del Modelo Aproximado FOPTD
Taomodelo=max([Tv1,Tp1,Tm1]);
Kmodelo=Kv1*Kp1*Km1;
tomodelo=Tv1+Tp1+Tm1-Taomodelo;
%Ajuste Ziegler_Nichols
P= Taomodelo/(tomodelo*Kmodelo);
set(handles.edit_P,'String',P)
handles.P=P;
set(handles.edit_I,'String',0)
handles.I=0;
set(handles.edit_D,'String',0)
handles.D=0;
%Validando para habilitar Menu Respuesta_Temporal
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(1,2,3,4,5,6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function Proporcional_Cohen_Coon_Callback(hObject, ~, handles)
% hObject    handle to Proporcional_Cohen_Coon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kv1=handles.Kv;
Kp1=handles.Kp;
Km1=handles.Km;
Tv1=handles.Tv;
Tp1=handles.Tp;
Tm1=handles.Tm;
% Obtención de los parámetros del Modelo Aproximado FOPTD
Taomodelo=max([Tv1,Tp1,Tm1]);
Kmodelo=Kv1*Kp1*Km1;
tomodelo=Tv1+Tp1+Tm1-Taomodelo;
%Ajuste Cohen_Coon
P= (Taomodelo/tomodelo+0.333)/Kmodelo;
set(handles.edit_P,'String',P)
handles.P=P;
set(handles.edit_I,'String',0)
handles.I=0;
set(handles.edit_D,'String',0)
handles.D=0;
%Validando para habilitar Menu Respuesta_Temporal
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(1,2,3,4,5,6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function Proporcional_Smith_Murril_Callback(hObject, ~, handles)
% hObject    handle to Proporcional_Smith_Murril (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kv1=handles.Kv;
Kp1=handles.Kp;
Km1=handles.Km;
Tv1=handles.Tv;
Tp1=handles.Tp;
Tm1=handles.Tm;
% Obtención de los parámetros del Modelo Aproximado FOPTD
Taomodelo=max([Tv1,Tp1,Tm1]);
Kmodelo=Kv1*Kp1*Km1;
tomodelo=Tv1+Tp1+Tm1-Taomodelo;
%Ajuste Smith_Murril
P= 1.208*((Taomodelo/tomodelo)^0.956)/Kmodelo;
set(handles.edit_P,'String',P)
handles.P=P;
set(handles.edit_I,'String',0)
handles.I=0;
set(handles.edit_D,'String',0)
handles.D=0;
%Validando para habilitar Menu Respuesta_Temporal
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(1,2,3,4,5,6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function Proporcional_Chien_Hrones_Reswick_Callback(hObject, ~, handles)
% hObject    handle to Proporcional_Chien_Hrones_Reswick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kv1=handles.Kv;
Kp1=handles.Kp;
Km1=handles.Km;
Tv1=handles.Tv;
Tp1=handles.Tp;
Tm1=handles.Tm;
% Obtención de los parámetros del Modelo Aproximado FOPTD
Taomodelo=max([Tv1,Tp1,Tm1]);
Kmodelo=Kv1*Kp1*Km1;
tomodelo=Tv1+Tp1+Tm1-Taomodelo;
%Ajuste Chien_Hrones_Reswick 20% SP
P= 0.7*Taomodelo/(tomodelo*Kmodelo);
set(handles.edit_P,'String',P)
handles.P=P;
set(handles.edit_I,'String',0)
handles.I=0;
set(handles.edit_D,'String',0)
handles.D=0;
%Validando para habilitar Menu Respuesta_Temporal
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(1,2,3,4,5,6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject, handles);



% --------------------------------------------------------------------
function Ajuste_Regulador_P_I_Callback(hObject, ~, handles)
% hObject    handle to Ajuste_Regulador_P_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Proporcional_Integral_Ziegler_Nichols_Callback(hObject, ~, handles)
% hObject    handle to Proporcional_Integral_Ziegler_Nichols (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kv1=handles.Kv;
Kp1=handles.Kp;
Km1=handles.Km;
Tv1=handles.Tv;
Tp1=handles.Tp;
Tm1=handles.Tm;
% Obtención de los parámetros del Modelo Aproximado FOPTD
Taomodelo=max([Tv1,Tp1,Tm1]);
Kmodelo=Kv1*Kp1*Km1;
tomodelo=Tv1+Tp1+Tm1-Taomodelo;
%Ajuste Ziegler_Nichols
P= 0.9*Taomodelo/(tomodelo*Kmodelo);
Ti=3.33*tomodelo;
I=P/Ti;
set(handles.edit_P,'String',P)
handles.P=P;
set(handles.edit_I,'String',I)
handles.I=I;
set(handles.edit_D,'String',0)
handles.D=0;
%Validando para habilitar Menu Respuesta_Temporal
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(1,2,3,4,5,6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function Proporcional_Integral_Cohen_Coon_Callback(hObject, ~, handles)
% hObject    handle to Proporcional_Integral_Cohen_Coon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kv1=handles.Kv;
Kp1=handles.Kp;
Km1=handles.Km;
Tv1=handles.Tv;
Tp1=handles.Tp;
Tm1=handles.Tm;
% Obtención de los parámetros del Modelo Aproximado FOPTD
Taomodelo=max([Tv1,Tp1,Tm1]);
Kmodelo=Kv1*Kp1*Km1;
tomodelo=Tv1+Tp1+Tm1-Taomodelo;
%Ajuste Cohen_Coon
P= (0.9*Taomodelo/tomodelo+0.083)/Kmodelo;
Ti=tomodelo*(3.33+0.33*tomodelo/Taomodelo)/(1+2.22*tomodelo/Taomodelo);
I=P/Ti;
set(handles.edit_P,'String',P)
handles.P=P;
set(handles.edit_I,'String',I)
handles.I=I;
set(handles.edit_D,'String',0)
handles.D=0;
%Validando para habilitar Menu Respuesta_Temporal
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(1,2,3,4,5,6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function Proporcional_Integral_Smith_Murril_Callback(hObject, ~, handles)
% hObject    handle to Proporcional_Integral_Smith_Murril (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kv1=handles.Kv;
Kp1=handles.Kp;
Km1=handles.Km;
Tv1=handles.Tv;
Tp1=handles.Tp;
Tm1=handles.Tm;
% Obtención de los parámetros del Modelo Aproximado FOPTD
Taomodelo=max([Tv1,Tp1,Tm1]);
Kmodelo=Kv1*Kp1*Km1;
tomodelo=Tv1+Tp1+Tm1-Taomodelo;
%Ajuste Smith_Murril
P= 0.928*((Taomodelo/tomodelo)^0.946)/Kmodelo;
Ti=0.928*Taomodelo*(tomodelo/Taomodelo)^0.583;
I=P/Ti;
set(handles.edit_P,'String',P)
handles.P=P;
set(handles.edit_I,'String',I)
handles.I=I;
set(handles.edit_D,'String',0)
handles.D=0;
%Validando para habilitar Menu Respuesta_Temporal
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(1,2,3,4,5,6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function Proporcional_Integral_Chien_Hrones_Reswick_Callback(hObject, ~, handles)
% hObject    handle to Proporcional_Integral_Chien_Hrones_Reswick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kv1=handles.Kv;
Kp1=handles.Kp;
Km1=handles.Km;
Tv1=handles.Tv;
Tp1=handles.Tp;
Tm1=handles.Tm;
% Obtención de los parámetros del Modelo Aproximado FOPTD
Taomodelo=max([Tv1,Tp1,Tm1]);
Kmodelo=Kv1*Kp1*Km1;
tomodelo=Tv1+Tp1+Tm1-Taomodelo;
%Ajuste Chien-Hrones-Reswick(CHR) Response 20 % SP
P= 0.6*Taomodelo/(tomodelo*Kmodelo);
Ti=Taomodelo;
I=P/Ti;
set(handles.edit_P,'String',P)
handles.P=P;
set(handles.edit_I,'String',I)
handles.I=I;
set(handles.edit_D,'String',0)
handles.D=0;
%Validando para habilitar Menu Respuesta_Temporal
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(1,2,3,4,5,6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function Ajuste_Regulador_P_I_D_Callback(hObject, ~, handles)
% hObject    handle to Ajuste_Regulador_P_I_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Proporcional_Integral_Derivativo_Ziegler_Nichols_Callback(hObject, ~, handles)
% hObject    handle to Proporcional_Integral_Derivativo_Ziegler_Nichols (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kv1=handles.Kv;
Kp1=handles.Kp;
Km1=handles.Km;
Tv1=handles.Tv;
Tp1=handles.Tp;
Tm1=handles.Tm;
% Obtención de los parámetros del Modelo Aproximado FOPTD
Taomodelo=max([Tv1,Tp1,Tm1]);
Kmodelo=Kv1*Kp1*Km1;
tomodelo=Tv1+Tp1+Tm1-Taomodelo;
%Ajuste Ziegler_Nichols
P= 1.2*Taomodelo/(tomodelo*Kmodelo);
Ti=2*tomodelo;
Td=0.5*tomodelo;
I=P/Ti;
D=P*Td;
set(handles.edit_P,'String',P)
handles.P=P;
set(handles.edit_I,'String',I)
handles.I=I;
set(handles.edit_D,'String',D)
handles.D=D;
%Validando para habilitar Menu Respuesta_Temporal
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(1,2,3,4,5,6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function Proporcional_Integral_Derivativo_Cohen_Coon_Callback(hObject, ~, handles)
% hObject    handle to Proporcional_Integral_Derivativo_Cohen_Coon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kv1=handles.Kv;
Kp1=handles.Kp;
Km1=handles.Km;
Tv1=handles.Tv;
Tp1=handles.Tp;
Tm1=handles.Tm;
% Obtención de los parámetros del Modelo Aproximado FOPTD
Taomodelo=max([Tv1,Tp1,Tm1]);
Kmodelo=Kv1*Kp1*Km1;
tomodelo=Tv1+Tp1+Tm1-Taomodelo;
%Ajuste Cohen_Coon
P= (1.33*Taomodelo/tomodelo+0.25)/Kmodelo;
Ti=tomodelo*(2.46+0.46*tomodelo/Taomodelo)/(1+0.6*tomodelo/Taomodelo);
Td=0.37*tomodelo/(1+0.2*tomodelo/Taomodelo);
I=P/Ti;
D=P*Td;
set(handles.edit_P,'String',P)
handles.P=P;
set(handles.edit_I,'String',I)
handles.I=I;
set(handles.edit_D,'String',D)
handles.D=D;
%Validando para habilitar Menu Respuesta_Temporal
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(1,2,3,4,5,6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function Proporcional_Integral_Derivativo_Smith_Murril_Callback(hObject, ~, handles)
% hObject    handle to Proporcional_Integral_Derivativo_Smith_Murril (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kv1=handles.Kv;
Kp1=handles.Kp;
Km1=handles.Km;
Tv1=handles.Tv;
Tp1=handles.Tp;
Tm1=handles.Tm;
% Obtención de los parámetros del Modelo Aproximado FOPTD
Taomodelo=max([Tv1,Tp1,Tm1]);
Kmodelo=Kv1*Kp1*Km1;
tomodelo=Tv1+Tp1+Tm1-Taomodelo;
%Ajuste Smith_Murril
P= 1.37*((Taomodelo/tomodelo)^0.950)/Kmodelo;
Ti=0.740*Taomodelo*(tomodelo/Taomodelo)^0.738;
Td=0.365*Taomodelo*(tomodelo/Taomodelo)^0.950;
I=P/Ti;
D=P*Td;
set(handles.edit_P,'String',P)
handles.P=P;
set(handles.edit_I,'String',I)
handles.I=I;
set(handles.edit_D,'String',D)
handles.D=D;
%Validando para habilitar Menu Respuesta_Temporal
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(1,2,3,4,5,6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function Proporcional_Integral_Derivativo_Chien_Hrones_Reswick_Callback(hObject, ~, handles)
% hObject    handle to Proporcional_Integral_Derivativo_Chien_Hrones_Reswick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kv1=handles.Kv;
Kp1=handles.Kp;
Km1=handles.Km;
Tv1=handles.Tv;
Tp1=handles.Tp;
Tm1=handles.Tm;
% Obtención de los parámetros del Modelo Aproximado FOPTD
Taomodelo=max([Tv1,Tp1,Tm1]);
Kmodelo=Kv1*Kp1*Km1;
tomodelo=Tv1+Tp1+Tm1-Taomodelo;
%Ajuste Chien_Hrones_Reswick (CHR)  Response 20 % SP
P= 0.95*Taomodelo/(tomodelo*Kmodelo);
Ti=1.35*Taomodelo;
Td=0.47*tomodelo;
I=P/Ti;
D=P*Td;
set(handles.edit_P,'String',P)
handles.P=P;
set(handles.edit_I,'String',I)
handles.I=I;
set(handles.edit_D,'String',D)
handles.D=D;
%Validando para habilitar Menu Respuesta_Temporal
P7=get(handles.edit_Kd,'String');
P8=get(handles.edit_Td,'String');
P9=get(handles.edit_Tiempo_Escalon_Ref,'String');
%P10=get(handles.editE0,'String'); Reservado
P11=get(handles.edit_Valor_Final_Ref,'String');
P12=get(handles.edit_Tiempo_Escalon_Pert,'String');
%P13=get(handles.editD0,'String'); Reservado
P14=get(handles.edit_Valor_Final_Pert,'String');
P15=get(handles.edit_P,'String');
P16=get(handles.edit_I,'String');
P17=get(handles.edit_D,'String');
ValAct=activador_Menu(1,2,3,4,5,6,P7,P8,P9,10,P11,P12,13,P14,P15,P16,P17);
if ValAct==0
    set(handles.Respuesta_Temporal,'Enable','on');
end
guidata(hObject, handles);
