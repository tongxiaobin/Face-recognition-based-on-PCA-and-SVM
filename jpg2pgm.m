%改变图像尺寸和格式并保存
temp = 'C:\Users\Administrator\Desktop\';
for i = 1:10
    path1 = strcat(temp,num2str(i),'.jpg');
    I = imread(path1);
    I = rgb2gray(I);
    I = imresize(I,[112,92]);%改变图像尺寸
    path2 = strcat('D:\',num2str(i),'.pgm');
    imwrite(I,path2);  %保存成pgm格式
end