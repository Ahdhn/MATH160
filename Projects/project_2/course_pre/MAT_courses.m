clc;
clear;
clf;
close all;
%read all courses 
coursesArray = readtable('all_courses.txt');
coursesArray_str = table2array(coursesArray);


%consturct the prereq directed graph 
gCourse = constructGraph('PrereqUpdated.txt', coursesArray_str);

%plot(gCourse, 'NodeColor','r','Layout','layered');
%axis off;

drawgraph(gCourse);

must = getNumerical(gCourse, ["MAT21A","MAT21B","MAT21C","MAT21D","MAT22B",...
                          "MAT25","MAT127A","MAT127B","MAT127C","MAT135A","MAT150A","MAT111",...
                          "MAT115A","MAT141"]);

op3 = getNumerical(gCourse, ["MAT108" , "MAT114", "MAT115A", "MAT141", "MAT145"]);
op4 = getNumerical(gCourse,["MAT189", "MAT180"]);
op5 = getNumerical(gCourse,["MAT114", "MAT115A","MAT115B","MAT116","MAT118A",...
    "MAT118B","MAT118C","MAT119A","MAT119B","MAT124","MAT127A","MAT127B",...
    "MAT127C","MAT128A","MAT128B","MAT128C","MAT129","MAT133","MAT135B",...
    "MAT145","MAT146","MAT147","MAT148","MAT150B","MAT150C","MAT160",...
    "MAT165","MAT167","MAT168","MAT185A","MAT185B"]);


numCourses = gCourse.numnodes;
numQuarters = 20;%four years 
x = zeros(numCourses,numQuarters);%binary, if course i will be taken in quarter j
sumConstraints = 1;
for i=1:numCourses
    %if there is only one course A pointing to course B    
    %then y_B >= y_A +1    
    %list of course pointing to i
    courseName = gCourse.Nodes.Name(i);
    pre = predecessors(gCourse,courseName);
    for j=1:length(pre)
        edge = findedge(gCourse,pre(j),courseName);
        if gCourse.Edges.Weight(edge) == 1 
            %means that course pre(j) must be taken before course i            
            disp([num2str(i),'  ',num2str(findnode(gCourse,pre(j)))]);
            %disp([courseName,'  ',pre(j)]);
        end
    end    
end

ss = [
13	,1;
14	,1;
15	,1;
54	,1;
28	,2;
46	,2;
47	,2;
53	,2;
10	,3;
11	,3;
23	,3;
5	,4;
6	,4;
12	,4;
7	,5;
8	,5;
9	,5;
3	,6;
21	,6;
44	,6;
51	,6;
1	,7;
2	,7;
4	,7;
16	,8;
40	,8;
42	,8;
24	,9;
38	,9;
39	,9;
37	,10;
43	,10;];

getName(gCourse, ss(:,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function numeric = getNumerical(gCourse, list)
    numeric = zeros(1,length(list));
    for i=1:length(list)
       numeric(i) = findnode(gCourse, char(list(i))); 
    end
end
function name = getName(gCourse, list)
    
    for i=1:length(list)       
       char(gCourse.Nodes.Name(list(i)))
    end
end

