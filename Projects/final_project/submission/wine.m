clear;
%clc;
cvx_precision('low');
x = dlmread('winesinfo.csv',';',1,0);
y = x(:,end);
x = x(:,1:end-1);
%n = number of data points 
%m = dim of feature space (11)
[n,m] = size(x);
x = x';
x = vertcat(ones(1,n),x);
x = vertcat(x,-y');


%cvx_begin
%    variable a(m);
%    variable b;
%    obj = 0;
%    for I = 1:n
%        obj = obj + abs(y(I) - a'*x(2:end-1,I) - b);
%    end   
%    obj = obj/n;
%    minimize(obj);    
%cvx_end
disp('********Part B: 1-norm minimization solution***********')
cvx_begin quiet
    variable W(m+2);        
    minimize((1/n)*norm(x'*W,1));
    subject to
        W(end) == 1;
cvx_end



disp(['Status: ',cvx_status]);
disp(['Optimal Value: ', num2str(cvx_optval)]);
disp(['Solution A: ', 'a(1)= ',num2str(W(2))]);
              
for I = 3:12    
    disp(['            ','a(',num2str(I-1),')= ',num2str(W(I))]);
end
    
disp(['         b: ', num2str(W(1))]);

disp('********Part C: least-squares regression ***********')

cvx_begin quiet
    variable W2(m+2);        
    minimize((1/n)*norm(x'*W2,2));    
    subject to
        W2(end) == 1;
cvx_end



disp(['Status: ',cvx_status]);
disp(['Optimal Value: ', num2str(cvx_optval)]);
disp(['RSS:           ', num2str(norm(x'*W2,2)*norm(x'*W2,2))]);
disp(['Solution A: ', 'a(1)= ',num2str(W2(2))]);
              
for I = 3:12    
    disp(['            ','a(',num2str(I-1),')= ',num2str(W2(I))]);
end
    
disp(['         b: ', num2str(W2(1))]);



disp('********Part b: LASSO Model ***********')

cvx_begin quiet
    variable W3(m+2);        
    minimize(norm(x'*W3,2) + 0.2*norm(W3,1));    
    subject to
        W3(end) == 1;
cvx_end



disp(['Status: ',cvx_status]);
disp(['Optimal Value: ', num2str(cvx_optval)]);
disp(['Solution A: ', 'a(1)= ',num2str(W3(2))]);
              
for I = 3:12    
    disp(['            ','a(',num2str(I-1),')= ',num2str(W3(I))]);
end
    
disp(['         b: ', num2str(W3(1))]);

[W3_sorted, W3_sorted_id] = sort(abs(W3(2:end-1)),'descend');

disp('The 4 top features for deciding wine quality')

for I=1:4
    
    if W3_sorted_id(I) == 1
        disp('fixed acidity');        
    elseif W3_sorted_id(I) == 2            
            disp('volatile acidity')
    elseif W3_sorted_id(I) == 3
            disp('citric acid');
    elseif W3_sorted_id(I) == 4  
            disp('residual sugar');
    elseif W3_sorted_id(I) == 5     
            disp('chlorides');
    elseif W3_sorted_id(I) == 6
            disp('free sulfur dioxide');
    elseif W3_sorted_id(I) == 7        
            disp('total sulfur dioxide');
    elseif W3_sorted_id(I) == 8        
            disp('density');
    elseif W3_sorted_id(I) == 9        
            disp('pH');
    elseif W3_sorted_id(I) == 10
            disp('sulphates');
    elseif W3_sorted_id(I) == 11                  
            disp('alcohol');
    end
end