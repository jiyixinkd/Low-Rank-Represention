function [fea] = get_data2(file_path,selected_num)%���صľ���ÿ��һ��ͼ
disp(file_path)
file_path=strcat(file_path,'\');
img_num=selected_num;
dd=[];
for j = 1:img_num %��һ��ȡͼ��
      image =  imread([file_path,int2str(j),'.tif']);
      image=imresize(image,[32,32]);
      one_dimo=image(:)';%������ת��Ϊһά����
      dd=[dd;one_dimo];%�����һά�����ϲ��ɸ�ά����
end
fea=dd;


