function [X]=data2one(data)
%��һ������
    fea = double(data);
    fea = fea';
    fea = fea./repmat(sqrt(sum(fea.^2)),[size(fea,1) 1]);%ÿһ�У�l2������һ����
    X = fea;
end
