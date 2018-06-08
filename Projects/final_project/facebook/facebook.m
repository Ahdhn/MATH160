%greedy algorithm for influence maximization problem 
%clc;
clear;
close all;
edgeList = dlmread('facebookgraph.txt',' ');
%increment all edges by 1 as matlab does not recognize 0 indexing 

%[row col V] = find(myGraph.adjacency);
%dlmwrite('facebook_adjMat.txt',[col row],'delimiter',' ');

edgeList = 1+edgeList;
sizeList = length(edgeList);
myGraph = graph(edgeList(:,1),edgeList(:,2),ones(sizeList,1));

prompt = 'Please enter the budget K (enter 0 for K=|V|): ';
K = input(prompt);
if K == 0
    K = myGraph.numnodes;
end

S = zeros(K,1);
S_influence = zeros(K,1);
maxInfluence_list=0;
currentInfluence_list =[];
for step=1:K
    disp([' Step: ', num2str(step)]);
    %at each step of the greedy algo
    %add the node that maximize the marginal gain
    %marginal gain is the difference between the influence after add 
    %a new node and the current influence of S
    newS = S(1:step);    
    maxInfluence_id = 0;
    for I = 1:myGraph.numnodes
        %we are not allowed to repeate nodes so we don't have to consider
        %them 
        if ismember(I,S)
            continue;
        end
        newS(step) = I;
        newInfluence = new_influence(newS, myGraph,currentInfluence_list);
        if length(newInfluence) > length(maxInfluence_list)
            maxInfluence_id = I;
            maxInfluence_list = newInfluence;
        end
    end
    S(step)= maxInfluence_id;    
    S_influence(step) = length(maxInfluence_list);
    currentInfluence_list = maxInfluence_list;
    
    disp([' Current I(S):',num2str(length(currentInfluence_list))]);
    
    if length(currentInfluence_list) + step >= myGraph.numnodes
        disp('***** We reached an influence size I(S) >= the number');
        disp(['of nodes in the graph with only K=', num2str(step)]);
        disp('For that the code terimates***** ');
        K= step;
        break;
    end
end
disp(['The approximate optimal influence size (I(S) = |N(S)|): ', num2str(length(currentInfluence_list))]);
disp(['The approximate optimal node set (S): ', num2str(S(1)-1)]);
for I = 2:K
    disp(['                                      ', num2str(S(I)-1)]);
end

plot(1:K, S_influence(1:K),'k-o','LineWidth',2.0);
%text(1:K, S_influence(1:K),num2str(S_influence(1:K)),...
%    'FontWeight','bold', 'VerticalAlignment','bottom','Color','red');
%legend('Greedy Algorithm');
ylabel('I(S)','FontSize', 15,'FontWeight','bold');
xlabel('K','FontSize', 15,'FontWeight','bold');


