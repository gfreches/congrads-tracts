#!/bin/bash

test_retest=retest
for struct in structure;do
for gradient in _g1;do
fslmerge -t /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/Gradient_Averages/$test_retest/$struct/$struct$gradient.nii.gz /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/$test_retest/results_MNI_1_25mm/*/$struct/gradients_eps/projection$gradient.nii.gz
done
done
