function I_lda  = LDA_Classifier(x, Q, c, k)

norms=zeros(1,k);
for i=1:k
    norms(i)=norm(Q*x - c{i}, 'fro');
end
[dj, j]=min(norms);
I_lda=j;

