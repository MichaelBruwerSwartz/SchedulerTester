#!/bin/bash

# Directories
output_dir="./Output1"
correct_dir="./Correct"

# Check if directories exist
if [[ ! -d "$output_dir" ]]; then
    echo "Output directory '$output_dir' does not exist."
    exit 1
fi

if [[ ! -d "$correct_dir" ]]; then
    echo "Correct directory '$correct_dir' does not exist."
    exit 1
fi

# Loop through each file in the output directory
for file in "$output_dir"/*; do
    filename=$(basename "$file")
    correct_file="$correct_dir/$filename"

    # Check if the corresponding file exists in /Correct
    if [[ ! -f "$correct_file" ]]; then
        echo "File '$filename' not found in $correct_dir."
        continue
    fi

    # Compare the files using diff
    if diff -q "$file" "$correct_file" > /dev/null; then
        echo "$filename: PASS"
    else
        echo "$filename: FAIL"
        echo "Differences:"
        diff "$file" "$correct_file"
    fi
done

