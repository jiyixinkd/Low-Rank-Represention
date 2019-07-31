function save_result(fea,idx,class,sample,path)

K=int32(str2double(class));
sum=int32(str2double(sample));

for i = 1:K
     mkdir(strcat(path,'\',int2str(i),'\'));       %% ��ָ�����ļ�·�����Ա�����Ϊ���ִ����µ��ļ���
end

for i=1:sum
    temp=fea(i,:);
    temp=reshape(temp,32,32);
    temp= uint8(temp);
   
    img_path_list = dir(strcat(path,'\',int2str(idx(i)),'\','*.tif'));%��ȡ���ļ���������jpg��ʽ��ͼ��
    img_num = length(img_path_list);%��ȡͼ��������
   
    imwrite(temp,strcat(path,'\',int2str(idx(i)),'\',num2str(img_num+1),'.tif'));
end