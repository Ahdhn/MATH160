%using pagerank for influence maximization problem 
clear;
%close all;
edgeList = dlmread('facebookgraph.txt',' ');
edgeList = 1+edgeList;
sizeList = length(edgeList);
myGraph = graph(edgeList(:,1),edgeList(:,2),ones(sizeList,1));

prompt = 'Please enter the budget K (enter 0 for K=|V|): ';
K = input(prompt);
%K = 11;
if K == 0
    K = myGraph.numnodes;
end

%Compute the row stochastic matrix P
P = zeros(myGraph.numnodes,myGraph.numnodes);
for J = 1:myGraph.numnodes
    J_ne = neighbors(myGraph, J);
    for l=1:length(J_ne)
        I = J_ne(l);
        if J <I
            I_ne = neighbors(myGraph, I);
            P(I,J) = 1/length(J_ne);
            P(J,I) = 1/length(I_ne);
        end
    end
end
%Compute PageRank rank
PR_rank = PageRank(P);
[PR_val, PR_List] = sort(PR_rank,'descend');


S_influence = zeros(K,1);
Influence_list = [];
S = PR_List(1:K);
for I=1:K
    Influence_list = new_influence(S(1:I), myGraph, Influence_list);
    S_influence(I) = length(Influence_list);
end

[S_h,S_influence_h,Influence_list_h] =  Pick_Heuristic(K, PR_List,myGraph);




disp(['The Page Rank approximate optimal influence size (I(S) = |N(S)|): ', ...
    num2str(S_influence(end))]);
disp(['The Page Rank approximate optimal node set (S): ', num2str(S(1)-1)]);
for I = 2:K
    disp(['                                            ', num2str(S(I)-1)]);
end
plot(1:K, S_influence(1:K),'b-*','LineWidth',2.0);
%text(1:K, S_influence(1:K),num2str(S_influence(1:K)),...
%    'FontWeight','bold', 'VerticalAlignment','bottom','Color','red');
ylabel('I(S)','FontSize', 15,'FontWeight','bold');
xlabel('K','FontSize', 15,'FontWeight','bold');




disp(['The Page Rank - Heuristic approximate optimal influence size (I(S) = |N(S)|): ', ...
    num2str(S_influence_h(end))]);
disp(['The Page Rank approximate optimal node set (S): ', num2str(S_h(1)-1)]);
for I = 2:K
    disp(['                                            ', num2str(S_h(I)-1)]);
end
hold on
plot(1:K, S_influence_h(1:K),'r-o','LineWidth',2.0);
%text(1:K, S_influence(1:K),num2str(S_influence(1:K)),...
%    'FontWeight','bold', 'VerticalAlignment','bottom','Color','red');
ylabel('I(S)','FontSize', 15,'FontWeight','bold');
xlabel('K','FontSize', 15,'FontWeight','bold');
legend('PangRank - Highest Rank','PangRank - Heuristic');




function [S,S_influence,Influence_list] =  Pick_Heuristic(K, PR_List,myGraph) 
    
    
    S_influence = zeros(K,1);
    Influence_list = [];
        
    S(1) = PR_List(1);
    Influence_list = new_influence(S, myGraph, Influence_list);
    S_influence(1) = length(Influence_list);
    
    for I = 2:K
        new_vert = PR_List(I);
        max_Influence_list = new_influence(horzcat(S,new_vert), myGraph, Influence_list);
        max_val = length(max_Influence_list);
        max_diff = max_val - S_influence(I-1);
        max_id = I;
        
        for J=I+1:I+6
            J_vert = PR_List(J);
            J_Influence_list = new_influence(horzcat(S,J_vert), myGraph, Influence_list);
            J_val = length(J_Influence_list);
            J_diff = J_val - S_influence(I-1);
            if J_diff > max_diff
                max_diff = J_diff;
                max_val = J_val;
                max_Influence_list = J_Influence_list;
                max_id = J;
            end            
        end        
        
        Influence_list = max_Influence_list;
        S_influence(I) = max_val;
        S(I) = PR_List(max_id);
        
        [PR_List(I),PR_List(max_id)] = deal(PR_List(max_id),...
            PR_List(I));%swap
    end
    
    
    
end

function r = PageRank(A)
    [row_len, col_len] = size(A);
    for n =1:col_len
        A(:,n) = A(:,n)./sum(A(:,n));
    end

    %compute modified A
    alpha = 0.85;
    A = (1-alpha)*(1/length(A)) + alpha*A ;

    %[eig_vects, eig_val] = eig(A);
    %first eig_vects gives you the rating 
    %display_rating(real(eig_vects(:,1))./norm(real(eig_vects(:,1)),1));

    r = rand(length(A),1);
    while true
        q = A*r;
        temp_r = r;
        r = q./norm(q,1);
        %stopping criterion based on 1-norm 
        if abs(norm(r-temp_r,1)) <= eps
            break;
        end    
    end
end