%greedy algorithm for influence maximization problem 
clear;
close all;
global myGraph;
edgeList = dlmread('facebookgraph.txt',' ');
%increment all edges by 1 as matlab does not recognize 0 indexing 
K = 1;
edgeList = 1+edgeList;
sizeList = length(edgeList);
myGraph = graph(edgeList(:,1),edgeList(:,2),ones(sizeList,1));

Aeq = ones(myGraph.numnodes,1)';
X = ga(@myObjFun, myGraph.numnodes, [],[], Aeq, K,0,1, [],1);


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