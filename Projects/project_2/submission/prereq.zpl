#AB_ST
param numUniqueCourses := 50;
param numQuarters := 20;
param numCourses := 55;
set Quarters := {1 .. numQuarters};
set Courses := {1 .. numCourses};
set must := {37,38,39,40,43,44,13,14,15,21,28,2,4,23};
set Optional3 := {1,3,4,23,24};
set Optional4 := {47,46};
set Optional5 := {3,4,5,6,7,8,9,10,11,12,13,14,15,16};
set edges:= {read "edges.txt" as "<1n, 2n>"};


var X[Courses*Quarters] binary;

#only take 3 courses per quarter 
subto take3course: forall <j> in {1 .. numQuarters} do sum <i> in {1 .. numUniqueCourses} : X[i,j] <=3;

#only take the course once 
subto takeonce: forall <i> in {1 .. numCourses} do sum <j> in {1 .. numQuarters} : X[i,j] <=1;

#these are the must take course for this major 
subto musttake: forall <i> in must do sum <j> in {1 .. numQuarters} : X[i,j] == 1;

#the only-one-needed optional courses 
subto op1: sum <j> in {1 .. numQuarters} : X[53,j] == 1;
subto op2: sum <j> in {1 .. numQuarters} : X[42,j] == 1;
subto op3: forall <i> in Optional3 do sum <j> in {1 .. numQuarters} : X[i,j] >= 1;
subto op4: forall <i> in Optional4 do sum <j> in {1 .. numQuarters} : X[i,j] >= 1;
subto op5: forall <i> in Optional5 do sum <j> in {1 .. numQuarters} : X[i,j] >= 1;

#the prerequistes of the courses 
#course A pointing to course B (A should be taken before B)
subto e:  forall <A,B> in edges: sum<j>in {1 .. numQuarters} : j*X[A,j] <= sum<i>in {1 .. numQuarters} : i*X[B,i];
 
#take course A or course B before course C
#OR_EDGE = {A,B}
subto or1A: sum <j> in {1 .. numQuarters} : X[48,j] <= sum <j> in {1 .. numQuarters} : X[38,j] + sum <j> in {1 .. numQuarters} : X[49,j];
#subto or2A: sum <j> in {1 .. numQuarters} : j*X[38,j] <= (sum <j> in {1 .. numQuarters} : X[38,j]) * (sum <j> in {1 .. numQuarters} : X[48,j]);
#subto or3A: sum <j> in {1 .. numQuarters} : j*X[49,j] <= (sum <j> in {1 .. numQuarters} : X[49,j]) * (sum <j> in {1 .. numQuarters} : X[48,j]);
#
subto or1B: sum <j> in {1 .. numQuarters} : X[49,j] <= sum <j> in {1 .. numQuarters} : X[37,j] + sum <j> in {1 .. numQuarters} : X[50,j];
#subto or2B: sum <j> in {1 .. numQuarters} : j*X[37,j] <= (sum <j> in {1 .. numQuarters} : X[37,j]) * (sum <j> in {1 .. numQuarters} : X[49,j]);
#subto or3B: sum <j> in {1 .. numQuarters} : j*X[50,j] <= (sum <j> in {1 .. numQuarters} : X[50,j]) * (sum <j> in {1 .. numQuarters} : X[49,j]);
#
subto or1C: sum <j> in {1 .. numQuarters} : X[51,j] <= sum <j> in {1 .. numQuarters} : X[41,j] + sum <j> in {1 .. numQuarters} : X[45,j];
#subto or2C: sum <j> in {1 .. numQuarters} : j*X[41,j] <= (sum <j> in {1 .. numQuarters} : X[41,j]) * (sum <j> in {1 .. numQuarters} : X[51,j]);
#subto or3C: sum <j> in {1 .. numQuarters} : j*X[45,j] <= (sum <j> in {1 .. numQuarters} : X[45,j]) * (sum <j> in {1 .. numQuarters} : X[51,j]);
#
subto or1D: sum <j> in {1 .. numQuarters} : X[53,j] <= sum <j> in {1 .. numQuarters} : X[45,j] + sum <j> in {1 .. numQuarters} : X[52,j];
#subto or2D: sum <j> in {1 .. numQuarters} : j*X[45,j] <= (sum <j> in {1 .. numQuarters} : X[45,j]) * (sum <j> in {1 .. numQuarters} : X[53,j]);
#subto or3D: sum <j> in {1 .. numQuarters} : j*X[52,j] <= (sum <j> in {1 .. numQuarters} : X[52,j]) * (sum <j> in {1 .. numQuarters} : X[53,j]);
#
subto or1E: sum <j> in {1 .. numQuarters} : X[54,j] <= sum <j> in {1 .. numQuarters} : X[39,j] + sum <j> in {1 .. numQuarters} : X[48,j];
#subto or2E: sum <j> in {1 .. numQuarters} : j*X[39,j] <= (sum <j> in {1 .. numQuarters} : X[39,j]) * (sum <j> in {1 .. numQuarters} : X[54,j]);
#subto or3E: sum <j> in {1 .. numQuarters} : j*X[48,j] <= (sum <j> in {1 .. numQuarters} : X[48,j]) * (sum <j> in {1 .. numQuarters} : X[54,j]);
#
subto or1F: sum <j> in {1 .. numQuarters} : X[2,j] <= sum <j> in {1 .. numQuarters} : X[55,j] + sum <j> in {1 .. numQuarters} : X[13,j] + sum <j> in {1 .. numQuarters} : X[45,j] + sum <j> in {1 .. numQuarters} : X[23,j];
#subto or2F: sum <j> in {1 .. numQuarters} : j*X[55,j] <= (sum <j> in {1 .. numQuarters} : X[55,j]) * (sum <j> in {1 .. numQuarters} : X[2,j]);
#subto or3F: sum <j> in {1 .. numQuarters} : j*X[13,j] <= (sum <j> in {1 .. numQuarters} : X[13,j]) * (sum <j> in {1 .. numQuarters} : X[2,j]);
#subto or4F: sum <j> in {1 .. numQuarters} : j*X[45,j] <= (sum <j> in {1 .. numQuarters} : X[45,j]) * (sum <j> in {1 .. numQuarters} : X[2,j]);
#subto or5F: sum <j> in {1 .. numQuarters} : j*X[23,j] <= (sum <j> in {1 .. numQuarters} : X[23,j]) * (sum <j> in {1 .. numQuarters} : X[2,j]);

subto or1G: sum <j> in {1 .. numQuarters} : X[55,j] <= sum <j> in {1 .. numQuarters} : X[44,j] + sum <j> in {1 .. numQuarters} : X[1,j] + sum <j> in {1 .. numQuarters} : X[3,j] + sum <j> in {1 .. numQuarters} : X[4,j] +sum <j> in {1 .. numQuarters} : X[24,j];
#subto or2G: sum <j> in {1 .. numQuarters} : j*X[44,j] <= (sum <j> in {1 .. numQuarters} : X[44,j]) * (sum <j> in {1 .. numQuarters} : X[55,j]);
#subto or3G: sum <j> in {1 .. numQuarters} : j*X[1 ,j] <= (sum <j> in {1 .. numQuarters} : X[1 ,j]) * (sum <j> in {1 .. numQuarters} : X[55,j]);
#subto or4G: sum <j> in {1 .. numQuarters} : j*X[3 ,j] <= (sum <j> in {1 .. numQuarters} : X[3 ,j]) * (sum <j> in {1 .. numQuarters} : X[55,j]);
#subto or5G: sum <j> in {1 .. numQuarters} : j*X[4 ,j] <= (sum <j> in {1 .. numQuarters} : X[4 ,j]) * (sum <j> in {1 .. numQuarters} : X[55,j]);
#subto or6G: sum <j> in {1 .. numQuarters} : j*X[24,j] <= (sum <j> in {1 .. numQuarters} : X[24,j]) * (sum <j> in {1 .. numQuarters} : X[55,j]);


minimize cost: sum <i,j> in {1 .. numCourses}*{1 .. numQuarters} : j*X[i,j];

 