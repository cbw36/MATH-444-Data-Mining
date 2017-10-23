load('TDM_vary_k.mat')
A=X;

for i = 1:6
    figure(1)
    subplot(2,3,i)
    Z=PCA(A{i});
    plot(Z(1,:),Z(2,:),'r.','MarkerSize',20);
    xlabel('Principal Component 1')
    ylabel('Principal Component 2')
    title(['Principal Component 1 vs 2 for k = ' num2str(i) ])
end
