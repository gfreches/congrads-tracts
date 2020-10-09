#!/bin/bash

subjects=`cat human_subjects.txt`
for subj in $subjects;do
for tract in or_l or_r;do
fslmaths /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/global/intersect_or.nii.gz -mul /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/retest/tracts/$subj/tracts/$tract/densityNorm_inf_thresh.nii.gz /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/retest/HCP_Masks/$subj/$tract.nii.gz
done
done
