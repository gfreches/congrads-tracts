function  tract_projection(test,area,tracts)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
tractsFolder_test  = strcat("/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/Gradient_Averages/",test,"/",area,"/tracts/");
tractsFolder_test_white_matter  = strcat("/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/Gradient_Averages/",test,"/");
files = zeros(1,length(tracts)*2);
files = string(files);
i=1;
k=1;
project_white = readimgfile(char(strcat(tractsFolder_test_white_matter,"wm_mask.nii.gz")));
project_white = reshape(project_white,[],44);
project_white = cat(2,project_white(:,1:3),project_white(:,6:end));
while i<=length(tracts)
    files(k)=strcat(tractsFolder_test,tracts(i),"g3.nii.gz");
    files(k+1)=strcat(tractsFolder_test,tracts(i),"g1.nii.gz");
    i=i+1;
    k=k+2;
end
tract_array = zeros(length(files),3658350,42);
for r=1:length(files)
    res = readimgfile(char(files(r)));
    tract_array(r,:,:)=reshape(res,[],42).*project_white;
end
tract_array_means = zeros(length(files),44);
for o=1:length(files)
    for subj=1:42
        tract_array_means(o,subj)=mean(nonzeros(tract_array(o,:,subj)));
    end
end
tract_array_means(isnan(tract_array_means))=0;
x_pos = zeros(1,length(tracts));
y_pos = zeros(1,length(tracts));
x_err_pos = zeros(1,length(tracts));
x_err_neg = zeros(1,length(tracts));
y_err_pos = zeros(1,length(tracts));
y_err_neg = zeros(1,length(tracts));
aux = 1;
for tract=1:length(tracts)
    x_pos(tract)=mean(tract_array_means(aux,:));
    x_err = bootci(10000,@mean,tract_array_means(aux,:));
    x_err_pos(tract) = abs(x_err(2)-x_pos(tract));
    x_err_neg(tract) = abs(x_err(1)-x_pos(tract));
    y_pos(tract)=mean(tract_array_means(aux+1,:));
    y_err = bootci(10000,@mean,tract_array_means(aux+1,:));
    y_err_pos(tract) = abs(y_err(2)-y_pos(tract));
    y_err_neg(tract) = abs(y_err(1)-y_pos(tract));
    aux=aux+2;
end
errorbar(x_pos,y_pos,y_err_neg,y_err_pos,x_err_neg,x_err_pos,'o')
filemat = "centroids.mat";
save(strcat(tractsFolder_test,filemat),'x_pos','x_err_pos','x_err_neg','y_pos','y_err_pos','y_err_neg','tract_array_means','tracts');
end


