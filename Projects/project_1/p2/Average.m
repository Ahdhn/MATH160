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
%matrix represent the number given by the voter
position_mat = zeros(num_voter, num_candidate);
for n=1:num_candidate    
    candidate_string = getCandidateName(n);
    for m=1:num_candidate
        position_mat(:,n) = position_mat(:,n) + ...
            (num_candidate-m+1)*(rankingcandidates(:,m) == candidate_string);
    end
end
rating_vect = zeros(num_candidate,1);
for n=1:num_candidate
    rating_vect(n) = mean(position_mat(:,n));
end
display_rating(rating_vect);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function display_rating(rating_vect)
    
    %first sort the rating from hardest to easiest
    [sorted_y, sorting_id] = sort(rating_vect);    
    disp(['Using Average rank method, below is ranking of candidates', char(10),...
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

%{
total_DT = 0;
total_BS = 0;
total_TC = 0;
total_JK = 0;
total_HC = 0;

for n = 1:5
    DT = count(rankingcandidates(:,n), "DT");
    score_DT = sum(DT,1)*(6-n);
    total_DT = total_DT + score_DT;
end
avg_DT = total_DT/240;

for n = 1:5
    BS = count(rankingcandidates(:,n), "BS");
    score_BS = sum(BS,1)*(6-n);
    total_BS = total_BS + score_BS;
end
avg_BS = total_BS/240;

for n = 1:5
    TC = count(rankingcandidates(:,n), "TC");
    score_TC = sum(TC,1)*(6-n);
    total_TC = total_TC + score_TC;
end
avg_TC = total_TC/240;

for n = 1:5
    JK = count(rankingcandidates(:,n), "JK");
    score_JK = sum(JK,1)*(6-n);
    total_JK = total_JK + score_JK;
end
avg_JK = total_JK/240;

for n = 1:5
    HC = count(rankingcandidates(:,n), "HC");
    score_HC = sum(HC,1)*(6-n);
    total_HC = total_HC + score_HC;
end
avg_HC = total_HC/240;

fprintf('Donald Trump has an average score of %d.\n',avg_DT)
fprintf('Bernie Sanders has an average score of %d.\n',avg_BS)
fprintf('Ted Cruz has an average score of %d.\n',avg_TC)
fprintf('John Kasich has an average score of %d.\n',avg_JK)
fprintf('Hilary Clinton has an average score of %d.\n',avg_HC)
%}
