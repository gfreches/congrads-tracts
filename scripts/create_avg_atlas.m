%% Gets subjects from test and retest dataset
test= 'test';
retest='retest';
masksFolder_test     = strcat('/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/',test,'/HCP_Masks/');
masksFolder_retest     = strcat('/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/',retest,'/HCP_Masks/');
dirinfo_test = dir(masksFolder_test);
dirinfo_retest = dir(masksFolder_retest);
dirinfo = [dirinfo_test;dirinfo_retest];
dirinfo(~[dirinfo.isdir]) = [];  %remove non-directories
dirinfo_cell = struct2cell(dirinfo);
[~,n] = size(dirinfo_cell);
li=1;
subject_folder_list = zeros(88,1);
subject_folder_list = string(subject_folder_list);
for i = 1:n
    if length(dirinfo_cell{1,i})>2
            subject_folder_list(li)=strcat(dirinfo_cell{2,i},'/',dirinfo_cell{1,i});
            li=li+1;
    end
end
%% Gets atlases and puts them in matrix form
aparc_mat=zeros(32492,90);
BA_mat=zeros(32492,90);
for i = 1:length(subject_folder_list)
subjID = regexp(subject_folder_list(i), '\d+', 'match');
BA_atlas = strcat(subject_folder_list(i),'/',subjID,'.L.BA.32k_fs_LR.label.gii');
BA_atlas = char(BA_atlas);
aparc_atlas = strcat(subject_folder_list(i),'/',subjID,'.L.aparc.32k_fs_LR.label.gii');
aparc_atlas = char(aparc_atlas);
BA=readimgfile(BA_atlas);
aparc=readimgfile(aparc_atlas);
aparc_mat(:,i)=aparc.data{1,1}.Data;
BA_mat(:,i)=BA.data{1,1}.Data;
end
%% Gets region of Highest occurence for each vertex 
aparc_mat=aparc_mat';
BA_mat=BA_mat';
aparc_mat(aparc_mat==1)=5012;%% merging all temporal areas
aparc_mat(aparc_mat==7)=5012;
aparc_mat(aparc_mat==9)=5012;
aparc_mat(aparc_mat==15)=5012;
aparc_mat(aparc_mat==30)=5012;
aparc_mat(aparc_mat==33)=5012;
aparc_mat(aparc_mat==34)=5012;
BA_mat(BA_mat==8)=4455; %% merging areas 44 and 45 as only one
BA_mat(BA_mat==9)=4455;
aparc_mat_mode = mode(aparc_mat);
BA_mat(BA_mat==0)=NaN;
BA_mat_mode = mode(BA_mat);

%% Creates atlas with the common vertices for at least 95% of the subjects
BA_vec=zeros(32492,1);
aparc_vec=zeros(32492,1);

for j = 1:32492
proportion_BA = sum(BA_mat(:,j) == BA_mat_mode(j))/length(subject_folder_list);
proportion_aparc = sum(aparc_mat(:,j) == aparc_mat_mode(j))/length(subject_folder_list);
if proportion_BA>0.95
    BA_vec(j,1)=BA_mat_mode(j);
end
if proportion_aparc>0.95
    aparc_vec(j,1)=aparc_mat_mode(j);
end
end
saveimgfile(BA_vec,'/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/global/BA_atlas_1p_L.func.gii','L');
saveimgfile(aparc_vec,'/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/global/aparc_atlas_1p_L.func.gii','L');

