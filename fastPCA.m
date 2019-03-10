%A为样本矩阵，将其降至k维后的矩阵为pcaA,V为主成分分量
function [pcaA ,V]=fastPCA(A,k)

[m,n]=size(A);
%样本均值,计算各列的均值
meanVec=mean(A); 
 
%计算协方差矩阵的转置 covMatT
%样本矩阵中心化，每一维度减去该维度的均值，使得每一维度的均值为0
%repmat:Replicate Matrix复制和平铺矩阵
Z= ( A-repmat(meanVec,m,1)  );  
                                
covMatT =Z*Z'; %快速PCA
%计算covMatT的前k个特征值和特征向量
[V, ~]=eigs(covMatT,k);  %V为m*k, k个特征向量
 
%得到协方差矩阵(covMatT')的特征向量
V=Z'*V;
 
%特征向量归一化为得到单位特征向量
for i=1:k
    V(:,i)=V(:,i)/norm(V(:,i));  %norm 为范数，默认为2范数(各分量的平方和 再开根号)
end
 
%投影降维至k维
pcaA=Z*V;
 
%保存变换矩阵V和平均矩阵meanVec
save('ORL/PCA.mat','V','meanVec');
