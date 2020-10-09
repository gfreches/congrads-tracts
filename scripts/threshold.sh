#!/bin/bash

threshold=0.5
replace="Prefrontal_L_thresh.nii.gz"
for files in $(find /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/test/HCP_Masks/*/ -name "Prefrontal_L.nii.gz")
do
echo $files
output="${files/Prefrontal_L.nii.gz/$replace}"

fslmaths $files -thr $threshold -bin $output
done

