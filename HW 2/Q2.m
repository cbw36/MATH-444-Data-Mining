load('BiopsyDataAnnotated.mat');
k=2;
t=0.0000001;
dq=10; old_q=0;
time=0;

%define a matrix of euclidean distance between each point
dist=zeros(683,683);
for i=1:683
    for j=1:683
        dist(i,j)= sum(abs(X(:,i)-X(:,j)));
    end
end

% set 3 random intial medoids
A=randperm(length([1:683]));
m=[X(:,A(60)) X(:,A(90))];
m_ind=[A(60) A(90)];


while dq>t
    %Assign each x to nearest medoid
    %find which cluster each x is closest to
    dist_to_all_meds=[dist(:,m_ind(1)) dist(:,m_ind(2))];
    [dist_to_closest_med, cluster_num]=min(dist_to_all_meds');
    
    %update clusters
    I_1=find(cluster_num==1);
    I_2=find(cluster_num==2);

    %find best medoid for each cluster
    c1=sum(dist(I_1,I_1));
    [q1,i1]=min(c1);
    m(:,1)=X(:,I_1(i1));
    m_ind(1)=I_1(i1);

    c2=sum(dist(I_2,I_2));
    [q2,i2]=min(c2);
    m(:,2)=X(:,I_2(i2));
    m_ind(2)=I_2(i2);
    
    new_q=q1+q2;
    dq=abs(new_q-old_q);
    old_q=new_q;
    time=time+1;
end


class=zeros(2,2);  %[benign malignant]
for i=1:size(I_1,2)
    if I(I_1(i))==0
        class(1,1)=class(1,1)+1;
    else
        class(1,2)=class(1,2)+1;
    end
end

for i=1:size(I_2,2)
    if I(I_2(i))==0
        class(2,1)=class(2,1)+1;
    else
        class(2,2)=class(2,2)+1;
    end
end

[a,b]=max(class')
class_benign=class(find(b==1),:);
class_malignant=class(find(b==2),:);

act_malignant=find(I==1); num_malignant=size(act_malignant,2);
act_benign=find(I==0);    num_benign=size(act_benign,2);

sensitivity=class_malignant(2)/num_malignant;
specificity=class_benign(1)/num_benign;