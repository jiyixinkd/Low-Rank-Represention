function varargout = LRRUI(varargin)
% LRRUI MATLAB code for LRRUI.fig
%      LRRUI, by itself, creates a new LRRUI or raises the existing
%      singleton*.
%
%      H = LRRUI returns the handle to a new LRRUI or the handle to
%      the existing singleton*.
%
%      LRRUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LRRUI.M with the given input arguments.
%
%      LRRUI('Property','Value',...) creates a new LRRUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LRRUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LRRUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LRRUI

% Last Modified by GUIDE v2.5 24-May-2019 17:35:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LRRUI_OpeningFcn, ...
                   'gui_OutputFcn',  @LRRUI_OutputFcn, ...
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


% --- Executes just before LRRUI is made visible.
function LRRUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LRRUI (see VARARGIN)

% Choose default command line output for LRRUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LRRUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LRRUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function LRR_file_path_Callback(hObject, eventdata, handles)
% hObject    handle to LRR_file_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRR_file_path as text
%        str2double(get(hObject,'String')) returns contents of LRR_file_path as a double


% --- Executes during object creation, after setting all properties.
function LRR_file_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRR_file_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LRR_button_select.%                     
% ѡ���ļ�·��
function LRR_button_select_Callback(hObject, eventdata, handles)
% hObject    handle to LRR_button_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder_name = uigetdir;
set(handles.LRR_file_path,'String',folder_name);



function LRR_result_path_Callback(hObject, eventdata, handles)
%�������������������������������������������������������������������������������������ļ��ı���·��
% hObject    handle to LRR_result_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRR_result_path as text
%        str2double(get(hObject,'String')) returns contents of LRR_result_path as a double
folder_name = uigetdir;
set(handles.result_path,'String',folder_name);

% --- Executes during object creation, after setting all properties.
function LRR_result_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRR_result_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LRR_button_save.
% %ѡ��������·��
function LRR_button_save_Callback(hObject, eventdata, handles)
% hObject    handle to LRR_button_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder_name = uigetdir;
set(handles.LRR_result_path,'String',folder_name);





% --- Executes during object creation, after setting all properties.
function LRR_lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRR_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LRR_kmeans_iter_Callback(hObject, eventdata, handles)
% hObject    handle to LRR_kmeans_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRR_kmeans_iter as text
%        str2double(get(hObject,'String')) returns contents of LRR_kmeans_iter as a double


% --- Executes during object creation, after setting all properties.
function LRR_kmeans_iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRR_kmeans_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LRR_lambda_Callback(hObject, eventdata, handles)
% hObject    handle to LRR_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRR_lambda as text
%        str2double(get(hObject,'String')) returns contents of LRR_lambda as a double


% --- Executes on button press in LRR_run.
%�����������������������������������������������������������������������������������У�LRR
function LRR_run_Callback(hObject, eventdata, handles)               
% hObject    handle to LRR_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global LRR_result ;
addpath('LRR_code');
addpath('public_code');
disp('��ʼ...');
global sample_num;
global class_num;
LRR_class_num=int32(str2double(class_num));%������������
LRR_sample_num=int32(str2double(sample_num));

disp('�������ݼ�...');
global data_path;
[fea]=get_data2(data_path,LRR_sample_num);%��ȡ����
global LRR_fea;%���ڽ���������Ӧ�ļ���
LRR_fea=fea;


disp('���ݹ�һ��...');
X=data2one(fea);%��һ��

lambda=str2double(get(handles.LRR_lambda,'String'));%lambdaֵ

if (get(handles.LRR_self_dic,'value'))%�Ƿ������ֵ�
    self_dic=1;
else
    self_dic=0;
end

if (get(handles.LRR_L1_norm,'value'))%����
    norm=1;
else
    norm=21;
end

disp('��ȡ���ȱ�ʾ...');
[Z,E]=LRR_main(X,lambda,self_dic,norm);%LRR�ĺ��ĺ���

disp('�����׺;���...');
L=get_affinity(Z,LRR_class_num);
axes(handles.axes2);%��������ȥ����ʾ�׺;���
imshow(L);


disp('ִ���׾���...');
K_iter=int32(str2double(get(handles.LRR_kmeans_iter,'String')));%K_means��������
idx=spe_clust(L,K_iter,LRR_class_num);%�׾���
global LRR_idx;
LRR_idx=idx;%���������У������ļ�

disp('����ɢ��ͼ...');
axes(handles.axes3);
[COEFF,SCORE,latent] = pca(Z);
SCORE = SCORE(:,1:30);
mappedX = tsne(SCORE,'Algorithm','exact','NumDimensions',2);
axes(handles.axes3);%ʹ��ͼ�񣬲���������2
scatter(mappedX(:,1),mappedX(:,2),5,idx,'*');
disp('����ָ��...');

global labal_path;
if (isempty(labal_path))%���û��ר�ұ�ǩ���򲻼���ָ��
     msgbox('δѡ��ר�ұ�ǩ','ȷ��');
     disp('����ָ��ʧ��');
else
    data=load(labal_path);
    gnd=data.gnd(1:LRR_sample_num);
    size(gnd)
    size(idx)
    LRR_result = ClusteringMeasure(gnd,idx);%ָ��
    set(handles.LRR_ACC,'String',num2str(LRR_result(1,1)));
    set(handles.LRR_NMI,'String',num2str(LRR_result(1,2)));
    set(handles.LRR_purity,'String',num2str(LRR_result(1,3)));
end
disp('�������');

function LRR_class_num_Callback(hObject, eventdata, handles)
% hObject    handle to LRR_class_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRR_class_num as text
%        str2double(get(hObject,'String')) returns contents of LRR_class_num as a double


% --- Executes during object creation, after setting all properties.
function LRR_class_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRR_class_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function LRR_info_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRR_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function LRR_ACC_Callback(hObject, eventdata, handles)
% hObject    handle to LRR_ACC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRR_ACC as text
%        str2double(get(hObject,'String')) returns contents of LRR_ACC as a double


% --- Executes during object creation, after setting all properties.
function LRR_ACC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRR_ACC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LRR_NMI_Callback(hObject, eventdata, handles)
% hObject    handle to LRR_NMI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRR_NMI as text
%        str2double(get(hObject,'String')) returns contents of LRR_NMI as a double


% --- Executes during object creation, after setting all properties.
function LRR_NMI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRR_NMI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LRR_purity_Callback(hObject, eventdata, handles)
% hObject    handle to LRR_purity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRR_purity as text
%        str2double(get(hObject,'String')) returns contents of LRR_purity as a double


% --- Executes during object creation, after setting all properties.
function LRR_purity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRR_purity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in LRR_save.
function LRR_save_Callback(hObject, eventdata, handles)
% hObject    handle to LRR_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%LRR_result(1,1)=str2double(get(handles.LRR_ACC,'String'));
%LRR_result(1,2)=str2double(get(handles.LRR_NMI,'String'));
%LRR_result(1,3)=str2double(get(handles.LRR_purity,'String'));


% --- Executes on button press in LRR_UI_save_rep.
function LRR_UI_save_rep_Callback(hObject, eventdata, handles)
% hObject    handle to LRR_UI_save_rep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
new_f_handle=figure('visible','off'); %�½�һ�����ɼ���figure
new_axes=copyobj(handles.axes2,new_f_handle); %axes2��GUI������Ҫ����ͼ�ߵ�Tag������copy�����ɼ���figure��
set(new_axes,'Units','normalized','Position',[0.1 0.1 0.8 0.8]);%��ͼƬ����
%set(new_axes,'Units','normalized','Position',[1 1 1 1]);%��ͼ������
[filename pathname fileindex]=uiputfile({'*.png';'*.bmp';'*.jpg';'*.eps';},'ͼƬ����Ϊ');
if  filename~=0%δ�㡰ȡ������ť��δ�ر�
        file=strcat(pathname,filename);
        switch fileindex %���ݲ�ͬ��ѡ�񱣴�Ϊ��ͬ������        
            case 1
                print(new_f_handle,'-dpng',file);% print(new_f_handle,'-dpng',filename);Ч��һ������ͼ���ӡ��ָ���ļ���
                fprintf('>>�ѱ��浽��%s\n',file);
            case 2
                print(new_f_handle,'-dbmp',file);
                fprintf('>>�ѱ��浽��%s\n',file);
            case 3
                print(new_f_handle,'-djpg',file);
                fprintf('>>�ѱ��浽��%s\n',file);
            case 4
                print(new_f_handle,'-depsc',file);
                fprintf('>>�ѱ��浽��%s\n',file);
        end 
        msgbox('          ͼƬ�ѳɹ����棡','��ɣ�');
end


% --- Executes on button press in LRR_UI_save_point.
function LRR_UI_save_point_Callback(hObject, eventdata, handles)
% hObject    handle to LRR_UI_save_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
new_f_handle=figure('visible','off'); %�½�һ�����ɼ���figure
new_axes=copyobj(handles.axes3,new_f_handle); %axes1��GUI������Ҫ����ͼ�ߵ�Tag������copy�����ɼ���figure��
set(new_axes,'Units','normalized','Position',[0.1 0.1 0.8 0.8]);%��ͼ������
%set(new_axes,'Units','normalized','Position',[1 1 1 1]);%��ͼ������
[filename pathname fileindex]=uiputfile({'*.png';'*.bmp';'*.jpg';'*.eps';},'ͼƬ����Ϊ');
if  filename~=0%δ�㡰ȡ������ť��δ�ر�
        file=strcat(pathname,filename);
        switch fileindex %���ݲ�ͬ��ѡ�񱣴�Ϊ��ͬ������        
            case 1
                print(new_f_handle,'-dpng',file);% print(new_f_handle,'-dpng',filename);Ч��һ������ͼ���ӡ��ָ���ļ���
                fprintf('>>�ѱ��浽��%s\n',file);
            case 2
                print(new_f_handle,'-dbmp',file);
                fprintf('>>�ѱ��浽��%s\n',file);
            case 3
                print(new_f_handle,'-djpg',file);
                fprintf('>>�ѱ��浽��%s\n',file);
            case 4
                print(new_f_handle,'-depsc',file);
                fprintf('>>�ѱ��浽��%s\n',file);
        end 
        msgbox('          ͼƬ�ѳɹ����棡','��ɣ�');
end



function result_path_Callback(hObject, eventdata, handles)
% hObject    handle to result_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of result_path as text
%        str2double(get(hObject,'String')) returns contents of result_path as a double


% --- Executes during object creation, after setting all properties.
function result_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to result_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LRR_save_file_result.
function LRR_save_file_result_Callback(hObject, eventdata, handles)
% hObject    handle to LRR_save_file_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global LRR_fea;
global LRR_idx;
global class_num;
global sample_num;
result_path=get(handles.result_path,'String');
save_result(LRR_fea,LRR_idx,class_num,sample_num,result_path);
msgbox('          �ѳɹ����棡','��ɣ�');
disp('�������');
