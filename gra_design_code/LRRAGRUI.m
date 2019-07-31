function varargout = LRRAGRUI(varargin)
% LRRAGRUI MATLAB code for LRRAGRUI.fig
%      LRRAGRUI, by itself, creates a new LRRAGRUI or raises the existing
%      singleton*.
%
%      H = LRRAGRUI returns the handle to a new LRRAGRUI or the handle to
%      the existing singleton*.
%
%      LRRAGRUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LRRAGRUI.M with the given input arguments.
%
%      LRRAGRUI('Property','Value',...) creates a new LRRAGRUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LRRAGRUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LRRAGRUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LRRAGRUI

% Last Modified by GUIDE v2.5 24-May-2019 18:00:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LRRAGRUI_OpeningFcn, ...
                   'gui_OutputFcn',  @LRRAGRUI_OutputFcn, ...
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


% --- Executes just before LRRAGRUI is made visible.
function LRRAGRUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LRRAGRUI (see VARARGIN)

% Choose default command line output for LRRAGRUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LRRAGRUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LRRAGRUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LRRAGR_UI_run.
function LRRAGR_UI_run_Callback(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global LRRAGR_result;
addpath('LRRAGR_code');
addpath('public_code');
disp('��ʼ...');
global class_num;
global sample_num;
LRRAGR_class_num=int32(str2double(class_num));%������������
LRRAGR_sample_num=int32(str2double(sample_num));

disp('�������ݼ�...');
global data_path;
[fea]=get_data2(data_path,LRRAGR_sample_num);
global LRRAGR_fea;
LRRAGR_fea=fea;

disp('���ݹ�һ��...');
X=data2one(fea);%��һ��

lambda1=str2double(get(handles.LRRAGR_UI_lambda1,'String'));%lambda1ֵ
lambda2=str2double(get(handles.LRRAGR_UI_lambda2,'String'));%lambda2ֵ
lambda3=str2double(get(handles.LRRAGR_UI_lambda3,'String'));%lambda3ֵ

[F_ini,Z_ini]=get_F_Z_init(X,LRRAGR_class_num);

disp('��ȡ���ȱ�ʾ...');
[Z,S,U,F,E] = LRRAGR_main(X,F_ini,Z_ini,LRRAGR_class_num,lambda1,lambda2,lambda3);

disp('�����׺;���...');
axes(handles.LRRAGR_UI_rep);%ʹ��ͼ�񣬲���������2
L=get_affinity(Z,LRRAGR_class_num);
imshow(L);

K_iter=int32(str2double(get(handles.LRRAGR_UI_kmeans_iter,'String')));%K_means��������

disp('ִ���׾���...');
idx=spe_clust(L,K_iter,LRRAGR_class_num);%�׾���

global LRRAGR_idx;
LRRAGR_idx=idx;

disp('����ɢ��ͼ...');
axes(handles.axes3);
[COEFF,SCORE,latent] = pca(Z);
SCORE = SCORE(:,1:30);
mappedX = tsne(SCORE,'Algorithm','exact','NumDimensions',2);
[sum,~]=size(idx);
c=zeros(sum,1);
for i = 1 :sum
    c(i) = idx(i);
end
axes(handles.axes3);%ʹ��ͼ�񣬲���������2
scatter(mappedX(:,1),mappedX(:,2),5,c,'*');


disp('����ָ��...');
global labal_path;

if (isempty(labal_path))
     msgbox('δѡ��ר�ұ�ǩ','ȷ��');
     disp('����ָ��ʧ��');
else
    data=load(labal_path);
    gnd=data.gnd(1:LRRAGR_sample_num);

    LRRAGR_result = ClusteringMeasure(gnd,idx)%ָ��
    set(handles.LRRAGR_UI_ACC,'String',num2str(LRRAGR_result(1,1)));
    set(handles.LRRAGR_UI_NMI,'String',num2str(LRRAGR_result(1,2)));
    set(handles.LRRAGR_UI_purity,'String',num2str(LRRAGR_result(1,3)));
end
disp('�������');









function LRRAGR_UI_ACC_Callback(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_ACC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRRAGR_UI_ACC as text
%        str2double(get(hObject,'String')) returns contents of LRRAGR_UI_ACC as a double


% --- Executes during object creation, after setting all properties.
function LRRAGR_UI_ACC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_ACC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LRRAGR_UI_NMI_Callback(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_NMI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRRAGR_UI_NMI as text
%        str2double(get(hObject,'String')) returns contents of LRRAGR_UI_NMI as a double


% --- Executes during object creation, after setting all properties.
function LRRAGR_UI_NMI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_NMI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LRRAGR_UI_purity_Callback(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_purity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRRAGR_UI_purity as text
%        str2double(get(hObject,'String')) returns contents of LRRAGR_UI_purity as a double


% --- Executes during object creation, after setting all properties.
function LRRAGR_UI_purity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_purity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LRRAGR_UI_lambda1_Callback(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_lambda1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRRAGR_UI_lambda1 as text
%        str2double(get(hObject,'String')) returns contents of LRRAGR_UI_lambda1 as a double


% --- Executes during object creation, after setting all properties.
function LRRAGR_UI_lambda1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_lambda1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LRRAGR_UI_kmeans_iter_Callback(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_kmeans_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRRAGR_UI_kmeans_iter as text
%        str2double(get(hObject,'String')) returns contents of LRRAGR_UI_kmeans_iter as a double


% --- Executes during object creation, after setting all properties.
function LRRAGR_UI_kmeans_iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_kmeans_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LRRAGR_UI_lambda3_Callback(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_lambda3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRRAGR_UI_lambda3 as text
%        str2double(get(hObject,'String')) returns contents of LRRAGR_UI_lambda3 as a double


% --- Executes during object creation, after setting all properties.
function LRRAGR_UI_lambda3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_lambda3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LRRAGR_UI_lambda2_Callback(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_lambda2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LRRAGR_UI_lambda2 as text
%        str2double(get(hObject,'String')) returns contents of LRRAGR_UI_lambda2 as a double


% --- Executes during object creation, after setting all properties.
function LRRAGR_UI_lambda2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_lambda2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LRRAGR_UI_save_rep.
function LRRAGR_UI_save_rep_Callback(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_save_rep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
new_f_handle=figure('visible','off'); %�½�һ�����ɼ���figure
new_axes=copyobj(handles.LRRAGR_UI_rep,new_f_handle); %axes1��GUI������Ҫ����ͼ�ߵ�Tag������copy�����ɼ���figure��
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


% --- Executes on button press in LRRAGR_UI_save_point.
function LRRAGR_UI_save_point_Callback(hObject, eventdata, handles)
% hObject    handle to LRRAGR_UI_save_point (see GCBO)
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


% --- Executes on button press in LRRAGR_select_path.
function LRRAGR_select_path_Callback(hObject, eventdata, handles)
% hObject    handle to LRRAGR_select_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder_name = uigetdir;
set(handles.result_path,'String',folder_name);

% --- Executes on button press in LRRAGR_save_file_result.
function LRRAGR_save_file_result_Callback(hObject, eventdata, handles)
% hObject    handle to LRRAGR_save_file_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global LRRAGR_fea;
global LRRAGR_idx;
global class_num;
global sample_num;
result_path=get(handles.result_path,'String');
save_result(LRRAGR_fea,LRRAGR_idx,class_num,sample_num,result_path);
msgbox('          �ѳɹ����棡','��ɣ�');
disp('�������');