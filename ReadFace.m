function [faceContainer,label]=ReadFace(n_persons,flag)
%   ORL人脸库。pgm格式的图片。40人，每人10幅图，图像大小为112*92像素。
%   每个人有10幅照片，前5幅当作训练集，后5幅当作测试集
%   当flag为0时，表示输入为训练集，flag为1时，表示输入为测试集
%   n_persons为不同的人脸数
%   label即是数据的标签
%   faceContainer是一个向量化人脸容器，即将每一张图片转成一行向量放入其每行中
I = imread('ORL\s1\1.pgm');
[M,N] = size(I);

label=zeros(n_persons*5,1);
faceContainer=zeros(n_persons*5,M*N);
for i=1:n_persons
    %路径设置
    %函数num2str(i)说明：将数字转化为字符
    facepath=strcat('ORL\s',num2str(i),'\');  %路径因不同情况而定
    temppath=facepath;
    for j=1:5
        facepath=temppath;
        if flag==0      
            facepath=strcat(facepath,num2str(j));
        else
            facepath=strcat(facepath,num2str(j+5));
        end
        label((i-1)*5+j)=i;
        facepath=strcat(facepath,'.pgm');    
        img=imread(facepath);
        faceContainer((i-1)*5+j,:)=img(:)';
    end
end
save('ORL\faceContainer','faceContainer');