function [j_opt, s_opt] = OptimalSplit(I,C,X)
n=size(X,1);
m_j=zeros(2,n);
for j=1:n
    [x, new_ind, ~]=unique(X(j,I));
    [x_sort, j_sort] = sort(x, 'ascend');
    p=size(x,2);
    s=zeros(1, p-1);
    m_s=zeros(1,p-1);
     for i=1:p-1
        s(i)=0.5 * (x_sort(i) + x_sort(i+1));
        I_left=I(find(X(j,I) <= s(i)));
        I_right=I(find((X(j,I) > s(i))));
        c_left=C(I_left);
        c_right=C(I_right);
        c1=(1/(length(c_left)))*sum(c_left);  
        c2=(1/(length(c_right)))*sum(c_right);
        m_s(i)=sum((c_left - c1).^2) + sum((c_right-c2).^2);
    end
    if isempty(s)
        s = x_sort(1);
        c=(1/length(C(I))) * sum(C(I));
        m_s(1)=sum((C(I)-c).^2);
    end
    [m_val, ind]=min(m_s);
    s_star=s(ind);
    m_j(:,j)=[m_val;s_star];
end
[~, j_opt] = min(m_j(1,:));
s_opt=m_j(2, j_opt);
end