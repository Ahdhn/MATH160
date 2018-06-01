clc;
clear;
clf;
close all;

gap =2;
match =0;
mismatch =1;

fid = fopen('dna.txt');
txt = textscan(fid,'%s','delimiter','\n');

inputSeq = cell2mat(txt{1});

score_mat = sequence_align(inputSeq(1,:),inputSeq(2,:),2,0,1);

%plotMat(score_mat,inputSeq);

disp([' minimal cost of alignment (minCost) = ', mat2str(score_mat(end,end))]);
disp([' the length of the sequence (Len)= ', mat2str(length(inputSeq(1,:)))]);
r = 100.0*score_mat(end,end)/length(inputSeq(1,:));
disp([' minCost/Len = ', mat2str(r), '%']);

function [score_mat]= sequence_align(seq1, seq2, gap, match, mismatch)
    
    n = length(seq1);
    m = length(seq2);
    
    score_mat = zeros(n+1,m+1);
    score_mat(2:n+1,1) = gap.*[1:n];
    score_mat(1,2:m+1) = gap.*[1:m];
    
    for I = 2:n+1%index in score_mat
        index_i = I-1; %index in seq1
        for J = 2:n+1%index in score_mat
            index_j = J-1; %index in seq2
            
            up =score_mat(I,J-1) + gap;
            dia = score_mat(I-1,J-1) + score(seq1(index_i),...
                seq2(index_j),match, mismatch);
            left = score_mat(I-1,J) + gap;
            
            score_mat(I,J) = min(up,dia);
            score_mat(I,J) = min(score_mat(I,J),left);
        end
        
    end
    
end

function sc = score(i,j, match,mismatch)

    if i==j
        sc = match;
    else
        sc= mismatch;
    end
end
function plotMat(myScoreMat, inputSeq)
    [nRow,nCol] = size(myScoreMat);
    
    imagesc(myScoreMat);%create a colored plot of the matrix value 
    colormap(flipud(gray));%gray colormap 
    textStrings = num2str(myScoreMat(:));%create string of the numbers 
    textStrings = strtrim(cellstr(textStrings));%remove any space padding 
    [x,y] = meshgrid(1:nCol);%create x,y coordinates for the strings 
    
    hStrings = text(x(:),y(:), textStrings(:),'HorizontalAlignment', 'center');%plot the string    
    midValue = mean (get(gca,'CLim')); %get the middel value of the color range     
    textColors = repmat(myScoreMat(:) > midValue, 1,3); %change the text color appropraitely 
    set(hStrings, {'Color'}, num2cell(textColors,2));    
    
    XLabel = split(inputSeq(1,:),'');
    YLabel = split(inputSeq(2,:),'');
    set(gca, 'XTick', 1:nCol,'YTick', 1:nCol,...
              'XTickLabel', XLabel,...
              'YTickLabel', YLabel,...
              'xaxisLocation','top');
    
end
