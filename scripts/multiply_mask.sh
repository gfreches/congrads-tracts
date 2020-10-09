#!/bin/bash

test_retest=test
bindir=/usr/share/fsl/5.0/data/standard

for tract in ac af_l af_r ar_l ar_r cbd_l cbd_r cbp_l cbp_r cbt_l cbt_r fa_l fa_r fma fmi fx_l fx_r ifo_l ifo_r ilf_l ilf_r mdlf_l mdlf_r or_l or_r slf1_l_kattest2 slf1_r_kattest2 slf2_l_kattest2 slf2_r_kattest2 slf3_l_kattest2 slf3_r_kattest2 unc_l unc_r;do
for gradient in g3;do
for struct in Temporal_;do
for side in R L;do

fslmaths /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/Gradient_Averages/$test_retest/tracts/$tract.nii.gz -mul /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/Gradient_Averages/$test_retest/$struct$side/$struct${side}_${gradient}.nii.gz /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/Gradient_Averages/$test_retest/$struct$side/tracts/$tract$gradient
done
done
done
done

