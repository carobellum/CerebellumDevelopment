#!/bin/bash
# ------------------------------------------------------------------------------
# Script name:  coverage.sh
#
# Description:
#               Script to check coverage on cerebellum
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
# --- Preparation (do only once) ---
# Prep lobule label file: Resample ${workdir}/Lobules_MNI152Nlin6Asym to 2 mm
# flirt \
#     -in ${workdir}/Lobules_MNI152Nlin6Asym \
#     -ref ${workdir}${scan_id}.anat/T1_to_MNI_nonlin.nii.gz \
#     -applyisoxfm 2 \
#     -out ${workdir}/Lobules_MNI152Nlin6Asym_2mm \
#     -interp nearestneighbour

# # Prep results: Create file with lobule names and lobule sizes
# cat /Users/callithrix/Documents/Projects/DiedrichsenLab/SUITPapaya/data/cerebellar_atlases/Diedrichsen_2009/atl-Anatom.lut | awk '{print $5}' > ${workdir}/results/lobules.txt
# fslstats -K ${workdir}/Lobules_MNI152Nlin6Asym_2mm ${workdir}/Lobules_MNI152Nlin6Asym_2mm -V | awk '{print $1}' > ${workdir}/results/sizes.txt
# paste -d '\t' ${workdir}/results/lobules.txt ${workdir}/results/sizes.txt > ${workdir}/results/lobules_sizes.txt
# rm ${workdir}/results/lobules.txt ${workdir}/results/sizes.txt

# Create a test scan where only half the cerebellum is covered
# fslroi \
#     ${datadir}/$scan \
#     $workdir/${scan_id}_clipped \
#     0 -1 0 -1 107 -1
# ------------------------------------------------------------------------------
scan=adult_test/pontS08/pontS08_T1w.nii
scan_id=$(basename ${scan} .nii)
workdir=${datadir}/coverage_check/


# Normalize T1 scan into MNI space
fsl_anat \
    --noseg \
    --nosubcortseg \
    --nocrop \
    -i ${datadir}/coverage_check/${scan_id}_clipped \
    -o ${datadir}/coverage_check/${scan_id}_clipped \
    --clobber


open ${workdir}/coverage_${scan_id}.txt
