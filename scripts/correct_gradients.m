function correct_gradients(area,side)
%% Gets subjects from test and retest dataset

test= 'test';
retest='retest';
masksFolder_test     = strcat('/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/',test,'/results_MNI_1_25mm/');
masksFolder_retest     = strcat('/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/',retest,'/results_MNI_1_25mm/');

subjects = string(importdata('/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/human_subjects.txt'));
reference_array= niftiread(char(strcat(masksFolder_test,subjects(1),'/',area,'/gradients_knn/','gradient_g1.nii.gz')));
reference_array=reshape(reference_array(:,55,:),1,[]);
%reference_array= readimgfile(char(strcat(masksFolder_test,subjects(1),'/',area,'/gradients_knn/','gradient_g1.nii.gz')));
reference_array_info = ft_read_mri(char(strcat(masksFolder_test,subjects(2),'/',area,'/gradients_knn/','gradient_g1.nii.gz')));
correlations = zeros(1,length(subjects)*2);%matrix with all correlations to reference
subject_folder_list = strings(length(subjects)*2,1);
for subject=1:length(subjects)
    subject_folder_list(subject)=strcat(masksFolder_test,subjects(subject));
end
for subject=1:length(subjects)
    subject_folder_list(subject+length(subjects))=strcat(masksFolder_retest,subjects(subject));
end
for j = 1:length(subject_folder_list)
    nifti=niftiread(char(strcat(subject_folder_list(j),'/',area,'/gradients_knn/','gradient_g1.nii.gz')));
    correl = corr2(reference_array,reshape(nifti(:,55,:),1,[]));
    correlations(:,j) = correl;
end
imgs_to_flip=imbinarize(correlations,0.75); % threshold for flipping

 for j=1:length(imgs_to_flip)
        if imgs_to_flip(j)==0 
            gradient_image = readimgfile(char(strcat(subject_folder_list(j),'/',area,'/gradients_knn/','gradient_g1.func.gii')));
            projection_image = niftiread(char(strcat(subject_folder_list(j),'/',area,'/gradients_knn/','projection_g1.nii.gz')));
            gradient_image(gradient_image~=0)=(gradient_image(gradient_image~=0)-11)*(-1);
            projection_image(projection_image~=0)=(projection_image(projection_image~=0)-11)*(-1);
            ft_write_mri(char(strcat(subject_folder_list(j),'/',area,'/gradients_knn/','gradient_g1.nii.gz')),gradient_image,'dataformat','nifti','transform',reference_array_info.transform);
            ft_write_mri(char(strcat(subject_folder_list(j),'/',area,'/gradients_knn/','projection_g1.nii.gz')),projection_image,'dataformat','nifti','transform',reference_array_info.transform);
        end
 end
               
