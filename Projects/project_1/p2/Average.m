total_DT = 0;
total_BS = 0;
total_TC = 0;
total_JK = 0;
total_HC = 0;

for n = 1:5
    DT = count(rankingcandidates(:,n), "DT");
    score_DT = sum(DT,1)*(6-n);
    total_DT = total_DT + score_DT;
end
avg_DT = total_DT/240;

for n = 1:5
    BS = count(rankingcandidates(:,n), "BS");
    score_BS = sum(BS,1)*(6-n);
    total_BS = total_BS + score_BS;
end
avg_BS = total_BS/240;

for n = 1:5
    TC = count(rankingcandidates(:,n), "TC");
    score_TC = sum(TC,1)*(6-n);
    total_TC = total_TC + score_TC;
end
avg_TC = total_TC/240;

for n = 1:5
    JK = count(rankingcandidates(:,n), "JK");
    score_JK = sum(JK,1)*(6-n);
    total_JK = total_JK + score_JK;
end
avg_JK = total_JK/240;

for n = 1:5
    HC = count(rankingcandidates(:,n), "HC");
    score_HC = sum(HC,1)*(6-n);
    total_HC = total_HC + score_HC;
end
avg_HC = total_HC/240;

fprintf('Donald Trump has an average score of %d.\n',avg_DT)
fprintf('Bernie Sanders has an average score of %d.\n',avg_BS)
fprintf('Ted Cruz has an average score of %d.\n',avg_TC)
fprintf('John Kasich has an average score of %d.\n',avg_JK)
fprintf('Hilary Clinton has an average score of %d.\n',avg_HC)
