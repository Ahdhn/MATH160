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