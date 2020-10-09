#!/bin/bash

d=/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest
bindir=/usr/share/fsl/5.0
test_retest=retest
struct=or_r

# # Human

subjects=`cat $d/human_subjects.txt`
HCPdir=/vol/neuroecology-y/HCP_test_retest
for subj in $subjects;do
#for subj in subject list; do
	protocol_folder=/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/global
     bpxdir=$HCPdir/$test_retest/$subj/T1w/Diffusion.bedpostX
     
std2diff=/vol/neuroecology-y/HCP_test_retest/$test_retest/$subj/MNINonLinear/xfms/standard2acpc_dc.nii.gz
     diff2std=/vol/neuroecology-y/HCP_test_retest/$test_retest/$subj/MNINonLinear/xfms/acpc_dc2standard.nii.gz
    
     outdir=$d/$test_retest/results_MNI_1_25mm/$subj/$struct/probtrackx
     mkdir -p $outdir
target=/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/$test_retest/tracts/$subj/tracts/$struct/densityNorm_inf_thresh.nii.gz
stop=$protocol_folder/exclude_midline_1_25mm.nii.gz
#exclude_midline_1_25mm.nii.gz

     # Transform seed to diffusion space
     #applywarp	
     # Run probtraxx2
     command="$bindir/bin/probtrackx2 -x /vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/$test_retest/HCP_Masks/$subj/$struct.nii.gz -l --onewaycondition --omatrix2 --target2=$target -c 0.2 -S 2000 --steplength=0.5 -P 10000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --xfm=$std2diff --invxfm=$diff2std --forcedir --opd -s $bpxdir/merged -m $bpxdir/nodif_brain_mask --stop=$stop --dir=$outdir --seedref=$protocol_folder/MNI152_T1_1_25mm_brain.nii.gz --avoid=$protocol_folder/Fornix_Mask_1_25mm.nii.gz"

  # Submit to batch
  echo "Submitting to batch..."
  scriptname="$d/tmpscripts/probtrackx_script$subj"
  echo "$command" > $scriptname
  chmod a+rwx $scriptname
  qsub -V -l walltime=120:00:00,mem=36gb $scriptname

 done

