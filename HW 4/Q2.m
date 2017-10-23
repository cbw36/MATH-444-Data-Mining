load('HandwrittenDigits.mat');
X_train=X;  I_train=I;

load('HandwrittenDigitsTestset.mat');
X_test=X;  I_test=I;

K=30;
success_rate=zeros(1,K);

for k=1:K
    I_knn=KNN(X_train, I_train, X_test, I_test,k);
    num_correct=0;
    for y=1:size(I_test,2)
        if I_knn(y)==I_test(y)
            num_correct=num_correct + 1;
        end
    end
    success_rate(k)=num_correct/size(I_test,2);
end
figure(1)
xlabel('Number of Neighbors to Examine');
ylabel('Success Frequency');
title('Success Frequency as a Function of Number of Neighbors on Test Set');
plot([1:30], success_rate, 'r.-')
    