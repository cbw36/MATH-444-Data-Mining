load ('HandwrittenDigits.mat')
%define annotation vectors
I04=[I(find(I==0)) I(find(I==4))];

X04=[X(:,find(I==0)) X(:,find(I==4))];

[V,D]=LDA(X04,I04);
