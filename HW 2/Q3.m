load('CongressionalVote.mat');

dist=zeros(435,435);
for i=1:435
    for j=1:435
        dissim=0;
        voted=0;
        for k=1:16
            if (X(k,j)~=0) && (X(k,i)~=0);
                voted=voted+1;
                if (X(k,i)~=X(k,j))
                dissim=dissim+1;
                end
            end
        if (voted==0)
            dist(i,j)=1;
        else
            dist(i,j)=dissim/voted;
        end
        end
    end
end
k=2;
t=0.01;
dq=10000; old_q=0;
time=0;


% set 2 random intial medoids
A=randperm(length([1:435]));
m=[X(:,A(20)) X(:,A(50))];
m_ind=[A(20) A(50)];


while dq>t
    %Assign each x to nearest medoid
    %find which cluster each x is closest to

    dist_to_all_meds=[dist(:,m_ind(1)) dist(:,m_ind(2))];
    [dist_to_closest_med, cluster_num]=min(dist_to_all_meds');
    
    %update clusters
    I_1=find(cluster_num==1);
    I_2=find(cluster_num==2);

    %find best medoid for each cluster
    p= dist(I_1,I_1);
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

act_republicans=find(I==0);    num_republicans=size(act_republicans,2);
act_democrats=find(I==1);     num_democrats=size(act_democrats,2);


class=zeros(2,2);  %[republican democrat]
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
class_republican=class(find(b==1),:);
class_democrat=class(find(b==2),:);


success_dem=class_democrat(2)/num_democrats;
success_rep=class_republican(1)/num_republicans;