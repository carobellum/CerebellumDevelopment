#!/bin/bash

# Ensure the correct number of arguments is provided
if [ $# -lt 3 ]; then
  echo "Example: $0 https://github.com/OpenNeuroDatasets/ds000120.git dataset_name_from_excel_sheet "01_T1w.nii.gz" "01_bold.nii.gz""
  exit 1
fi

# Extract the arguments
dataset_url=$1
dataset_name=$2
shift 2  # Remove the first two arguments, so the remaining are file patterns

# Clone the dataset
datalad clone "$dataset_url" "$dataset_name"

# Build the find command with the given patterns
find_command="find \"$dataset_name\""
for pattern in "$@"; do
  find_command+=" -name \"$pattern\" -o"
done
# Remove the trailing -o
find_command=${find_command% -o}

# Execute the find command and download the files
datalad get $(eval "$find_command")