%Code for finding A, up to the 5x5 matrix of the sums of all 240 matrices

sum_of_matrices = [1 2 3; 4 5 6; 7 8 9];

%Column sum in the form of 1x5 matrix.
s = sum(sum_of_matrices)

%Gives A matrix
for n = 1:3
    A(:,n) = sum_of_matrices(:,n)/s(1,n)
end

%Equation for A_tilde, alpha = .85
A_tilde = A*.85+(.15/3)*ones(3,3)

%Random r
r = randperm(999,3)'

%Power Method
for k = 1:999
    q_k = A_tilde*r^(k-1)
    r_k = q_k/norm(q_k,1)
    if abs(r_k_minus - r_k) < 0.001
        break;
    end
    
    
