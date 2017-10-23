load('TDM_vary_k.mat');

X=X{3};
k=6;

[W, H]=ANLS(X,k);

Z_w=PCA(W);
Z_x=PCA(X);


%% JUST POINTS
figure(3)
plot(Z_x(1,:),Z_x(2,:),'r.','MarkerSize',20);
hold on
plot(Z_w(1,:),Z_w(2,:),'k.', 'MarkerSize', 30);
hold off
xlabel('Principal Component 1')
ylabel('Principal Component 2')
title('PCA of NMF superimposed over PCA of TDM')

%% VORONII METHOD
figure(2)
voronoi(Z_w(1,:),Z_w(2,:));
hold on
plot(Z_x(1,:),Z_x(2,:),'r.','MarkerSize',20);
hold on
plot(Z_w(1,:),Z_w(2,:),'k.', 'MarkerSize', 30);
hold off
xlabel('Principal Component 1')
ylabel('Principal Component 2')
title('PCA of NMF superimposed over PCA of TDM: Voronoi method')

%% LINE METHOD
figure(1)
plot(Z_x(1,:),Z_x(2,:),'r.','MarkerSize',20);
hold on
plot(Z_w(1,:),Z_w(2,:),'k.','MarkerSize',20);
hold on
plot([0,10*Z_w(1,1)], [0,10*Z_w(2,1)], 'b');
hold on
plot([0,10*Z_w(1,2)], [0,10*Z_w(2,2)], 'b');
hold on
plot([0,10*Z_w(1,3)], [0,10*Z_w(2,3)], 'b');
hold on
plot([0,10*Z_w(1,4)], [0,10*Z_w(2,4)], 'b');
hold on
plot([0,100*Z_w(1,5)], [0,100*Z_w(2,5)], 'b');
hold on
plot([0,10*Z_w(1,6)], [0,10*Z_w(2,6)], 'b');
hold off
xlabel('Principal Component 1')
ylabel('Principal Component 2')
title('PCA of NMF superimposed over PCA of TDM: Vector method')