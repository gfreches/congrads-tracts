#!/bin/bash

test_retest=retest
for side in R L;do
for filenames in $side.pial_MSMAll.32k_fs_LR.surf.gii $side.midthickness_MSMAll.32k_fs_LR.surf.gii $side.white_MSMAll.32k_fs_LR.surf.gii $side.sphere.32k_fs_LR.surf.gii $side.flat.32k_fs_LR.surf.gii $side.inflated_MSMAll.32k_fs_LR.surf.gii $side.very_inflated_MSMAll.32k_fs_LR.surf.gii $side.aparc.32k_fs_LR.label.gii $side.BA.32k_fs_LR.label.gii
do
for files in $(find /vol/neuroecology-y/HCP_Test_Retest/$test_retest/*/MNINonLinear/fsaverage_LR32k/ -name *.$filenames)
do
subj=$(echo $files|grep -P '\d{6}/' -o)
echo $files
destination=/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/$test_retest/HCP_Masks/$subj

mkdir -p $destination

cp $files $destination 

done
done
done

