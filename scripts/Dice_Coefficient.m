function [Dice] = Dice_Coefficient(area)
%% Gets subjects from test and retest dataset

test= 'test';
retest='retest';
masksFolder_test     = strcat('/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/',test,'/results_MNI_1_25mm/');
masksFolder_retest     = strcat('/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/',retest,'/results_MNI_1_25mm/');
dirinfo_test = dir(masksFolder_test);
dirinfo_retest = dir(masksFolder_retest);
dirinfo = [dirinfo_test;dirinfo_retest];
dirinfo(~[dirinfo.isdir]) = [];  %remove non-directories
dirinfo_cell = struct2cell(dirinfo);
[~,n] = size(dirinfo_cell);
li=1;
subject_folder_list = zeros(n-4,1);
subject_folder_list = string(subject_folder_list);
for i = 1:n
    if length(dirinfo_cell{1,i})>2
            subject_folder_list(li)=strcat(dirinfo_cell{2,i},'/',dirinfo_cell{1,i});
            li=li+1;
    end
end


masks_HCP_Folder_test     = strcat('/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/',test,'/HCP_Masks/');
masks_HCP_Folder_retest     = strcat('/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/',retest,'/HCP_Masks/');
dirinfo_test = dir(masks_HCP_Folder_test);
dirinfo_retest = dir(masks_HCP_Folder_retest);
dirinfo = [dirinfo_test;dirinfo_retest];
dirinfo(~[dirinfo.isdir]) = [];  %remove non-directories
dirinfo_cell = struct2cell(dirinfo);
[~,n] = size(dirinfo_cell);
li=1;
subject_HCP_folder_list = zeros(n-4,1);
subject_HCP_folder_list = string(subject_HCP_folder_list);
for i = 1:n
    if length(dirinfo_cell{1,i})>2
            subject_HCP_folder_list(li)=strcat(dirinfo_cell{2,i},'/',dirinfo_cell{1,i});
            li=li+1;
    end
end
subject_HCP_folder_list = reshape(subject_HCP_folder_list,44,2);
subject_folder_list = reshape(subject_folder_list,44,2);
Dice=zeros(44,2,2);
for r = 1:length(subject_folder_list)
pred_test = readimgfile(char(strcat(subject_folder_list(r,1),'/',area,'/gradients_knn/','BA_44_45_L.func.gii')));
pred_retest = readimgfile(char(strcat(subject_folder_list(r,2),'/',area,'/gradients_knn/','BA_44_45_L.func.gii')));
array_BA_44_test = readimgfile(char(strcat(subject_HCP_folder_list(r,1),'/BA44_L.func.gii')));
array_BA_45_test = readimgfile(char(strcat(subject_HCP_folder_list(r,1),'/BA45_L.func.gii')));
array_fusion_test = array_BA_44_test+array_BA_45_test;
array_BA_44_retest = readimgfile(char(strcat(subject_HCP_folder_list(r,2),'/BA44_L.func.gii')));
array_BA_45_retest = readimgfile(char(strcat(subject_HCP_folder_list(r,2),'/BA45_L.func.gii')));
array_fusion_retest = array_BA_44_retest+array_BA_45_retest;
pred_test_idx = find(pred_test);
pred_retest_idx = find(pred_retest);
array_fusion_test = array_fusion_test(pred_test_idx);
array_fusion_retest = array_fusion_retest(pred_retest_idx);
pred_test = pred_test(pred_test_idx);
pred_retest = pred_retest(pred_retest_idx);
sum_test = pred_test+array_fusion_test;
sum_retest = pred_retest+array_fusion_retest;
tp_44_test=sum(sum_test(:)==16);
tp_44_retest=sum(sum_retest(:)==16);
tp_45_test=sum(sum_test(:)==18);
tp_45_retest=sum(sum_retest(:)==18);
err_test=sum(sum_test(:)==17);
err_retest=sum(sum_retest(:)==17);
Dice(r,1,1)=2*tp_44_test/(2*tp_44_test+err_test);
Dice(r,2,1)=2*tp_45_test/(2*tp_45_test+err_test);
Dice(r,1,2)=2*tp_44_retest/(2*tp_44_retest+err_retest);
Dice(r,2,2)=2*tp_45_retest/(2*tp_45_retest+err_retest);
end