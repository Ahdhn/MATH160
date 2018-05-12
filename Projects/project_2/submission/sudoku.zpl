set I := {1 .. 9};
set J := {1 .. 9};
set K := {1 .. 9};
set S := {1, 2, 3};


set inputs:= {read "sudo3.txt" as "<1n, 2n, 3n>"};

var X[I*J*K] binary;
subto celonce: forall <i,j> in I*J do sum <k> in K:X[i,j,k]==1;
subto rowonce: forall <i,k> in I*K do sum <j> in I:X[i,j,k]==1;
subto colonce: forall <j,k> in J*K do sum <i> in J:X[i,j,k]==1;
subto inpcells: forall <i,j,k> in inputs do X[i,j,k]==1;

subto part1A: forall <k> in K do sum <i,j> in S*S:X[i,  j,k]==1;
subto part2A: forall <k> in K do sum <i,j> in S*S:X[i+3,j,k]==1;
subto part3A: forall <k> in K do sum <i,j> in S*S:X[i+6,j,k]==1;

subto part1B: forall <k> in K do sum <i,j> in S*S:X[i,  j+3,k]==1;
subto part2B: forall <k> in K do sum <i,j> in S*S:X[i+3,j+3,k]==1;
subto part3B: forall <k> in K do sum <i,j> in S*S:X[i+6,j+3,k]==1;

subto part1C: forall <k> in K do sum <i,j> in S*S:X[i,  j+6,k]==1;
subto part2C: forall <k> in K do sum <i,j> in S*S:X[i+3,j+6,k]==1;
subto part3C: forall <k> in K do sum <i,j> in S*S:X[i+6,j+6,k]==1;

