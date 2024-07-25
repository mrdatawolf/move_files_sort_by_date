#!/bin/bash

# Base directory
base_dir="/var/folders"

# Directory to search through
search_dir="/path/to/your/directory"

# Loop through all files in the search directory
for file in "$search_dir"/*; do
    # Only process files in the format "Stm_?? Daily Report *.*"
    if [[ $file =~ Stm_..[[:space:]]Daily[[:space:]]Report[[:space:]].* ]]; then
        # Extract the date from the end of the filename
        date_string=$(echo $file | awk -F' ' '{print $(NF)}')
        # Convert the date to the format "Month_Year"
        folder_name=$(date -d$date_string "+%B_%Y")
        # Check if the folder exists in the base directory, if not create it
        if [[ ! -d "$base_dir/$folder_name" ]]; then
            mkdir "$base_dir/$folder_name"
        fi
        # Check if the file already exists in the target folder
        if [[ ! -f "$base_dir/$folder_name/$(basename $file)" ]]; then
            # If the file doesn't exist, copy it to the target folder
            cp "$file" "$base_dir/$folder_name/"
        fi
    fi
done
