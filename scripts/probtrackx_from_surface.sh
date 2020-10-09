#!/bin/bash

d=/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest

bindir=/usr/share/fsl/5.0
test_retest=retest
for side in R L;do
Struct=Temporal_$side
anadir=/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/$test_retest/HCP_Masks

subjects=`cat $d/human_subjects_test.txt`

HCPdir=/vol/neuroecology-y/HCP_test_retest

protocol_folder=/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/global

stop=$protocol_folder/exclude_midline_1_25mm.nii.gz
#Brain_Mask_Out_1_25mm.nii.gz for V1
#exclude_midline_1_25mm.nii.gz for Broca, Insula, Temporal and V1

for subj in $subjects;do
bpxdir=$HCPdir/$test_retest/$subj/T1w/Diffusion.bedpostX
std2diff=/vol/neuroecology-y/HCP_test_retest/$test_retest/$subj/MNINonLinear/xfms/standard2acpc_dc.nii.gz
diff2std=/vol/neuroecology-y/HCP_test_retest/$test_retest/$subj/MNINonLinear/xfms/acpc_dc2standard.nii.gz
target=/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/test/HCP_Masks/$subj/full_brain_$Struct.nii.gz
outdir=$d/$test_retest/results_MNI_1_25mm/$subj/$Struct/probtrackx
     mkdir -p $outdir

     command="$bindir/bin/probtrackx2 -x $anadir/$subj/$Struct.gii -l --onewaycondition --omatrix2 --target2=$target -c 0.2 -S 2000 --steplength=0.5 -P 10000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --xfm=$std2diff --invxfm=$diff2std --meshspace='caret' --forcedir --opd -s $bpxdir/merged -m $bpxdir/nodif_brain_mask --stop=$stop --dir=$outdir --seedref=/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/global/MNI152_T1_1_25mm_brain.nii.gz"

# Submit to batch
  echo "Submitting to batch..."
  scriptname="$d/tmpscripts/probtrackx_script$subj"
  echo "$command" > $scriptname
  chmod a+rwx $scriptname
  qsub -V -l walltime=120:00:00,mem=36gb $scriptname

 done
 done

