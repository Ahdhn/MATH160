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

DT = count(rankingcandidates(:,1), "DT");
a = sum(DT,1);
fprintf('Donald Trump has %d votes.\n',a) 

BS = count(rankingcandidates(:,1), "BS");
b = sum(BS,1);
fprintf('Bernie Sanders has %d votes.\n',b)

TC = count(rankingcandidates(:,1), "TC");
c = sum(TC,1);
fprintf('Ted Cruz has %d votes.\n',c)

JK = count(rankingcandidates(:,1), "JK");
d = sum(JK,1);
fprintf('John Kasich has %d votes.\n',d)

HC = count(rankingcandidates(:,1), "HC");
e = sum(HC,1);
fprintf('Hilary Clinton has %d votes.\n',e)