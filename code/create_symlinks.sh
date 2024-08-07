#!/bin/bash

# Ensure at least two arguments are provided (directory path and at least one pattern)
if [ $# -lt 2 ]; then
  echo "Example: $0 /path/to/directory "*_T1w.nii" "*_bold.nii""
  exit 1
fi

# Extract the directory path
dir_path=$1
shift  # Remove the directory path from the arguments list

# Build the find command with the given patterns
find_command="find -L \"$dir_path\" -type f"
for pattern in "$@"; do
  find_command+=" -name \"$pattern\" -o"
done
# Remove the trailing -o
find_command=${find_command% -o}

# Execute the find command and process each file
eval "$find_command" | while read -r file; do
  base_name=$(basename "$file")
  ln -s "$(readlink -f "$file")" "$dir_path/symlink_$base_name"
done