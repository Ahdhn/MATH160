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
    if abs(norm(r-temp_r,1)) < eps
        break;
    end    
end
display_rating(r);

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function display_rating(rating_vect)
    
    %first sort the rating from hardest to easiest
    [sorted_y, sorting_id] = sort(rating_vect);    
    disp(['Using Page Rank method, below is ranking of candidates', char(10),...
        '       starting with the highest (with rating): ']); 
    
    len = length(rating_vect);
    
    for k= len:-1:1
        l = sorting_id(k);
        disp([getCandidateName(l) , num2str(rating_vect(l))]);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function candidate_string = getCandidateName(candidate_num)
    %convert the candidate number to name 
    %1 = HC
    %2 = BS
    %3 = JK
    %4 = TC
    %5 = DT
    if candidate_num == 1
        candidate_string = "HC";
    elseif candidate_num == 2
        candidate_string = "BS";
    elseif candidate_num == 3
        candidate_string = "JK";
    elseif candidate_num == 4
        candidate_string = "TC";
    elseif candidate_num == 5
        candidate_string = "DT";
    else
        warning('Invalid input to getNum()');
    end
end