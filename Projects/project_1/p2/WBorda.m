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


[num_voter, num_candidate] = size(rankingcandidates);
%matrix represent the Boards points given by each voter voter
position_mat = zeros(num_voter, num_candidate);
for n=1:num_candidate    
    candidate_string = getCandidateName(n);
    for m=1:num_candidate
        position_mat(:,n) = position_mat(:,n) + ...
            (num_candidate-m+1)*(rankingcandidates(:,m) == candidate_string);
    end
end


borda_weights = [1 2 3 4 5;
                 1/5 1/4 1/3 1/2 1;
                 1/8 1/4 1/2 1/2 1;
                 1/8 1/4 1/2 1/2 1;
                 1/8 1/4 1/2 1/2 1;];

for w = 1:5
    borda_score_mat = zeros(num_voter, num_candidate);
    for m=1:num_candidate
        %not that in position_mat the order is reversed
        %first position is 5 and second position is 4
        %this affect the borda weight
        %borda_score_mat = borda_score_mat + (position_mat == m)* (m-1);
        borda_score_mat = borda_score_mat +...
            (position_mat == m)*borda_weights(w,m);
    end
    rating_vect = zeros(num_candidate,1);
    for n=1:num_candidate
        rating_vect(n) = sum(borda_score_mat(:,n));
    end
    
    disp(['Borda weights [',num2str(borda_weights(w,5)),' ',...
        num2str(borda_weights(w,4)),' ',...
        num2str(borda_weights(w,3)),' ',...
        num2str(borda_weights(w,2)),' ',...
        num2str(borda_weights(w,1)),']']);
    display_rating(rating_vect);
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function display_rating(rating_vect)
    
    %first sort the rating from hardest to easiest
    [sorted_y, sorting_id] = sort(rating_vect);    
    disp(['Using Borda count method, below is ranking of candidates', char(10),...
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
 
 