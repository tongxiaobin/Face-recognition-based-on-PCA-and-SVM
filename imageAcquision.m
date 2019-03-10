%创建视频对象
vid = videoinput('winvideo', 1, 'YUY2_160x120');
%设置属性值，持续不断获取图像
vid.FramesPerTrigger = Inf;
%打开摄像头
start(vid);

[faceContainer,label]=ReadFace(41,0);
[pcaA ,V]=fastPCA(faceContainer,20);
[ scaledface] = scaling( pcaA,-1,1 ); 
model = svmtrain(label,scaledface,'-t 0 ');
load ORL\PCA.mat
container = zeros(1,112*92);%一定要和训练时一样先初始化定义个人脸容器，使其数据类型一样，而不能直接转化成double型
faceDetector = vision.CascadeObjectDetector; 
while 1
    frame = getsnapshot(vid);%抓取图像
    I = ycbcr2rgb(frame);%ycbcr是色彩空间的一种，由于我的计算机获取图像是这种格式所以先转换为rgb再转换为gray
    I = rgb2gray(I);
    bboxes = step(faceDetector, I);%获得人脸区域
    [m,n] = size(bboxes);
    if(m>0)
        crop = imcrop(I,bboxes);%扣出人脸图像
        crop_normalize = imresize(crop,[112,92]);%重新定义尺寸，即尺寸归一化
        container(1,:) = crop_normalize(:)';%变成行向量
        faceData = (container - meanVec)*V;%在训练数据的特征向量中降维
        faceData = testscaling( faceData,-1,1 );%归一化
        [predict_label,accuracy,prob_estimates]=svmpredict(41,faceData,model);%预测
        if predict_label == 41 
            exp_face = imresize(crop_normalize,[224,184]); 
            imshow(exp_face);
            hold on;
            text(92,15,'童小彬','horiz','center','FontSize',15,'color','g'); 
        else
            exp_face = imresize(crop_normalize,[224,184]);
            imshow(exp_face);
            hold on;
            text(92,15,'识别错误','horiz','center','FontSize',15,'color','g');   
        end         
    end
    if strcmp(get(gcf,'SelectionType'),'alt')%右键鼠标事件
            break;
    end 
end
stop(vid);
