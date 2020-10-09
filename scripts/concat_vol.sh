#!/bin/bash

d=/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest
test_retest=test
for tract in ac af_r ar_r cbd_r cbp_r cbt_r fa_r fma fmi fx_r ifo_r ilf_r mdlf_r or_r slf1_r_kattest2 slf2_r_kattest2 slf3_r_kattest2  unc_r;do

fslmerge -t /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/Gradient_Averages/$test_retest/tracts/$tract.nii.gz /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/$test_retest/tracts/*/tracts/$tract/densityNorm_inf_thresh.nii.gz
done
