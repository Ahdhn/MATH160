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
%get massey matrix (last row is all-ones)
massey_mat = (-num_student).*ones(num_exams);
massey_mat(logical(eye(num_exams)))=((num_exams-1)*num_student);

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

%sort the rating from hardest to easiet
[sorted_y, sorting_id] = sort(y);

disp(['Using Massey network method, below is the questions', char(10),...
    '   sorted from most difficult to easier (with rating): ']);
for k=1:num_exams
    for l=1:num_exams
        if sorting_id(l)== k
            break;
        end
    end
    disp([' Q. ',num2str(l) , ' (',num2str(y(l)) ,')' ]);
end

