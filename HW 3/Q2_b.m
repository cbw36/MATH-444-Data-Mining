load ('HandwrittenDigits.mat')

k=5;
% K=[5,10,20]

%define annotation vectors and X04 matrix
I_0=find(I==0);
I_4=find(I==4);
X04=[X(:,I_0) X(:,I_4)];

[W_new, H_new]=ANLS(X04,k);
figure(1)
for j=1:5
    subplot(1,5,j)
    imagesc(reshape(W_new(:,j),16,16)');
    colormap(1-gray);
    axis('square'); 
    axis('off');
    title(['#' num2str(j) ' feature vector'], 'FontSize', 20)
end


% time=1;
% for i=1:3
%     k=K(i);
%     [W_new, H_new]=ANLS(X04,k);
%     figure(i)
%     for j=1:k
%         subplot(5,4,j)
%         imagesc(reshape(W_new(:,j),16,16)');
%         colormap(1-gray);
%         axis('square');
%         axis('off');
%         title(['k = ' num2str(k)])
%     end
%     
%     figure(100*time)
%     subplot(1,2,1)
%     imagesc(reshape(W_new*H_new(:,330),16,16)');
%     colormap(1-gray);
%     axis('square');
%     axis('off');
%     title([num2str(k) ' feature vector reconstruction of digit 4 from X04[330]' ])
%     
%     subplot(1,2,2)
%     imagesc(reshape(W_new*H_new(:,5),16,16)');
%     colormap(1-gray);
%     axis('square');
%     axis('off');
%     title([num2str(k) ' feature vector reconstruction of digit 0 from X04[5]' ])
%     
%     
%     time=time+1;
% end