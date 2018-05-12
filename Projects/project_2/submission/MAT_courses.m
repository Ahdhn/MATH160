clc;
clear;
clf;
close all;
%read all courses 
coursesArray = readtable('all_courses.txt');
coursesArray_str = table2array(coursesArray);


%consturct the prereq directed graph 
gCourse = constructGraph('PrereqUpdated.txt', coursesArray_str);

drawgraph(gCourse);

% must = getNumerical(gCourse, ["MAT21A","MAT21B","MAT21C","MAT21D","MAT22B",...
%                           "MAT25","MAT127A","MAT127B","MAT127C","MAT135A","MAT150A","MAT111",...
%                           "MAT115A","MAT141"]);
% 
% op3 = getNumerical(gCourse, ["MAT108" , "MAT114", "MAT115A", "MAT141", "MAT145"]);
% op4 = getNumerical(gCourse,["MAT189", "MAT180"]);
% op5 = getNumerical(gCourse,["MAT114", "MAT115A","MAT115B","MAT116","MAT118A",...
%     "MAT118B","MAT118C","MAT119A","MAT119B","MAT124","MAT127A","MAT127B",...
%     "MAT127C","MAT128A","MAT128B","MAT128C","MAT129","MAT133","MAT135B",...
%     "MAT145","MAT146","MAT147","MAT148","MAT150B","MAT150C","MAT160",...
%     "MAT165","MAT167","MAT168","MAT185A","MAT185B"]);


% numCourses = gCourse.numnodes;
% numQuarters = 20;%four years 
% x = zeros(numCourses,numQuarters);%binary, if course i will be taken in quarter j
% sumConstraints = 1;
% for i=1:numCourses
%     %if there is only one course A pointing to course B    
%     %then y_B >= y_A +1    
%     %list of course pointing to i
%     courseName = gCourse.Nodes.Name(i);
%     pre = predecessors(gCourse,courseName);
%     for j=1:length(pre)
%         edge = findedge(gCourse,pre(j),courseName);
%         if gCourse.Edges.Weight(edge) == 1 
%             %means that course pre(j) must be taken before course i            
%             disp([num2str(i),'  ',num2str(findnode(gCourse,pre(j)))]);
%             %disp([courseName,'  ',pre(j)]);
%         end
%     end    
% end

%ss = [13 14 15 54 28 46 47 53 9 11 12 3 6 8 5 7 21 10 23 43 51 1 2 4 16 42 45 24 40 44 37 38 39];

%getName(gCourse, ss);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function numeric = getNumerical(gCourse, list)
    numeric = zeros(1,length(list));
    for i=1:length(list)
       numeric(i) = findnode(gCourse, char(list(i))); 
    end
end
function name = getName(gCourse, list)
    
    for i=1:length(list)       
       disp(char(gCourse.Nodes.Name(list(i))))
    end
end

