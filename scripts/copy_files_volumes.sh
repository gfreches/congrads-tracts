#!/bin/bash

test_retest=test
for filenames in T1w_acpc_dc_restore_1.25.nii.gz
do
echo $filenames
for files in $(find /vol/neuroecology-y/HCP_Test_Retest/$test_retest/*/T1w/ -name $filenames)
do
echo $files
subj=$(echo $files|grep -P '\d{6}' -o)
echo $subj
destination=/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/$test_retest/HCP_Masks/$subj

cp $files $destination 

done
done

