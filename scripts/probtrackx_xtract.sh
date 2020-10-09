#!/bin/bash

d=/project/3022017.03/excluded_subjects
bindir=/opt/fsl/6.0.3


HCPdir=/project/3022017.01/S1200

for subj in 114823 115320;do

     	bpxdir=$HCPdir/${subj}/T1w/Diffusion.bedpostX
    	outdir=$d/test/${subj}_xtract
	std2diff=$HCPdir/$subj/MNINonLinear/xfms/standard2acpc_dc.nii.gz
	diff2std=$HCPdir/$subj/MNINonLinear/xfms/acpc_dc2standard.nii.gz

     # Transform seed to diffusion space
     #applywarp	
     # Run probtraxx2 

  mkdir -p $outdir
  # Submit to batch
  echo "Submitting to batch..."
  echo "xtract -bpx $bpxdir -out $outdir -species HUMAN -stdwarp $std2diff $diff2std -gpu -res 2" | qsub -N "xtract_${subj}" -l 'nodes=1:gpus=1, feature=cuda, walltime=04:00:00, mem=16gb, reqattr=cudacap>=5.0' -o /project/3022017.03/o_xtract_${subj}.txt -e /project/3022017.03/e_xtract_${subj}.txt

 done

