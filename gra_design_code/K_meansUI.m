function varargout = K_meansUI(varargin)
% K_MEANSUI MATLAB code for K_meansUI.fig
%      K_MEANSUI, by itself, creates a new K_MEANSUI or raises the existing
%      singleton*.
%
%      H = K_MEANSUI returns the handle to a new K_MEANSUI or the handle to
%      the existing singleton*.
%
%      K_MEANSUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in K_MEANSUI.M with the given input arguments.
%
%      K_MEANSUI('Property','Value',...) creates a new K_MEANSUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before K_meansUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to K_meansUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help K_meansUI

% Last Modified by GUIDE v2.5 24-May-2019 16:56:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @K_meansUI_OpeningFcn, ...
                   'gui_OutputFcn',  @K_meansUI_OutputFcn, ...
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


% --- Executes just before K_meansUI is made visible.
function K_meansUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to K_meansUI (see VARARGIN)

% Choose default command line output for K_meansUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes K_meansUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = K_meansUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in K_means_UI_run.
function K_means_UI_run_Callback(hObject, eventdata, handles)
% hObject    handle to K_means_UI_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global K_means_result ;

addpath('public_code');
disp('��ʼ...');
global class_num;
global sample_num;
K_means_sample_num=int32(str2double(sample_num));
K_means_class_num=int32(str2double(class_num));%������������

disp('�������ݼ�...');
global data_path;

%disp(K_means_sample_num)
[fea]=get_data2(data_path,K_means_sample_num);%����ÿһ����һ��ͼ
global K_means_fea;
K_means_fea=fea;

disp('���ݹ�һ��...');
X=data2one(fea);%��һ����ÿһ����һ��ͼ
X=X';

K_iter=int32(str2double(get(handles.K_means_UI_iter,'String')));%K_means��������


idx = kmeans(X,K_means_class_num,'emptyaction','singleton','replicates',K_iter,'display','off');
global K_means_idx;
K_means_idx=idx;
%idx=spe_clust(X,K_iter,K_means_class_num);

disp('����ɢ��ͼ...');
[COEFF,SCORE,latent] = pca(X);
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
    gnd=data.gnd(1:K_means_sample_num);

    K_means_result = ClusteringMeasure(gnd,idx);%ָ��
    set(handles.K_means_UI_ACC,'String',num2str(K_means_result(1,1)));
    set(handles.K_means_UI_NMI,'String',num2str(K_means_result(1,2)));
    set(handles.K_means_UI_purity,'String',num2str(K_means_result(1,3)));
    disp('����ָ�����');
end

disp('�������');

% --- Executes on button press in K_means_save_point.
function K_means_save_point_Callback(hObject, eventdata, handles)
% hObject    handle to K_means_save_point (see GCBO)
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


function K_means_UI_ACC_Callback(hObject, eventdata, handles)
% hObject    handle to K_means_UI_ACC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of K_means_UI_ACC as text
%        str2double(get(hObject,'String')) returns contents of K_means_UI_ACC as a double


% --- Executes during object creation, after setting all properties.
function K_means_UI_ACC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to K_means_UI_ACC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function K_means_UI_NMI_Callback(hObject, eventdata, handles)
% hObject    handle to K_means_UI_NMI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of K_means_UI_NMI as text
%        str2double(get(hObject,'String')) returns contents of K_means_UI_NMI as a double


% --- Executes during object creation, after setting all properties.
function K_means_UI_NMI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to K_means_UI_NMI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function K_means_UI_purity_Callback(hObject, eventdata, handles)
% hObject    handle to K_means_UI_purity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of K_means_UI_purity as text
%        str2double(get(hObject,'String')) returns contents of K_means_UI_purity as a double


% --- Executes during object creation, after setting all properties.
function K_means_UI_purity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to K_means_UI_purity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function K_means_UI_iter_Callback(hObject, eventdata, handles)
% hObject    handle to K_means_UI_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of K_means_UI_iter as text
%        str2double(get(hObject,'String')) returns contents of K_means_UI_iter as a double


% --- Executes during object creation, after setting all properties.
function K_means_UI_iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to K_means_UI_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in K_means_get_label.
function K_means_get_label_Callback(hObject, eventdata, handles)
% hObject    handle to K_means_get_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)






% --- Executes on button press in K_means_compute.
function K_means_compute_Callback(hObject, eventdata, handles)
% hObject    handle to K_means_compute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





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


% --- Executes on button press in K_means_result_path.
function K_means_result_path_Callback(hObject, eventdata, handles)
% hObject    handle to K_means_result_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder_name = uigetdir;
set(handles.result_path,'String',folder_name);



% --- Executes on button press in K_means_save_file_result.
function K_means_save_file_result_Callback(hObject, eventdata, handles)
% hObject    handle to K_means_save_file_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global K_means_fea;
global K_means_idx;
global class_num;
global sample_num;
result_path=get(handles.result_path,'String');
save_result(K_means_fea,K_means_idx,class_num,sample_num,result_path);
msgbox('          �ѳɹ����棡','ȷ����');
disp('���');
