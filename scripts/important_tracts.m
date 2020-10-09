function [percent_tract,percent_proj] = important_tracts(area,test_retest)


tractsFolder_test  = strcat("/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/Gradient_Averages/",test_retest,"/",area,"/tracts/");
tractsFolder_test_tracts  = strcat("/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/Gradient_Averages/",test_retest,"/tracts/");
tractsFolder_test_projection  = strcat("/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/Gradient_Averages/",test_retest,"/",area,"/");
tractsFolder_test_white_matter  = strcat("/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/Gradient_Averages/",test_retest,"/");
dirinfo = dir(tractsFolder_test);
dirinfo_cell = struct2cell(dirinfo);
[m,n] = size(dirinfo_cell);
tract_folder_list = zeros(33,1);
tract_folder_list = string(tract_folder_list);
li=1; 
for i = 1:n
    if contains(dirinfo_cell{1,i},'g1.nii')
            tract_folder_list(li)=dirinfo_cell{1,i};
            li=li+1;
    end
end
tract_folder_list_or=strrep(tract_folder_list,'g1','');
project_orig = readimgfile(char(strcat(tractsFolder_test_projection,area,"_g1.nii.gz")));
project_white = readimgfile(char(strcat(tractsFolder_test_white_matter,"wm_mask.nii.gz")));
project_orig = reshape(project_orig,[],44);
project_white = reshape(project_white,[],44);
project_orig = project_orig.*project_white; 
percent_tract = zeros(33,44);
percent_proj = zeros(33,44);
for p=1:33
    tract = readimgfile(char(strcat(tractsFolder_test_tracts,tract_folder_list_or(p))));
    tract = reshape(tract,[],44).*project_white;
    for j = 1:44
        project_aux = any(project_orig(:,j),2);
        tract_aux = any(tract(:,j),2);
        intersect = project_aux.*tract_aux;
        project_aux = sum(project_aux)+1;
        tract_aux = sum(tract_aux)+1;
        intersect = sum(intersect)+1;
        percent_tract(p,j) = intersect/tract_aux;
        percent_proj(p,j)=intersect/project_aux;
    end
end
filemat='important_tracts.mat';
save(strcat(tractsFolder_test_projection,"/tracts/",filemat));
end

