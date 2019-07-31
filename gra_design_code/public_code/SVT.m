function X = SVT(W,epsilon)
%    \min \epsilon||X||_* + 1/2 ||X-W||_F^2
%
[U,S,V] = svd(W,'econ');%�����Խ���Ԫ��
s = max(diag(S)-epsilon, 0) + min(diag(S)+epsilon,0);%��������
X = U*diag(s)*V';