function varargout = LatLRRUI(varargin)
% LATLRRUI MATLAB code for LatLRRUI.fig
%      LATLRRUI, by itself, creates a new LATLRRUI or raises the existing
%      singleton*.
%
%      H = LATLRRUI returns the handle to a new LATLRRUI or the handle to
%      the existing singleton*.
%
%      LATLRRUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LATLRRUI.M with the given input arguments.
%
%      LATLRRUI('Property','Value',...) creates a new LATLRRUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LatLRRUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LatLRRUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LatLRRUI

% Last Modified by GUIDE v2.5 24-May-2019 17:33:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LatLRRUI_OpeningFcn, ...
                   'gui_OutputFcn',  @LatLRRUI_OutputFcn, ...
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


% --- Executes just before LatLRRUI is made visible.
function LatLRRUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LatLRRUI (see VARARGIN)

% Choose default command line output for LatLRRUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LatLRRUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LatLRRUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LatLRR_UI_run.
function LatLRR_UI_run_Callback(hObject, eventdata, handles)
% hObject    handle to LatLRR_UI_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global LatLRR_result;
addpath('LatLRR_code');
addpath('public_code');
disp('��ʼ...');
global class_num;
global sample_num;
LatLRR_class_num=int32(str2double(class_num));%������������
LatLRR_sample_num=int32(str2double(sample_num));

disp('�������ݼ�...');
global data_path;
[fea]=get_data2(data_path,LatLRR_sample_num);
global LatLRR_fea;
LatLRR_fea=fea;

disp('���ݹ�һ��...');
X=data2one(fea);%��һ��

lambda=str2double(get(handles.LatLRR_UI_lambda,'String'));%lambdaֵ

%disp(lambda)
if (get(handles.LatLRR_UI_self_dic,'value'))%�Ƿ������ֵ�
    self_dic=1;
else
    self_dic=0;
end

if (get(handles.LatLRR_UI_L1_norm,'value'))%����
    norm=1;
else
    norm=21;
end

disp('��ȡ���ȱ�ʾ...');
[Z,L,E]=LatLRR_main(X,lambda,self_dic,norm);%LatLRR

disp('�����׺;���...');
axes(handles.LatLRR_UI_rep);%ʹ��ͼ�񣬲���������2
L=get_affinity(Z,LatLRR_class_num);
imshow(L);
         % imshow(imadjust(Z,[0 0.1],[0 1]));%������axes2��ʾԭͼ��
          
disp('ִ���׾���...');         
K_iter=int32(str2double(get(handles.LatLRR_UI_kmeans_iter,'String')));%K_means��������
idx=spe_clust(L,K_iter,LatLRR_class_num);%�׾���
global LatLRR_idx;
LatLRR_idx=idx;

disp('����ɢ��ͼ...');
axes(handles.axes3);
[COEFF,SCORE,latent] = pca(Z);
SCORE = SCORE(:,1:30);
mappedX = tsne(SCORE,'Algorithm','exact','NumDimensions',2);

axes(handles.axes3);%ʹ��ͼ�񣬲���������2
scatter(mappedX(:,1),mappedX(:,2),5,idx,'*');

disp('����ָ��...');
global labal_path;

if (isempty(labal_path))
     msgbox('δѡ��ר�ұ�ǩ','ȷ��');
     disp('����ָ��ʧ��');
else
    data=load(labal_path);
    gnd=data.gnd(1:LatLRR_sample_num);

    LatLRR_result = ClusteringMeasure(gnd,idx)%ָ��
    set(handles.LatLRR_UI_ACC,'String',num2str(LatLRR_result(1,1)));
    set(handles.LatLRR_UI_NMI,'String',num2str(LatLRR_result(1,2)));
    set(handles.LatLRR_UI_purity,'String',num2str(LatLRR_result(1,3)));
end
disp('�������');

function LatLRR_UI_ACC_Callback(hObject, eventdata, handles)
% hObject    handle to LatLRR_UI_ACC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LatLRR_UI_ACC as text
%        str2double(get(hObject,'String')) returns contents of LatLRR_UI_ACC as a double


% --- Executes during object creation, after setting all properties.
function LatLRR_UI_ACC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LatLRR_UI_ACC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LatLRR_UI_NMI_Callback(hObject, eventdata, handles)
% hObject    handle to LatLRR_UI_NMI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LatLRR_UI_NMI as text
%        str2double(get(hObject,'String')) returns contents of LatLRR_UI_NMI as a double


% --- Executes during object creation, after setting all properties.
function LatLRR_UI_NMI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LatLRR_UI_NMI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LatLRR_UI_purity_Callback(hObject, eventdata, handles)
% hObject    handle to LatLRR_UI_purity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LatLRR_UI_purity as text
%        str2double(get(hObject,'String')) returns contents of LatLRR_UI_purity as a double


% --- Executes during object creation, after setting all properties.
function LatLRR_UI_purity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LatLRR_UI_purity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LatLRR_UI_kmeans_iter_Callback(hObject, eventdata, handles)
% hObject    handle to LatLRR_UI_kmeans_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LatLRR_UI_kmeans_iter as text
%        str2double(get(hObject,'String')) returns contents of LatLRR_UI_kmeans_iter as a double


% --- Executes during object creation, after setting all properties.
function LatLRR_UI_kmeans_iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LatLRR_UI_kmeans_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LatLRR_UI_lambda_Callback(hObject, eventdata, handles)
% hObject    handle to LatLRR_UI_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LatLRR_UI_lambda as text
%        str2double(get(hObject,'String')) returns contents of LatLRR_UI_lambda as a double


% --- Executes during object creation, after setting all properties.
function LatLRR_UI_lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LatLRR_UI_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LatLRR_UI_save_rep.
function LatLRR_UI_save_rep_Callback(hObject, eventdata, handles)
% hObject    handle to LatLRR_UI_save_rep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
new_f_handle=figure('visible','off'); %�½�һ�����ɼ���figure
new_axes=copyobj(handles.LatLRR_UI_rep,new_f_handle); %axes1��GUI������Ҫ����ͼ�ߵ�Tag������copy�����ɼ���figure��
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


% --- Executes on button press in LatLRR_UI_save_point.
function LatLRR_UI_save_point_Callback(hObject, eventdata, handles)
% hObject    handle to LatLRR_UI_save_point (see GCBO)
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


% --- Executes on button press in LatLRR_select_path.
function LatLRR_select_path_Callback(hObject, eventdata, handles)
% hObject    handle to LatLRR_select_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder_name = uigetdir;
set(handles.result_path,'String',folder_name);

% --- Executes on button press in LatLRR_save_file_result.
function LatLRR_save_file_result_Callback(hObject, eventdata, handles)
% hObject    handle to LatLRR_save_file_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global LatLRR_fea;
global LatLRR_idx;
global class_num;
global sample_num;
result_path=get(handles.result_path,'String');
save_result(LatLRR_fea,LatLRR_idx,class_num,sample_num,result_path);
msgbox('          �ѳɹ����棡','��ɣ�');
disp('�������');
