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


HC = sum(count(rankingcandidates(:,1), "HC"));
BS = sum(count(rankingcandidates(:,1), "BS"));
JK = sum(count(rankingcandidates(:,1), "JK"));
TC = sum(count(rankingcandidates(:,1), "TC"));
DT = sum(count(rankingcandidates(:,1), "DT"));
display_rating([HC,BS,JK,TC,DT]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function display_rating(rating_vect)
    
    %first sort the rating from hardest to easiest
    [sorted_y, sorting_id] = sort(rating_vect);    
    disp(['Using Plurality method, below is ranking of candidates', char(10),...
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