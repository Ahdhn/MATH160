total_DT = 0;
total_BS = 0;
total_TC = 0;
total_JK = 0;
total_HC = 0;

for n = 1:5
    DT = count(rankingcandidates(:,n), "DT");
    score_DT = sum(DT,1)*(5-n);
    total_DT = total_DT + score_DT;
end

for n = 1:5
    BS = count(rankingcandidates(:,n), "BS");
    score_BS = sum(BS,1)*(5-n);
    total_BS = total_BS + score_BS;
end

for n = 1:5
    TC = count(rankingcandidates(:,n), "TC");
    score_TC = sum(TC,1)*(5-n);
    total_TC = total_TC + score_TC;
end

for n = 1:5
    JK = count(rankingcandidates(:,n), "JK");
    score_JK = sum(JK,1)*(5-n);
    total_JK = total_JK + score_JK;
end

for n = 1:5
    HC = count(rankingcandidates(:,n), "HC");
    score_HC = sum(HC,1)*(5-n);
    total_HC = total_HC + score_HC;
end

fprintf('Donald Trump has a Borda score of %d.\n',total_DT)
fprintf('Bernie Sanders has a Borda score of %d.\n',total_BS)
fprintf('Ted Cruz has a Borda score of %d.\n',total_TC)
fprintf('John Kasich has a Borda score of %d.\n',total_JK)
fprintf('Hilary Clinton has a Borda score of %d.\n',total_HC)

