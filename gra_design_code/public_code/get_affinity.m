function [W]=get_affinity(Z,class_num)
K=class_num;
[U,S,V] = svd(Z,'econ');
S = diag(S);                                                                                                     
   
r = sum(S>1e-4*S(1));%S(1�����ؾ���S��������
U = U(:,1:r);
S = S(1:r);
U = U*diag(sqrt(S));
U = normr(U);%��׼��U����
W = (U*U').^4;%�׺;���
