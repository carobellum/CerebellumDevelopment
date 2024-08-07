#!/bin/bash
# ------------------------------------------------------------------------------
# Script name:  check_coverage.sh
#
# Description:
#               Produces a text file in the current directory with the coverage of each lobule in the cerebellum.
#
# Author:       Caroline Nettekoven, 2024
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Define the function
check_coverage() {
    local scan=$1
    local output=$2


``
    # Check coverage: Get number of voxels that are non-zero in the MNI-space lobule label file
    rm -f ${output}.txt
    fslstats -K Lobules_MNI152Nlin6Asym_2mm ${scan} -V | awk '{print $1}' > temp.txt
    paste -d '\t' lobules_sizes.txt temp.txt > temp1.txt

    # Calculate percentage coverage for each lobule
    awk '{print $3/$2*100}' temp1.txt > temp2.txt
    paste -d '\t' <(cut -f1 lobules_sizes.txt) temp2.txt > coverage_${output}.txt
    rm -f temp*.txt

    # Add header
    sed -i '' '1s/^/Lobule\tpercentage_covered\n/' "coverage_${output}.txt"

}

# --- Navigate to folder where the lobule label file is stored ---
# cd /Volumes/diedrichsen_data$/data/Raynor_developement/coverage_check
# --- Make sure the function is callable and call the function with arguments ---
# check_coverage "/Volumes/diedrichsen_data\$/data/Raynor_developement/coverage_check/pontS08_T1w.anat/T1_to_MNI_nonlin.nii.gz" "pontS08"
# --- Open the file ---
# open coverage_${output}.txt