function [W_new, H_new]= ANLS(X,k)

%initialize W, tolerance, and time
[n,p]=size(X);
W_old=rand(256,k);
H_old=zeros(k,441);
time=0;
t=.001;
dq=1.1;

while dq>t
    %update H 
    H_new=zeros(k,p);
    for j=1:p 
        H_new(:,j)=lsqnonneg(W_old,X(:,j));
    end
    
    %update w
    for i=1:n
        W_new(i,:)=lsqnonneg(H_new',X(i,:)')';
    end
    
    %Calculate norms and scale the matrices
    L=zeros(k,k);
    for i=1:k
        L(i,i)=max(W_new(:,i));
    end
    
    %prepare next iteration
    W_new=W_new*inv(L);
    H_new=L*H_new;
    
    
    w_num=norm(W_new-W_old,'fro');
    w_denom=norm(W_old, 'fro');
    h_num=norm(H_new-H_old, 'fro');
    h_denom=norm(H_old, 'fro');
    
    H_old=H_new;
    W_old=W_new;

    dw=w_num/w_denom;
    dh=h_num/h_denom;    
    dq=dh+dw;
    time=time+1;   

end
end