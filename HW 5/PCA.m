function Z = PCA(X)
    [n,p]=size(X);
    x_c = (1/p)*sum(X(:,:),2);
    X_c = X - x_c*ones(1,p);

    [U,D,V]=svd(X_c, 'econ');

    Z=U(:,1:2)'*X;
end