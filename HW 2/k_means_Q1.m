load('IrisDataAnnotated.mat');

%Intialize k and t and dQ the change in coherence.  will compare t with dQ
k=3;
t=0.00001;
dq=10; old_q=10;
time=1;

%Give random initial partitioning by drawing from array A with #1-150
A=randperm(length([1:150]));
r1=randi([40 60],1); r2=randi([40 60],1);
I_1=A(1:r1);
I_2=A(r1+1:r1+r2);
I_3=A(r1+r2+1:150);

figure
subplot(4,4,time)
scatter3(X(1,I_1),X(2,I_1),X(3,I_1),'r');
hold on
scatter3(X(1,I_2),X(2,I_2),X(3,I_2),'b');
hold on
scatter3(X(1,I_3),X(2,I_3),X(3,I_3),'k');
hold off
title(['K-Means Clustering of Iris Data iteration ' num2str(time)])
xlabel('Sepal length in cm')
ylabel('sepal width in cm')
zlabel('petal length in cm')
pause(1);

dist=zeros(3,150);  

while dq>t
    time=time+1;
    %calculate each cluster's centroid
    c1=sum(X(:,I_1),2)/size(I_1,2);
    c2=sum(X(:,I_2),2)/size(I_2,2);
    c3=sum(X(:,I_3),2)/size(I_3,2);
    
    for ind=1:150
        %calculate distance of each point to each centroid
        dist(:,ind)=[ sqrt(sum((X(:,ind)-c1).^2)) sqrt(sum((X(:,ind)-c2).^2)) sqrt(sum((X(:,ind)-c3).^2))]';
    end
    [m,i]=min(dist);

    
    %assign each data point to cluster with centroid its closest to
    I_1=find(i==1);
    I_2=find(i==2);
    I_3=find(i==3);

    new_q=sum(m);
    dq=abs(new_q-old_q);
    old_q=new_q;

    subplot(4,4,time)
    scatter3(X(1,I_1),X(2,I_1),X(3,I_1),'r');
    hold on
    scatter3(X(1,I_2),X(2,I_2),X(3,I_2),'b');
    hold on
    scatter3(X(1,I_3),X(2,I_3),X(3,I_3),'k');
    hold off
    title(['K-Means Clustering of Iris Data iteration ' num2str(time)])
    xlabel('Sepal length in cm')
    ylabel('sepal width in cm')
    zlabel('petal length in cm')
    pause(1);
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
