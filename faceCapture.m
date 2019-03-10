%创建视频对象
vid = videoinput('winvideo', 1, 'YUY2_160x120');
%设置属性值，持续不断获取图像
vid.FramesPerTrigger = Inf;
%打开摄像头
start(vid);
faceDetector = vision.CascadeObjectDetector; 
count = 0;
while count<30
    frame = getsnapshot(vid);%抓取图像
    I = ycbcr2rgb(frame);%ycbcr是色彩空间的一种，由于我的计算机获取图像是这种格式所以先转换为rgb再转换为gray
    I = rgb2gray(I);
    bboxes = step(faceDetector, I);
    I = imcrop(I,bboxes);
    I = imresize(I,[112,92]);
    imshow(I);
    path = strcat('faceCapture\',num2str(count),'.pgm');
    imwrite(I,path);
    count = count + 1;    
end
stop(vid)