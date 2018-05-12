clc;
clear;

for FILE=1:3
   %read files 
    solArray = dlmread(['sudo',num2str(FILE),'_sol.txt'],'#',0,1);
    [rowSol,colSol] = size(solArray);
    inputArray = dlmread(['sudo',num2str(FILE),'.txt']);
    [rowInput,colInput] = size(inputArray);
    
    
    %draw main big window
    figure(FILE);
    main_win = fill([1; 10; 10; 1],[1;1;10;10],[1 1 1]);
    set(main_win,'LineWidth',3);
    hold on;
    
    %draw our solution in white     
    for i=1:rowSol
        fill([solArray(i,2);solArray(i,2)+1;solArray(i,2)+1;solArray(i,2)],...
            [solArray(i,1);solArray(i,1);solArray(i,1)+1;solArray(i,1)+1],...
            [1 1 1]);
        hold on;
        text(solArray(i,2)+0.5,solArray(i,1)+0.5,int2str(solArray(i,3)));
    end
    
    %draw the input in gray
    for i=1:rowInput
        fill([inputArray(i,2);inputArray(i,2)+1;inputArray(i,2)+1;inputArray(i,2)],...
            [inputArray(i,1);inputArray(i,1);inputArray(i,1)+1;inputArray(i,1)+1],...
            0.8*[1 1 1]);
        text(inputArray(i,2)+0.5,inputArray(i,1)+0.5,int2str(inputArray(i,3)));
    end
    
    %draw thick lines around the partitions 
    for i=[1,4,7]
        for j=[1,4,7]
            small_win = fill([j;j+3;j+3;j],[i; i; i+3; i+3],[1 1 1]);
            hold on;
            set(small_win,'LineWidth',1.5);
            set(small_win,'facealpha',0)
            hold on;
        end
    end
    hold off;
    %remove axis
    axis([0 10 0 10]);
    axis equal;
    axis off;
    title(['Solution of SUDOKU Number ', num2str(FILE)]);
    

end