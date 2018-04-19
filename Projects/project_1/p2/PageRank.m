clc;
clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%get the file content as in cell structure
fid = fopen("rankingcandidates.dat");
file_content = textscan(fid,'%s %s %s %s %s','Delimiter',',');
%convert file content to string array 
col_len = length(file_content);
%initialze the string array
first_col = string(cell2mat(file_content{1}));
rankingcandidates = first_col;
%concatenate the rest of columns 
for n=2:col_len
   rankingcandidates = horzcat(rankingcandidates, string(cell2mat(file_content{n})));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%A array should be read as:
%1st col = HC
%2nd col = BS
%3rd col = JK
%4th col = TC
%5th col = DT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%use the for debugging, otherwise comment it out 
%rankingcandidates = [ "HC" "BS" "JK" "TC" "DT";
%                      "BS" "DT" "TC" "HC" "JK"];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                  
[row_len, col_len] = size(rankingcandidates);
A = zeros(col_len,col_len);
for v=1:row_len%for each voter 
    for can=2:col_len
        can_num = getNum(rankingcandidates(v,can));
        %for each candidate, add its affect to in A (column wise)
        %start with 2 since the first candidate add an all-zero column
        for def=1:can-1
            %check with all the candidate that voter voted to             
            def_num = getNum(rankingcandidates(v,def));
            A(def_num, can_num) = A(def_num, can_num)+1;            
            
        end
                
    end
end

for n =1:col_len
    A(:,n) = A(:,n)./sum(A(:,n));
end


%{
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
end
%}
function num = getNum(candidate_string)
    %convert the candidate name to number
    %1 = HC
    %2 = BS
    %3 = JK
    %4 = TC
    %5 = DT
    if candidate_string == "HC"
        num = 1;
    elseif candidate_string == "BS"
        num = 2;
    elseif candidate_string == "JK"
        num = 3;
    elseif candidate_string == "TC"
        num = 4;
    elseif candidate_string == "DT"
        num = 5;
    else
        warning('Invalid input to getNum()');
    end
end
    
