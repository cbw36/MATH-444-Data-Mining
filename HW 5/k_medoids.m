function [I,m_ind] = k_medoids(X, k, t)
%%
[n,p]=size(X);

K=1:k;
dq=10; old_q=0;
time=1;


I=cell(1,k);
c=cell(1,k);
m_ind=zeros(1,k);
m_vals=zeros(n,k);
q_vals=zeros(1,k);

%define a matrix of l1 distance between each point
dist=zeros(p,p);
for i=1:p
    for j=1:p
        dist(i,j)= sum(abs(X(:,i)-X(:,j)));
    end
end

% set k random intial medoids
A=randperm(length([1:p]));
for i=1:k
    m_ind(i)=A(i);
    m_vals(:,i)=X(:,A(i));
end

%%
while dq>t
    %Assign each x to nearest medoid
    %find which cluster each x is closest to
    dist_to_all_meds=zeros(p,k);
    for i=1:k
        dist_to_all_meds(:,i)=dist(:,m_ind(i));
        [dist_to_closest_med, cluster_num]=min(dist_to_all_meds');
    end
    %update clusters
    for i=1:k
        I{i}=find(cluster_num==i);
    end


    %find best medoid for each cluster
    for i=1:k
        c{i}=sum(dist(I{i},I{i}));
        [q,ind]=min(c{i});
        q_vals(i)=q;
        m_vals(:,i)=X(:,I{i}(ind));
        m_ind(i)=I{i}(ind);
    end

    new_q=sum(q_vals);
    dq=abs(new_q-old_q);
    old_q=new_q;
    time=time+1;
end