function [idx]=spe_clust(W,K_iter,class_num)

K=class_num;
D = diag(1./sqrt(sum(W,2)));
E = D*W*D;%��׼����������˹
[U,S,V] = svd(E);
V = U(:,1:K);
V = D*V;
idx = kmeans(V,K,'emptyaction','singleton','replicates',K_iter,'display','off');