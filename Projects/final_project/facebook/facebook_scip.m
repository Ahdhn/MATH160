%greedy algorithm for influence maximization problem 
clear;
close all;
global myGraph;
edgeList = dlmread('facebookgraph.txt',' ');
%increment all edges by 1 as matlab does not recognize 0 indexing 
global K

prompt = 'Please enter the budget K (enter 0 for K=|V|): ';
K = input(prompt);
if K == 0
    K = myGraph.numnodes;
end


if ismember(0, edgeList(:))
    edgeList = 1+edgeList;
end
sizeList = length(edgeList);
myGraph = graph(edgeList(:,1),edgeList(:,2),ones(sizeList,1));

X   = ...
    ga(@myObjFun,... %obj func to `minimize` (- our original obj func)
    myGraph.numnodes,... %number of vraibles 
    [], [],... %linear inequality constraints 
    [],[],... %linear equality constraints 
    -0.000001,1.000001,... %lower and upper bounds
    @mycon,...
    1:myGraph.numnodes);%variables that are integer (all of them)


function obj = myObjFun(X)
    global myGraph;    
    obj = 0;
    for I=1:myGraph.numnodes
        ne = neighbors(myGraph,I);
        blah = X(ne);
        if sum(blah) >= 1
            obj = obj+1;
        end        
    end
    obj =-obj;
end

function [c,ceq] = mycon(x)
    global K;
    c = norm(x,1)-K;
    ceq = [];%because of the integer constraints
end