%%
load('TDM_vary_k.mat');
X=X{3};
k=6;
t=0.001;

I=k_medoids(X, k, t);

Z=PCA(X);

%%

figure(2);
plot(Z(1,I{1}),Z(2,I{1}),'r.','MarkerSize',20);
hold on
plot(Z(1,I{2}),Z(2,I{2}),'b.','MarkerSize',20);
hold on
plot(Z(1,I{3}),Z(2,I{3}),'g.','MarkerSize',20);
hold on
plot(Z(1,I{4}),Z(2,I{4}),'k.','MarkerSize',20);
hold on
plot(Z(1,I{5}),Z(2,I{5}),'y.','MarkerSize',20);
hold on
plot(Z(1,I{6}),Z(2,I{6}),'m.','MarkerSize',20);
% hold on
% plot(Z(1,I{7}),Z(2,I{7}),'c.','MarkerSize',20);
hold off
xlabel('Principal Component 1')
ylabel('Principal Component 2')
title('Principal Component 1 vs 2 for 6 clusters')
