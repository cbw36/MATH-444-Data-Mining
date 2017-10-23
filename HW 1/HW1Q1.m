load ModelReductionData;
counter=1;
figure(1)
for i=1:5
    for j=i+1:6
        subplot(5,3,counter)
        plot(X(i,:),X(j,:), 'k.', 'MarkerSize',7);
        axis('equal');
        set(gca,'FontSize',20);
        counter=counter+1;
        title(['plot of dimension  ' num2str(i) ' vs dimension ' num2str(j)])
        xlabel(['dim ' num2str(i)]);
        ylabel(['dim ' num2str(j)]);
        
    end
end

[n,p]=size(X);
x_c = (1/p)*sum(X(:,:),2);
X_c = X - x_c*ones(1,p);

[U,D,V]=svd(X_c, 'econ');

d = diag(D);
figure(2);
semilogy(d,'k.','MarkerSize',20);
set(gca,'FontSize',20);
xlabel('Dimension Number');
ylabel('Singular Value');
title('Singular Values of X')

Z=U(:,1:3)'*X;


figure(3);
subplot(2,3,1)
plot(Z(1,1:4000),Z(2,1:4000),'r.','MarkerSize',20);
xlabel('Principal Component 1')
ylabel('Principal Component 2')
title('Principal Component 1 vs 2')

subplot(2,3,2)
plot(Z(1,1:4000),Z(3,1:4000),'r.','MarkerSize',20);
xlabel('Principal Component 1')
ylabel('Principal Component 3')
title('Principal Component 1 vs 3')

subplot(2,3,3)
plot(Z(2,1:4000),Z(3,1:4000),'r.','MarkerSize',20);
xlabel('Principal Component 2')
ylabel('Principal Component 3')
title('Principal Component 2 vs 3')

subplot(2,3,4)
plot(Z(2,1:4000),Z(1,1:4000),'r.','MarkerSize',20);
xlabel('Principal Component 2')
ylabel('Principal Component 1')
title('Principal Component 2 vs 1')

subplot(2,3,5)
plot(Z(3,1:4000),Z(1,1:4000),'r.','MarkerSize',20);
xlabel('Principal Component 3')
ylabel('Principal Component 1')
title('Principal Component 3 vs 1')

subplot(2,3,6)
plot(Z(3,1:4000),Z(2,1:4000),'r.','MarkerSize',20);
xlabel('Principal Component 3')
ylabel('Principal Component 2')
title('Principal Component 3 vs 2')