load('TDM_vary_k.mat');
X=X{3};
k=6;
t=0.001;

[I, m_ind]=k_medoids(X, k, t);

cos=zeros(763,6);
for i=1:6
    for j=1:763
        num=X(:,j)'*X(:,m_ind(i));
        denom=norm(X(:,j), 2)*norm(X(:,m_ind(i)),2);
        cos(j,i)=num/denom;
    end
end


figure(1)
for i=1:6
    subplot(2,3,i);
    ind=[1:6];
    ind=ind(ind~=i);
    plot(I{i},cos(I{i}, i),'r.','MarkerSize',20);
    hold on
    plot(I{ind(1)}, cos(I{ind(1)},i), 'k.', 'MarkerSize', 20);
    hold on
    plot(I{ind(2)}, cos(I{ind(2)},i), 'k.', 'MarkerSize', 20);
    hold on
    plot(I{ind(3)}, cos(I{ind(3)},i), 'k.', 'MarkerSize', 20);
    hold on
    plot(I{ind(4)}, cos(I{ind(4)},i), 'k.', 'MarkerSize', 20);
    hold on
    plot(I{ind(5)}, cos(I{ind(5)},i), 'k.', 'MarkerSize', 20);
    hold off
    xlabel('Data vector')
    ylabel('Cosine')
    title(['Cosine of angle between medoid '  num2str(i)  ' and data vectors'])
    legend(['Cluster ' num2str(i)], ['Clusters ' num2str(ind)])
end
