#Number of vertices in the graph
param N := 4039;

#The size of set S 
param K := 1;
set vertSet := {1 .. N}; 


#the decision variable  
var X[vertSet] binary;

#Read the graph edges into matrix M 
set M:= {read "facebook_adjMat.txt" as "<1n, 2n>"};

#Define the constraints 
subto X_norm: sum<i> in vertSet : X[i] <= K;


#Define objective function 
maximize myObjFunc: sum <V> in vertSet : 																
                     (abs(0.5*(((sum <V,j> in M: X[j]) + 1) - abs(((sum <V,j> in M: X[j]) - 1))) - X[V]) +
					     (0.5*(((sum <V,j> in M: X[j]) + 1) - abs(((sum <V,j> in M: X[j]) - 1))) + X[V]));