%基于主成分分量的人脸重建，k为重建至多少维
function rebuid(y,k)
load ORL/PCA.mat%导入平均矩阵meanVec和主成分向量V
temp = meanVec;
for i = 1:k    
    xi = (y - meanVec) * V(:,i);%某人脸y在第i维的投影值
    yi =  xi * V(:,i)';%某人脸y在第i维的向量值
    temp = temp + yi ;%对该人脸投影到所有维的向量进行一个矢量相加，得到该人脸向量的一个近似值
end
%显示重建人脸
I = zeros(112,92);
I(:) = temp';
imshow(I,[]);
