#! /bin/sh

bindir=/usr/share/fsl/6.0.1/data/standard
test_retest=test
HCProot=/vol/neuroecology-y/HCP_test_retest/$test_retest
mymask=/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/$test_retest/HCP_Masks


subjects=`cat human_subjects.txt`
for side in L;do
for seedmask in Struct_ ;do

for s in $subjects;do



mkdir $mymask/$s -p

surf2surf -i ${HCProot}/${s}/MNINonLinear/fsaverage_LR32k/${s}.$side.midthickness_MSMAll.32k_fs_LR.surf.gii --values=/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/global/${seedmask}$side.func.gii -o ${mymask}/${s}/${seedmask}$side.gii

wb_command -metric-to-volume-mapping /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/global/${seedmask}$side.func.gii  ${HCProot}/${s}/MNINonLinear/fsaverage_LR32k/${s}.$side.pial_MSMAll.32k_fs_LR.surf.gii /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/global/MNI152_T1_1_25mm_brain.nii.gz ${mymask}/${s}/${seedmask}$side.nii.gz -ribbon-constrained ${HCProot}/${s}/MNINonLinear/fsaverage_LR32k/${s}.$side.midthickness_MSMAll.32k_fs_LR.surf.gii ${HCProot}/${s}/MNINonLinear/fsaverage_LR32k/${s}.$side.pial_MSMAll.32k_fs_LR.surf.gii

done
done
done
echo "Ready to be processed"
