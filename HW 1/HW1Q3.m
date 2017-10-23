load IrisData;

[n,p]=size(X);
x_c = (1/p)*sum(X(:,:),2);
X_c = X - x_c*ones(1,p);
[U,D,V]=svd(X,'econ');
Z=U(:,1:3)'*X;

figure(1);
subplot(2,3,1)
plot(Z(1,:),Z(2,:),'r.','MarkerSize',20);
xlabel('Principal Component 1')
ylabel('Principal Component 2')
title('Principal Component 1 vs 2')

subplot(2,3,2)
plot(Z(1,:),Z(3,:),'r.','MarkerSize',20);
xlabel('Principal Component 1')
ylabel('Principal Component 3')
title('Principal Component 1 vs 3')

subplot(2,3,3)
plot(Z(2,:),Z(3,:),'r.','MarkerSize',20);
xlabel('Principal Component 2')
ylabel('Principal Component 3')
title('Principal Component 2 vs 3')

subplot(2,3,4)
plot(Z(2,:),Z(1,:),'r.','MarkerSize',20);
xlabel('Principal Component 2')
ylabel('Principal Component 1')
title('Principal Component 2 vs 1')

subplot(2,3,5)
plot(Z(3,:),Z(1,:),'r.','MarkerSize',20);
xlabel('Principal Component 3')
ylabel('Principal Component 1')
title('Principal Component 3 vs 1')

subplot(2,3,6)
plot(Z(3,:),Z(2,:),'r.','MarkerSize',20);
xlabel('Principal Component 3')
ylabel('Principal Component 2')
title('Principal Component 3 vs 2')