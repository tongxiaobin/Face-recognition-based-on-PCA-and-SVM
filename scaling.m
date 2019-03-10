function [ scaledface] = scaling( faceMat,lTargB,uTargB )  
%特征数据规范化 ，因为因为对于不同的属性，如果不归一化是不具有比较性的，两者不在一个量级上
%faceMat需要进行规范化的图像数据，  
[m,n]=size(faceMat);  
scaledface=zeros(m,n); 
upVec=zeros(1,n);  %行向量
lowVec=zeros(1,n);

 for i=1:n
     lowVec(i)=min( faceMat(:,i) );
     upVec(i)=max( faceMat(:,i) );   
     scaledface(:,i)=(faceMat(:,i) - lowVec(i) )/( upVec(i)- lowVec(i))*(uTargB-lTargB)+lTargB;   
 end
 save('ORL/scaling.mat','upVec','lowVec');


