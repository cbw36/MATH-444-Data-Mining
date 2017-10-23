function [V,D] = LDA(X,I, m)

[n,p]=size(X);

num_clusters=size(unique(I),2);
cluster_vals=unique(I);

I_c = cell(num_clusters,2);

for i = 1:num_clusters
    I_cur = find(I==i);   
    I_c{i,1} = I_cur;     
    I_c{i,2}=size(I_cur,2);
end

%define annotation vectors
%calculate global centroid and cluster centroids store in c.  col 1=1st,
%2=2nd, 3=3rd, 4=global
c=zeros(n,num_clusters+1);
c(:,num_clusters+1)=(1/p) * sum(X,2);
for i=1:num_clusters
  c(:,i)=(1/I_c{i,2}) * sum(X(:,I==i),2);
end

%center X by its clusters.  Within cluster centered data matrix
X_w=zeros(n,p);
for i=1:num_clusters
    X_w(:,I==(i))=X(:,I==(i))-c(:,i);
end

%Find within cluster scatter matrix Sw
sw=X_w(:,:)*X_w(:,:)';

%Find between cluster scatter matrix
sb=zeros(n,n);
for i=1:num_clusters
    sb=sb+I_c{i,2}*(c(:,i)-c(:,num_clusters+1))*(c(:,i)-c(:,num_clusters+1))';
end

%calculate eigenvalues and eigenvectors
epsilon=10^-12;
sw=sw+(epsilon*eye(n));
[V,D]=eigs(sw\sb,m);
V=real(V);  D=real(D);


% figure(1)
% colors=['r','g', 'b', 'k'];
% for i=1:num_clusters
%     Z=V'*X(:,I==(i));
%     scatter(Z(1,:),Z(2,:),colors(i));
%     xlabel('LDA direction 1');
%     ylabel('LDA direction 2');
%     title('Plot of LDA direction 1 vs 2 Wine Data Set ');
%     hold on
% end
