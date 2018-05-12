function gCourse = constructGraph(fileName, coursesArray_str)

    %initialize the empty graph with all nodes and their labels
    gCourse = digraph(zeros(size(coursesArray_str,1)),coursesArray_str);
    
    %read prerequisites data to populate gCourse graph
    preData = importdata(fileName);
    
    
    %[1] query the numeric values of the node of name X where X is string
    %k = findnode(gCourse,X);
    %[2] query number of nodes in the graph
    %nNodes = numnodes(gCourse);
    %[3] plot the graph
    %plot(gCourse);
    %[4] add nodes by their ID (string)
    %gCourse = addnode(gCourse, nodeID);


    for d=1:size(preData,1)
        %for each line in the file
        %break in into pieces
        line_data = strsplit(preData{d});
        %first entry in line_data is a course for which we are reading the
        %prerequisites
        nodeA = line_data{1};
        if length(line_data) ==2
            nodeB = line_data(2);
            gCourse = addedge(gCourse, nodeB, nodeA,1);
        else
        %{
        for l = 2:length(line_data)
            %parse the rest of the line to find either
            %|
            %+
            %{% for grouping courses with + or |
            %}%
            %another course
            if line_data(l) == '{'
                %if you find a group, keep reading until the group is all read
                while(true)
                    l = l+1;
                    
                    if line_data(l) == '}'
                        %end of group
                        break;
                    end
                    
                end
                
            elseif line_data(l) == '}'
                %do nothing
                
            elseif line_data(l) == '|'
                
            elseif line_data(l) == '+'
                
            elseif line_data(l) == ')'
                
            elseif line_data(l) == '('
                
            else
                %it is a course
                
                
            end
            
        end
        %}
        end
    end
    
    %MAT21CH
    gCourse = addedge(gCourse, 'MAT21B','MAT21CH',double(0.5));
    gCourse = addedge(gCourse,'MAT21BH','MAT21CH',double(0.5));
    
    %MAT21BH
    gCourse = addedge(gCourse, 'MAT21A','MAT21BH',1.0/2.0);
    gCourse = addedge(gCourse,'MAT21AH','MAT21BH',1.0/2.0);
         
       
    %new node MAT22A | MAT 67
    gCourse = addnode(gCourse, 'MAT22A|MAT67');
    gCourse = addedge(gCourse,'MAT22A','MAT22A|MAT67',1.0/2.0);
    gCourse = addedge(gCourse,'MAT67','MAT22A|MAT67',1.0/2.0);
    
    %MAT167
    gCourse = addedge(gCourse, 'MAT22A|MAT67','MAT167',1.0);
        
    %MAT22B
    gCourse = addedge(gCourse,'MAT22A|MAT67','MAT22B',1.0);
    
    
    %MAT114
    gCourse = addedge(gCourse,'MAT22A|MAT67','MAT114',1.0);
    gCourse = addedge(gCourse,'MAT21C','MAT114',1.0);
    
    %MAT124
    gCourse = addedge(gCourse,'MAT22A|MAT67','MAT124',1.0);
    gCourse = addedge(gCourse,'MAT22B','MAT124',1.0);
    
    %MAT128B
    gCourse = addedge(gCourse,'MAT22A|MAT67','MAT128B',1.0);
    gCourse = addedge(gCourse,'MAT21C','MAT128B',1.0);
    
    %MAT128C
    gCourse = addedge(gCourse,'MAT22A|MAT67','MAT128C',1.0);
    gCourse = addedge(gCourse,'MAT22B','MAT128C',1.0);
    
    %MAT135A
    gCourse = addedge(gCourse,'MAT22A|MAT67','MAT135A',1.0);
    gCourse = addedge(gCourse,'MAT21C','MAT135A',1.0);
    
    %MAT135B
    gCourse = addedge(gCourse,'MAT22A|MAT67','MAT135B',1.0);
    gCourse = addedge(gCourse,'MAT135A','MAT135B',1.0);
    
    %MAT141
    gCourse = addedge(gCourse,'MAT22A|MAT67','MAT141',1.0);
    gCourse = addedge(gCourse,'MAT22B','MAT141',1.0);
    
    %MAT115B
    gCourse = addedge(gCourse,'MAT22A|MAT67','MAT115B',1.0);
    gCourse = addedge(gCourse,'MAT115A','MAT115B',1.0);
    
    %MAT116
    gCourse = addedge(gCourse,'MAT22A|MAT67','MAT116',1.0);
    gCourse = addedge(gCourse,'MAT21D','MAT116',1.0);
    gCourse = addedge(gCourse,'MAT22B','MAT116',1.0);
    
    %MAT118A
    gCourse = addedge(gCourse,'MAT22A|MAT67','MAT118A',1.0);
    gCourse = addedge(gCourse,'MAT21D','MAT118A',1.0);
    gCourse = addedge(gCourse,'MAT22B','MAT118A',1.0);
    
    %MAT119A
    gCourse = addedge(gCourse,'MAT22A|MAT67','MAT119A',1.0);
    gCourse = addedge(gCourse,'MAT21D','MAT119A',1.0);
    gCourse = addedge(gCourse,'MAT22B','MAT119A',1.0);
    
    %MAT129
    gCourse = addedge(gCourse,'MAT22A|MAT67','MAT129',1.0);
    gCourse = addedge(gCourse,'MAT21D','MAT129',1.0);
    gCourse = addedge(gCourse,'MAT22B','MAT129',1.0);
    gCourse = addedge(gCourse,'MAT25','MAT129',1.0);   

    %new node MAT22A + MAT108
    gCourse = addnode(gCourse, 'MAT22A+MAT108');
    gCourse = addedge(gCourse, 'MAT22A', 'MAT22A+MAT108',1.0);
    gCourse = addedge(gCourse, 'MAT108', 'MAT22A+MAT108',1.0);
    
    %new node MAT67|{MAT22A+MAT108}
    gCourse = addnode(gCourse, 'MAT67|MAT22A+MAT108');
    gCourse = addedge(gCourse, 'MAT67', 'MAT67|MAT22A+MAT108',1.0/2.0);
    gCourse = addedge(gCourse, 'MAT22A+MAT108', 'MAT67|MAT22A+MAT108',1.0/2.0);
    
    %MAT148
    gCourse = addedge(gCourse,'MAT67|MAT22A+MAT108','MAT148',1.0);
    
    %MAT150A
    gCourse = addedge(gCourse,'MAT67|MAT22A+MAT108','MAT150A',1.0);
    
    
    %MAT146  
    gCourse = addedge(gCourse,'MAT67|MAT22A+MAT108','MAT146',1.0);
    gCourse = addedge(gCourse,'MAT145','MAT146',1.0);
    
    %MAT180
    gCourse = addedge(gCourse,'MAT67|MAT22A+MAT108','MAT180',1.0);
    gCourse = addedge(gCourse,'MAT25','MAT180',1.0);
    
    %MAT185A
    gCourse = addedge(gCourse,'MAT67|MAT22A+MAT108','MAT185A',1.0);
    gCourse = addedge(gCourse,'MAT127A','MAT185A',1.0);
    
    %MAT189
    gCourse = addedge(gCourse,'MAT67|MAT22A+MAT108','MAT189',1.0);
    gCourse = addedge(gCourse,'MAT25','MAT189',1.0);
    
    %MAT168
    gCourse = addedge(gCourse,'MAT67|MAT22A+MAT108','MAT168',1.0);
    gCourse = addedge(gCourse,'MAT21C','MAT168',1.0);
    
    %MAT133
    gCourse = addedge(gCourse,'MAT67|MAT22A+MAT108','MAT133',1.0);
    gCourse = addedge(gCourse,'MAT135A','MAT133',1.0);
    
    %new node MAT21C  | MAT21CH
    gCourse = addnode(gCourse, 'MAT21C|MAT21CH');
    gCourse = addedge(gCourse, 'MAT21C', 'MAT21C|MAT21CH',1.0/2.0);
    gCourse = addedge(gCourse, 'MAT21CH', 'MAT21C|MAT21CH',1.0/2.0);
    
    %MAT127A
    gCourse = addedge(gCourse,'MAT67|MAT22A+MAT108','MAT127A',1.0);
    gCourse = addedge(gCourse,'MAT21C|MAT21CH','MAT127A',1.0);
    
    
    %new node MAT25 | MAT108 | MAT114 | MAT115A | MAT 145
    gCourse = addnode(gCourse, 'MAT25|MAT108|MAT114|MAT115A|MAT145');
    gCourse = addedge(gCourse, 'MAT25', 'MAT25|MAT108|MAT114|MAT115A|MAT145', 1.0/5.0);
    gCourse = addedge(gCourse, 'MAT108', 'MAT25|MAT108|MAT114|MAT115A|MAT145', 1.0/5.0);
    gCourse = addedge(gCourse, 'MAT114', 'MAT25|MAT108|MAT114|MAT115A|MAT145', 1.0/5.0);
    gCourse = addedge(gCourse, 'MAT115A', 'MAT25|MAT108|MAT114|MAT115A|MAT145', 1.0/5.0);
    gCourse = addedge(gCourse, 'MAT145', 'MAT25|MAT108|MAT114|MAT115A|MAT145', 1.0/5.0);
    
    %MAT165 
    gCourse = addedge(gCourse,'MAT22A|MAT67','MAT165',1.0);
    gCourse = addedge(gCourse, 'MAT25|MAT108|MAT114|MAT115A|MAT145', 'MAT165',1.0);
    
    %MAT111   
    gCourse = addedge(gCourse,'MAT25|MAT108|MAT114|MAT115A|MAT145','MAT111',1.0/8.0);
    gCourse = addedge(gCourse,'MAT127A','MAT111',1.0/8.0);
    gCourse = addedge(gCourse,'MAT67','MAT111',1.0/8.0);
    gCourse = addedge(gCourse,'MAT141','MAT111',1.0/8.0);    
end