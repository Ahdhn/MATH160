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

disp([' minimal cost of alignment = ', mat2str(score_mat(end,end))]);

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