clc;
clear;
clf;

%load the students scores
exam_mat = importdata('examscores.dat',',');
% exam_mat = [
%     5 4 3 2 1;
%     5 4 3 2 1;
%     4 5 3 1 2;
%     2 5 1 3 4;
%     3 5 2 1 4;
%     4 5 2 1 3;
%     1 5 3 4 2;
%     5 4 3 1 2;
%     4 5 2 3 1;
%     4 5 2 1 3;
%     ];
%compute the number of student and exams 
[num_student, num_exams] = size(exam_mat); 

%%%%%%%%%%%%%%% Massey Method
%get massey matrix (last row is all-ones)
massey_mat = (-num_student).*ones(num_exams);
massey_mat(logical(eye(num_exams)))=((num_exams-1)*num_student);
colley_mat = massey_mat + 2.0.*eye(num_exams);

%compute the matrix of score differentials 
diff_mat = zeros(num_student, num_exams);
for id_i = 1:num_exams
    for id_j = 1:num_exams       
        diff_mat(:,id_i) = diff_mat(:,id_i) + exam_mat(:,id_i) - exam_mat(:,id_j);    
    end
end

%check each row sum to zero
for id_i = 1:num_student
    if sum(diff_mat(id_i,:)) ~=0
        warning(['row', num2str(id_i) ,'in diff_mat does not sum to zero']);
    end
end

%compute the score differentail vector for the matrix 
diff_vector = sum(diff_mat,1)';


%modify massey matrix (to be full rank) and diff vector  
massey_mat(end,:) = ones(1,num_exams);
diff_vector(end) = 0;

%solve the equations 
y = massey_mat\diff_vector;

%sort the rating from hardest to easiest
display_rating(1,y);


%%%%%%%%%%%%%%% Colley Method
%compute colley b vector
win = zeros(num_student,num_exams);
loss = zeros(num_student,num_exams);
for id_i = 1:num_exams
    for id_j = 1:num_exams   
        if id_i == id_j 
            continue;
        end
        win(:,id_i) = win(:,id_i) +...
            double(exam_mat(:,id_i) > exam_mat(:,id_j))+ ...
            +0.5*double(exam_mat(:,id_i) == exam_mat(:,id_j));
        
        loss(:,id_i) = loss(:,id_i) +...
            double(exam_mat(:,id_i) < exam_mat(:,id_j)) + ...
            +0.5*double(exam_mat(:,id_i) == exam_mat(:,id_j));
    end
end


%check each row sum to zero
for id_i = 1:num_exams
    if sum(win(:,id_i))+sum(loss(:,id_i)) ~= (num_exams-1)*num_student
        warning(['row', num2str(id_i) ,'in mat_w and mat_l does not sum up right']);
    end
end

win  = sum(win,1);
loss = sum(loss,1);

%compute b vector (the RHS of colley system of equations)
b = zeros(num_exams,1);
for id_i = 1:num_exams
    b(id_i) = 1.0 + ((win(id_i)-loss(id_i))/2.0);
end  

C = colley_mat\b;
display_rating(2,C);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function display_rating(method, rating_vect)
    
    %first sort the rating from hardest to easiest
    [sorted_y, sorting_id] = sort(rating_vect);
    if method ==1
        disp(['Using Massey network method, below is the questions', char(10),...
        '   sorted from most difficult to easier (with rating): ']);        
    else
        disp(['Using Colley method, below is the questions', char(10),...
        '   sorted from most difficult to easier (with rating): ']);
    end
    
    num_exams = length(rating_vect);
    
    for k=1:num_exams
        for l=1:num_exams
            if sorting_id(l)== k
                break;
            end
        end
        disp([' Q. ',num2str(l) , ' (',num2str(rating_vect(l)) ,')' ]);
    end
end
