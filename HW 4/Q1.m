success_rate_test=zeros(1,16);
success_rate_train=zeros(1,16);

load('HandwrittenDigits.mat');
X_train=X;  I_train=I;
load('HandwrittenDigitsTestset.mat');
X_test=X;  I_test=I;


m=[1:5:80];
for y=1:size(m,2)
    P=PCA(X_train,I_train,m(y));

    I_pca_test=PCA_Classifier(X_test,I_test,P);
    I_pca_train=PCA_Classifier(X_train,I_train,P);


    num_correct_train=0;
    num_correct_test=0;
    for i=1:size(I_train,2)
        if I_pca_train(i)==I_train(i)
            num_correct_train=num_correct_train + 1;
        end
    end
    
    for i=1:size(I_test,2)
        if I_pca_test(i)==I_test(i)
            num_correct_test=num_correct_test + 1;
        end
    end
    success_rate_train(y)=num_correct_train/size(I_train,2);
    success_rate_test(y)=num_correct_test/size(I_test,2);
end


%%
figure(1);
xlabel('Number of Principal Components');
ylabel('Success Frequency ');
title('Success Frequency as a Function of Principal Components on Test Set');
plot([1:5:80], success_rate_test, 'r.-')
    
figure(2);
xlabel('Number of Principal Components');
ylabel('Success Frequency ');
title('Success Frequency as a Function of Principal Components on Train Set');
plot([1:5:80], success_rate_train, 'r.-')