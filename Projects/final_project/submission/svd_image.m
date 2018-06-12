clear;
clf;

%load all matrices with appropriate banes 
load('azip.mat');
trainSet = azip; clear azip;
load('dzip.mat');
trainLabel = dzip; clear dzip;
load('testzip.mat');
testSet = testzip; clear testzip;
load('dtest.mat');
testLabel = dtest; clear dtest;
%ima2(trainSet(:,1)');

K_start =2;
K_end = 88;

accuracy = zeros(K_end-K_start,1);%the overall accuracy
accuracy_classes =zeros(K_end-K_start,10);%accuracy for each class 
confusion_max = zeros(10,10);
num=1;
for K=K_start:K_end	
    disp(['K= ',num2str(K)]);
    leftSingVec = zeros(size(trainSet,1),K,10);
    for I=0:9
        leftSingVec(:,:,I+1) = computeRank_K(trainSet(:,trainLabel==I),K);
    end

    %for C=1:5
    %    for S=1:5
    %         saveas(ima2(leftSingVec(:,S,C)),['class_',num2str(C),'_K',num2str(S),'.png']);         
    %    end
    %end

    inferenceLabel = -1.0*ones(size(testLabel));
    for I = 1:length(testLabel)
        inferenceLabel(I) = getDigit(leftSingVec,testSet(:,I));
    end
    
    %calc accuracy per class     
    for C=0:9        
        lab = testLabel == C;        
        accuracy_classes(num, C+1)= sum(inferenceLabel(lab)~=C)/sum(lab);%err
        accuracy_classes(num, C+1)= (1 - accuracy_classes(num, C+1))*100;
    end
    
    %if K == 28
    %   lol = testLabel==9 & inferenceLabel~=9;
    %    poop=1;
    %    for I=1:2007            
    %        if lol(I)==1
    %            saveas(ima2(testSet(:,I)),['nine',num2str(poop),'_',num2str(inferenceLabel(I)),'.png']);         
    %            poop = poop +1;
    %        end
    %    end
    %end
    error = 100.0*sum((inferenceLabel - testLabel) ~= 0)/length(testLabel);    
    accuracy(num)= 100-error;   
    
    num = num+1;    
end
stem(accuracy);
ylabel('Accuracy (%)','FontSize', 13,'FontWeight','bold');
xlabel('Number of basis vector','FontSize', 13,'FontWeight','bold');
[val,num] = max(accuracy);
disp(['All-classes max accuracy is ', num2str(val), ' for ',num2str(num)+1, ' basis vectors']);


figure 
plot(accuracy_classes);

ylabel('Accuracy (%)','FontSize', 13,'FontWeight','bold');
xlabel('Number of basis vector','FontSize', 13,'FontWeight','bold');
legend('Num=0','Num=1','Num=2','Num=3','Num=4','Num=5','Num=6','Num=7','Num=8','Num=9');


[val,num] = max(accuracy_classes);
disp('Per-class max accuracy along with the number of basis associated with it is as follows:');
for C=0:9
    disp(['class ',num2str(C), ': max accuracy= ',num2str(val(C+1)),'  basis vector= ',num2str(num(C+1)+1)]);
end


function U = computeRank_K(X, K)
    %compute the K SVD of X
    %return the K largest left singular vectors 
    [U,S,V] = svds(X,K);
end
function digit = getDigit(leftSingVec, testVec)
    %compute the residual between testVec and all the rank 
    %k approximation of the ten digits stored in leftStingVec
    %return the digit with min error 
    min = realmax;
    min_dg = -1;
    for dg =0:9
        E = norm(testVec - leftSingVec(:,:,dg+1)*...
            (leftSingVec(:,:,dg+1)'*testVec));
        if min > E
            min = E;
            min_dg = dg;
        end
    end
    if min_dg <0
        disp('Error in computeError');
    end
    digit = min_dg;
end


