% This code shows what the principal components on a data set of
% 143 pictures/photos. Each data point is a 128 by 128 matrix.
load('faces.mat');
X=reshape(faces,[128^2 143]);
% Figure 1 shows the very last photograph
figure(1); imagesc(reshape(X(:,143),[128,128])); colormap(gray);
pause;
figure(11); imagesc(reshape(X(:,14),[128,128])); colormap(gray);
pause;
figure(12); imagesc(reshape(X(:,4),[128,128])); colormap(gray);
pause;
% Figure 2 shows the ``average face''
aveface=mean(X,2);
figure(2); imagesc(reshape(aveface,[128,128])); colormap(gray);
pause;
% Now we center the data by subtracting the average face.
X0= X-repmat(aveface,[1 143]);
% Now this is how the original last face looks like.
figure(3); imagesc(reshape(X0(:,143),[128,128])); colormap(gray);
pause;

% Now we compute the singular values
[U,S,V]=svd(X0,0);
pause;
% Figure 4 is the most significant face in terms of features.
figure(4); imagesc(reshape(U(:,1),[128,128])); colormap(gray);
pause;
% This is showing the next to each other the first few singular vectors.
figure(5);
for k=1:4
    subplot(2,2,k); imagesc(reshape(U(:,k),[128,128])); colormap(gray);
end