W = [5 4 3 2 1]';
rank_DT = zeros(1,5);
rank_BS = zeros(1,5);
rank_TC = zeros(1,5);
rank_JK = zeros(1,5);
rank_HC = zeros(1,5);
for n = 1:5
    DT = count(rankingcandidates(:,n), "DT");
    rank_DT(1,n) = sum(DT,1);
    
    BS = count(rankingcandidates(:,n), "BS");
    rank_BS(1,n) = sum(BS,1);
    
    TC = count(rankingcandidates(:,n), "TC");
    rank_TC(1,n) = sum(TC,1);
    
    JK = count(rankingcandidates(:,n), "JK");
    rank_JK(1,n) = sum(JK,1);
    
    HC = count(rankingcandidates(:,n), "HC");
    rank_HC(1,n) = sum(HC,1);
end
rank_DT
rank_BS
rank_TC
rank_JK
rank_HC

score_DT = rank_DT * W
score_BS = rank_BS * W
score_TC = rank_TC * W
score_JK = rank_JK * W
score_HC = rank_HC * W



 
 
 