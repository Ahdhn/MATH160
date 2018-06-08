function N = new_influence(S, myGraph, old_influence)
   %compute the influence of adding a new node to the end of S
   %old_influence is the influence of S without the last element
   %such that old_influence contains the neighbours we can influence 
   %with S-S(end)
   
    
    ne = [neighbors(myGraph, S(end)); S(end)];    
    %the new influence is the filtering of the neighbours of the last
    %element in S by:
    %1) the already influences nodes 
    
    added_influence = setdiff(ne,old_influence);
    
    %2)(WRONG) the existing activated nodes in S
    %added_influence = setdiff(added_influence,S);   
   
    N= vertcat(old_influence,added_influence);
    
end