function [p, c, r]=ClassDistr(C,I)
    n=size(I,2);  %total number of elements in the rectangle
    c=mode(C(I)); %c is the mode of the classes of the elements in the rectangle
    classes=unique(C); %find the class values
    k=size(classes,2); %and the number of classes to iterate through
    p=zeros(1,k);  %the size of p must be the number of classes
    for i=1:k
        num_i=size(find(C(I)==classes(i)),2); %find number of elements in class i
        p(i)=num_i/n; %divide this by the total number of elements for the frequency
    end
    r=1-p(c); %the misclassification error is 1 minus the frequency of the majority class, since all other elements are misclassified as this majority clasz
end