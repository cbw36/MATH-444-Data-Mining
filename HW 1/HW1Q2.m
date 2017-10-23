load HandwrittenDigits X I;

X_0=X(:,(find(I==0)));
[U,S,V]=svd(X,'econ');
residual_x_0=zeros(256,5);
for i=1:5
    for k=1:5
        z=U(:,1:5*k)'*X_0(:,i);
        reconstructed_x_0= U(:,1:5*k)*z;
        this_residual_0 = X_0(:,i)-reconstructed_x_0;
        residual_x_0(:,k)=residual_x_0(:,k) + this_residual_0;

        figure(1);
        subplot(5,5,5*(k-1)+i);
        imagesc(reshape(reconstructed_x_0,16,16)');
        colormap(1-gray);
        axis('square');
        axis('off');
        title(['sample ' num2str(i) ', ' num2str(5*k) ' feature vectors'])
        
        figure(2);
        subplot(5,5,5*(k-1)+i);
        imagesc(reshape(this_residual_0,16,16)');
        colormap(1-gray);
        axis('square');
        axis('off');  
        title(['sample ' num2str(i) ', ' num2str(5*k) ' feature vectors'])

    end
end
residual_x_0=sum(sqrt(((residual_x_0/5).^2)))*(1/256);


X_1=X(:,(find(I==1)));
[U,S,V]=svd(X,'econ');
residual_x_1=zeros(256,5);
for i=1:5
    for k=1:5
        z=U(:,1:5*k)'*X_1(:,i);
        reconstructed_x_1= U(:,1:5*k)*z;
        this_residual_1 = X_1(:,i)-reconstructed_x_1;
        residual_x_1(:,k)=residual_x_1(:,k) + this_residual_1;

        figure(3);
        subplot(5,5,5*(k-1)+i);
        imagesc(reshape(reconstructed_x_1,16,16)');
        colormap(1-gray);
        axis('square');
        axis('off');
        title(['sample ' num2str(i) ', ' num2str(5*k) ' feature vectors'])
        
        
        figure(4);
        subplot(5,5,5*(k-1)+i);
        imagesc(reshape(this_residual_1,16,16)');
        colormap(1-gray);
        axis('square');
        axis('off');   
        title(['sample ' num2str(i) ', ' num2str(5*k) ' feature vectors'])
    end
end
residual_x_1=sum(sqrt(((residual_x_1/5).^2)))*(1/256);


X_3=X(:,(find(I==3)));
[U,S,V]=svd(X,'econ');
residual_x_3=zeros(256,5);
for i=1:5
    for k=1:5
        z=U(:,1:5*k)'*X_3(:,i);
        reconstructed_x_3= U(:,1:5*k)*z;
        this_residual_3 = X_3(:,i)-reconstructed_x_3;
        residual_x_3(:,k)=residual_x_3(:,k) + this_residual_3;

        figure(5);
        subplot(5,5,5*(k-1)+i);
        imagesc(reshape(reconstructed_x_3,16,16)');
        colormap(1-gray);
        axis('square');
        axis('off');
        title(['sample ' num2str(i) ', ' num2str(5*k) ' feature vectors'])
        
        figure(6);
        subplot(5,5,5*(k-1)+i);
        imagesc(reshape(this_residual_3,16,16)');
        colormap(1-gray);
        axis('square');
        axis('off'); 
        title(['sample ' num2str(i) ', ' num2str(5*k) ' feature vectors'])
    end
end
residual_x_3=sum(sqrt(((residual_x_3/5).^2)))*(1/256);


X_7=X(:,(find(I==7)));
[U,S,V]=svd(X,'econ');
residual_x_7=zeros(256,5);
for i=1:5
    for k=1:5
        z=U(:,1:5*k)'*X_7(:,i);
        reconstructed_x_7= U(:,1:5*k)*z;
        this_residual_7 = X_7(:,i)-reconstructed_x_7;
        residual_x_7(:,k)=residual_x_7(:,k) + this_residual_7;

        figure(7);
        subplot(5,5,5*(k-1)+i);
        imagesc(reshape(reconstructed_x_7,16,16)');
        colormap(1-gray);
        axis('square');
        axis('off');
        title(['sample ' num2str(i) ', ' num2str(5*k) ' feature vectors'])
            
        figure(8);
        subplot(5,5,5*(k-1)+i);
        imagesc(reshape(this_residual_7,16,16)');
        colormap(1-gray);
        axis('square');
        axis('off'); 
        title(['sample ' num2str(i) ', ' num2str(5*k) ' feature vectors'])
    end
end
residual_x_7=sum(sqrt(((residual_x_7/5).^2)))*(1/256);


residuals=[residual_x_0; residual_x_1; residual_x_3; residual_x_7];
k=[5 10 15 20 25];
for z=1:4
    figure(9);
    subplot(4,1,z);
    scatter(k,residuals(z,:), 'linewidth', 1.5);
    fnplt(csapi(k,residuals(z,:)))
end

figure(9);
subplot(4,1,1);
title('2-norm error for 0 digit vs k');
xlabel('# feature vectors k')
ylabel('2-norm error')
subplot(4,1,2);
title('2-norm error for 1 digit vs k');
xlabel('# feature vectors k')
ylabel('2-norm error')
subplot(4,1,3);
title('2-norm error 3 digit vs k');
xlabel('# feature vectors k')
ylabel('2-norm error')
subplot(4,1,4);
title('2-norm error 7 digit vs k');
xlabel('# feature vectors k')
ylabel('2-norm error')

