#!/bin/bash

test_retest=test
bindir=/usr/share/fsl/5.0/data/standard

struct=A1_R_thresh
struct_out=A1_R
for files in $(find /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/$test_retest/HCP_Masks/*/ -name "Broca_L.nii.gz")
do

subj=$(echo $files|grep -P '\d{6}' -o)


fslmaths /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/global/Brain_Mask_1_25mm.nii.gz -sub /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/$test_retest/HCP_Masks/$subj/$struct.nii.gz /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/$test_retest/HCP_Masks/$subj/full_brain_$struct_out.nii.gz
done
