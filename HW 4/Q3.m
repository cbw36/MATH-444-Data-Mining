%% PART 0: LOAD DATA
load('ForestSpectra.mat');
X_train=X;  I_train=Itype;

clusters=unique(I_train);  num_clusters=size(clusters, 2);

load('ForestSpectraTest.mat');
X_test=X;  I_test=Itype;
num_test=size(I_test,2);

%% PART 1: CALCULATE LDA COMPONENTS OF EACH CLUSTER 
[V,D]= LDA(X_train, I_train, 1);
Z=cell(1,num_clusters);
for i=1:num_clusters
    Z{i}=V'*X_train(:,I_train==(i));
end

% figure(1)
% colors=['r','g', 'b', 'k'];
% for i=1:num_clusters
%     scatter3(Z{i}(1,:),Z{i}(2,:), Z{i}(3,:),colors(i));
%     hold on
% end


%% PART 2: COMPUTE CENTROID OF Z's
c=cell(1,num_clusters);
for i=1:num_clusters
    c{i}=(1/size(Z{i},2)) * sum(Z{i},2);
end

%% PART 3: RUN CLASSIFIER AND EXAMINE SUCCESS
I_lda=zeros(1,num_test);
for i=1:num_test
    I_lda(i)=LDA_Classifier(X(:,i), V', c, num_clusters);
end

num_correct=0;
for i=1:num_test
    if I_lda(i)==I_test(i)
        num_correct=num_correct + 1;
    end
end
success_rate=num_correct/num_test;
