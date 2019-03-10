faceDetector = vision.CascadeObjectDetector; 
for i=1:165
    facepath=strcat('yalefaces','\','(',num2str(i),')','.gif');
    img=imread(facepath);
    bboxes = step(faceDetector, img); 
    img_roi=imcrop(img,bboxes);%提取感兴趣区域ROI
    B = imresize(img_roi,[112,92]);
    face2path=strcat('yalefaces_face','\','(',num2str(i),')','.pgm'); 
    imwrite(B,face2path);       
end