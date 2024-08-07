#!/bin/bash
# ------------------------------------------------------------------------------
# Script name:  coverage.sh
#
# Description:
#               Script to prepare checking coverage on cerebellum
#
# Author:       Caroline Nettekoven, 2024
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
if [ -d ~/Documents/Projects/RaynorDevelopment/ ]; then
localdir=~/Documents/Projects/RaynorDevelopment/
fi
if [ -d /Volumes/diedrichsen_data\$/data/Raynor_developement ]; then
basedir=/Volumes/diedrichsen_data\$/data/
elif [ -d /srv/diedrichsen/data/Raynor_developement ]; then
basedir=/srv/diedrichsen/data/
else
echo "Raynor_developement data directory not found."
fi
datadir=${basedir}Raynor_developement/
# ----
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# scan=${datadir}/adult_test/pontS08/pontS08_T1w.nii
# For the developmental data: Use the motion corrected, slice timing corrected image to get best results
scan=${datadir}//dHCP/rel3_rawdata_vol1/sub-CC00183XX11/ses-60300/anat/sub-CC00183XX11_ses-60300_run-16_rec-mcsr_T1w.nii.gz
scan_id=$(basename ${scan} .nii.gz)


# Normalize T1 scan into MNI space
# fsl_anat \
#     --noseg \
#     --nosubcortseg \
#     --nocrop \
#     -i ${scan} \
#     -o ${datadir}/coverage_check/${scan_id} \
#     --clobber


epi=${datadir}//dHCP/rel3_rawdata_vol1/sub-CC00183XX11/ses-60300/func/sub-CC00183XX11_ses-60300_run-09_task-rest_sbref.nii
epi_reg \
    --epi=$epi \
    --t1=${datadir}/coverage_check/${scan_id}.anat/T1.nii.gz \
    --t1brain=${datadir}/coverage_check/${scan_id}.anat/T1_brain.nii.gz \
    --out=${datadir}/coverage_check/${scan_id}.anat/epi_reg
