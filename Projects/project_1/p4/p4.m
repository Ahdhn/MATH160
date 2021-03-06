clc;
clear;
clf;

load mandrill;

%%%%%%%%%%%%%%%% Part a) %%%%%%%%%%%%%%%%
%draw the image 
image(X);
colormap(map);

%%%%%%%%%%%%%%%% Part b) %%%%%%%%%%%%%%%%
%compute SVD
[U,S,V] = svd(X);

%distributation of singular values 
stem(diag(S)); 
grid;

%%%%%%%%%%%%%%%% Part c) %%%%%%%%%%%%%%%%
%compute approx rank 1
rank_1= S(1,1)*U(:,1)*V(:,1)';

%compute approx rank 6
rank_6 = rank_1;
for k=2:6
    rank_6 =rank_6 + S(k,k)*U(:,k)*V(:,k)';
end

%compute approx rank 11
rank_11 = rank_6;
for k=7:11
    rank_11 =rank_11 + S(k,k)*U(:,k)*V(:,k)';
end

%compute approx rank 31
rank_31 = rank_11;
for k=12:31
    rank_31 =rank_31 + S(k,k)*U(:,k)*V(:,k)';
end

%draw the approx ranks
subplot(2,2,1);
image(rank_1);
title('rank 1 approximation');

subplot(2,2,2);
image(rank_6);
title('rank 6 approximation');

subplot(2,2,3);
image(rank_11);
title('rank 11 approximation');

subplot(2,2,4);
image(rank_31);
title('rank 31 approximation');
colormap(map);


%%%%%%%%%%%%%%%% Part d) %%%%%%%%%%%%%%%%
%compute residual of approx rank_1
res_1 = X-rank_1;
%compute residual of approx rank_6
res_6 = X-rank_6;
%compute residual of approx rank_11
res_11 = X-rank_11;
%compute residual of approx rank_31
res_31 = X-rank_31;


%draw the residuals
subplot(2,2,1);
image(res_1);
title('residual of rank 1 approximation');

subplot(2,2,2);
image(res_6);
title('residual of rank 6 approximation');

subplot(2,2,3);
image(res_11);
title('residual of rank 11 approximation');

subplot(2,2,4);
image(res_31);
title('residual of rank 31 approximation');
colormap(map);

%%%%%%%%%%%%%%%% Part e) %%%%%%%%%%%%%%%%
%compute norm of approx rank_1
norm_1 = norm(X-rank_1);
%compute norm of approx rank_6
norm_6 = norm(X-rank_6);
%compute norm of approx rank_11
norm_11 = norm(X-rank_11);
%compute norm of approx rank_31
norm_31 = norm(X-rank_31);

%display the abs norms
disp(['Absolute norm rank 1 approximation = ', num2str(norm_1)]);
disp(['Absolute norm rank 6 approximation = ', num2str(norm_6)]);
disp(['Absolute norm rank 11 approximation = ', num2str(norm_11)]);
disp(['Absolute norm rank 31 approximation = ', num2str(norm_31)]);

%compute relative error of approx rank_1
r_error_rank_1 = abs(S(2,2) - norm_1)/S(2,2);
%compute relative error of approx rank_6
r_error_rank_6 = abs(S(7,7) - norm_6)/S(7,7);
%compute relative error of approx rank_11
r_error_rank_11 = abs(S(12,12) - norm_11)/S(12,12);
%compute relative error of approx rank_31
r_error_rank_31 = abs(S(32,32) - norm_31)/S(32,32);

%display the relative error
disp(['Relative error of rank 1 approximation = ', num2str(r_error_rank_1)]);
disp(['Relative error of rank 6 approximation = ', num2str(r_error_rank_6)]);
disp(['Relative error of rank 11 approximation = ', num2str(r_error_rank_11)]);
disp(['Relative error of rank 31 approximation = ', num2str(r_error_rank_31)]);
