function visualize(V)  
%显示特征脸（变换空间中的基向量，即单位特征向量）  
figure  
img=zeros(112,92);  
for i=1:20  
    img(:)=V(:,i);  
    subplot(4,5,i);  
    imshow(img,[])  
end  
