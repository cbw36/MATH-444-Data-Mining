load('TDM_vary_L.mat')
A=X;
L=[100 200 400 500 1000 300];
for i = 1:6
    figure(1)
    subplot(2,3,i)
    Z=PCA(A{i});
    plot(Z(1,:),Z(2,:),'r.','MarkerSize',20);
    xlabel('Principal Component 1')
    ylabel('Principal Component 2')
    title(['Principal Component 1 vs 2 for L = ' num2str(L(i)) ])
    if i==6
      title('Principal Component 1 vs 2 for modified genetic code ')
    end
end
