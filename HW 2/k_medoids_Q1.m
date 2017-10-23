load('IrisDataAnnotated.mat');

% Intialize k and t and dQ the change in coherence.  will compare t with dQ
k=3;
t=0.00000001;
dq=10; old_q=0;
time=1;
%define a matrix of l1 distance between each point
dist=zeros(150,150);
for i=1:150
    for j=1:150
        dist(i,j)= sum(abs(X(:,i)-X(:,j)));
    end
end

% set 3 random intial medoids
A=randperm(length([1:150]));
m=[X(:,A(1)) X(:,A(2)) X(:,A(3))];
m_ind=[ A(1) A(2) A(3)];

while dq>t
    %Assign each x to nearest medoid
    %find which cluster each x is closest to
    dist_to_all_meds=[dist(:,m_ind(1)) dist(:,m_ind(2)) dist(:,m_ind(3))];
    [dist_to_closest_med, cluster_num]=min(dist_to_all_meds');
    
    %update clusters
    I_1=find(cluster_num==1);
    I_2=find(cluster_num==2);
    I_3=find(cluster_num==3);
    
    figure(1)
    subplot(4,2,time)
    scatter3(X(1,I_1),X(2,I_1),X(3,I_1),'r');
    hold on
    scatter3(X(1,I_2),X(2,I_2),X(3,I_2),'b');
    hold on
    scatter3(X(1,I_3),X(2,I_3),X(3,I_3),'k');
    hold off
    title(['K-Medoids Clustering of Iris Data iteration ' num2str(time)])
    xlabel('Sepal length in cm')
    ylabel('sepal width in cm')
    zlabel('petal length in cm')
    pause(1);
   

    %find best medoid for each cluster
    c1=sum(dist(I_1,I_1));
    [q1,i1]=min(c1);
    m(:,1)=X(:,I_1(i1));
    m_ind(1)=I_1(i1);

    c2=sum(dist(I_2,I_2));
    [q2,i2]=min(c2);
    m(:,2)=X(:,I_2(i2));
    m_ind(2)=I_2(i2);

    c3=sum(dist(I_3,I_3));
    [q3,i3]=min(c3);
    m(:,3)=X(:,I_3(i3));
    m_ind(3)=I_3(i3);
    
    new_q=q1+q2+q3;
    dq=abs(new_q-old_q);
    old_q=new_q;
    time=time+1;
end


class=zeros(3,3);
for i=1:size(I_1,2)
    if I(I_1(i))==1
        class(1,1)=class(1,1)+1;
    elseif I(I_1(i))==2
        class(1,2)=class(1,2)+1;
    else
        class(1,3)=class(1,3)+1;
    end
end

for i=1:size(I_2,2)
    if I(I_2(i))==1
        class(2,1)=class(2,1)+1;
    elseif I(I_2(i))==2
        class(2,2)=class(2,2)+1;
    else
        class(2,3)=class(2,3)+1;
    end
end

for i=1:size(I_3,2)
    if I(I_3(i))==1
        class(3,1)=class(3,1)+1;
    elseif I(I_3(i))==2
        class(3,2)=class(3,2)+1;
    else
        class(3,3)=class(3,3)+1;
    end
end


[a,b]=max(class')
setosa=class(find(b==1),:);
versacolor=class(find(b==2),:);
virginica=class(find(b==3),:);


figure(2)
scatter3(X(1,find(I==1)),X(2,find(I==1)),X(3,find(I==1)),'r');
hold on
scatter3(X(1,find(I==2)),X(2,find(I==2)),X(3,find(I==2)),'b');
hold on
scatter3(X(1,find(I==3)),X(2,find(I==3)),X(3,find(I==3)),'k');
hold off
pause(1);