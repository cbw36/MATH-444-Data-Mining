%% STEP 0: INITIALIZE
%load ('IrisDataAnnotated.mat')
load('GlassData.mat')
C=I;
%I=[1:25, 51:75, 101:125 ];
I=[1:35, 71:108, 147:155, 164:170, 177:181, 186:200 ];
[n, len]= size(I);
%I=[1:len];
%% STEP 1: GROW TREE

R(1).I=(I);
[p, c, r] = ClassDistr(C, R(1).I);
R(1).p=p;
R(1).j=NaN;
R(1).s=NaN;
R(1).left=NaN;
R(1).right=NaN;

PureNodes=[];
MixedNodes=[1];
count=1;

while length(MixedNodes)>0
    %Pick first mixed node and split it
    ind=MixedNodes(1);
    I_ind=R(ind).I;
    X_ind=X(:,I_ind);
    [j,s]=OptimalSplit(I_ind,C,X);
    %Store split values
    R(ind).j=j;
    R(ind).s=s;
    R(ind).left=count+1;
    R(ind).right=count+2;

    %Define children as structs
    I_left=I_ind(find(X_ind(j,:)<=s));
    [p_left, c_left, r_left]=ClassDistr(C,I_left);
    R(count+1).I=I_left;
    R(count+1).p=p_left;
    R(count+1).j=NaN;
    R(count+1).s=NaN;
    R(count+1).left=NaN;
    R(count+1).right=NaN; 

    if r_left==0
        PureNodes=[PureNodes, count+1];
    else
        MixedNodes=[MixedNodes, count+1];
    end

    
    I_right=setdiff(I_ind,I_left);
    [p_right, c_right, r_right]=ClassDistr(C,I_right);
    R(count+2).I=I_right;
    R(count+2).p=p_right;
    R(count+2).j=NaN;
    R(count+2).s=NaN;
    R(count+2).left=NaN;
    R(count+2).right=NaN;  
    if r_right==0
        PureNodes=[PureNodes, count+2];
    else
        MixedNodes=[MixedNodes, count+2];
    end

    
    MixedNodes=MixedNodes(2:end);
    count=count+2;
end

%% STEP 2: PRUNE TREE
%Find leaves

R_curr=R;
num_nodes=length(R_curr);
T=cell(1,num_nodes);
alpha_star=zeros(1,num_nodes);
count=1;

%Iterate until explored entire tree
while length(R_curr)~=1
    num_nodes=length(R_curr);
    A=zeros(num_nodes,num_nodes); %successor matrix
    G=zeros(num_nodes,num_nodes); %Genealogy matrix
    for k=1:num_nodes
        i=R_curr(k).left;
        j=R_curr(k).right;
        if ~isnan(i)
            A(k,i)=1;
            A(k,j)=1;
        end
    end
    A_next=A;
    while sum(A_next(:))~=0
        G=G+A_next;
        A_next=A*A_next;
    end
    
    I_leaf=[];
    for i=1:length(R_curr)
        if sum(G(i,:))==0
            I_leaf= [I_leaf i];
        end
    end
    alpha=zeros(1,num_nodes);
    
    %Compute alpha for all nodes that are not leaves
    for i=1:num_nodes
        if sum(G(i,:))==0
            alpha(i)=inf;
        else
            Ii=find(G(i,:)==1); %Find children
            Jleafs=intersect(Ii,I_leaf); %Find which children are leaves
            nleafs=length(Jleafs); %number of leaves below Rcurr(i)
            m_node=MisclassCost(R_curr(i),size(I,2), C);
            m_leaves=0;
            for l=1:length(Jleafs)
                m_leaves=m_leaves + MisclassCost(R_curr(l), size(I,2), C);
            end
            alpha(i)=(m_node-m_leaves)/(nleafs-1);
        end
    end
    
    %Find the minimum alpha
    [a_min, ind]=min(alpha);
    children=find(G(ind,:)==1);
    
    %Prune the tree at alpha min
    R_curr(ind).left=NaN;
    R_curr(ind).right=NaN;
    
    for c=length(children):-1:1
        R_curr=R_curr([ 1:children(c)-1, children(c)+1:length(R_curr) ]);
    end
    
    for l=1:length(R_curr)
        for c=length(children):-1:1
            if R_curr(l).left>children(c)
                R_curr(l).left=R_curr(l).left-1;
            end
            if R_curr(l).right>children(c)
                R_curr(l).right=R_curr(l).right-1;
            end
        end
    end
            
    T{count}=R_curr;
    alpha_star(count)=a_min;
    count=count+1;
end


%% Test Data
%I_test=[26:50, 76:100,126:150 ];
I_test=[36:70, 109:146, 156:163, 170:176, 181:185, 200:214];
classified=zeros(length(T),length(I_test));
%Iterate through all  trees to see which is best
for t=1:length(T)
    tree_cur=T{t};
    if isempty(tree_cur)
        break
    end
    %Iterate through all data points
    for i=1:length(I_test)
        R_cur=tree_cur(1);
        i_cur=I_test(i);
        x_cur=X(:,i_cur);        
        while ~isnan(R_cur.left)
            if x_cur(R_cur.j)<=R_cur.s
                R_cur=tree_cur(R_cur.left);
            else
                R_cur=tree_cur(R_cur.right);
            end
        end
        [val class]=max(R_cur.p);
        classified(t,i) = class;
    end    
end

specificity=zeros(1,length(T));
for i=1:length(T)
    num_correct=0;
    for j=1:length(I_test)
        if classified(i,j)==C(I_test(j))
            num_correct=num_correct+1;
        end
    end
    specificity(i)=num_correct/length(I_test);
end