I = imread('ORL\orl_faces\s3\1.pgm');
a = zeros(1,112*92);
a(1,:) = I(:)';
% I = I(:)';
load ORL\scaling.mat
I = (a-meanVec)*V;
data = ((I - lowVec )./( upVec- lowVec)*2) - 1;
[predict_label,accuracy,prob_estimates]=svmpredict(1,data,model);