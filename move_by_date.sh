#!/bin/bash

# dest_dir directory
dest_dir="/home/biztech/test"

# Directory to search through
search_dir="/home/biztech/test"

# Get the current month and year
current_month_year=$(date "+%B_%Y")

# Loop through all files in the search directory
for file in "$search_dir"/*; do
    echo "checking on $file"
    # Only process files in the format "Stm_?? Daily Report *.*"
    if [[ $file =~ Stm_..[[:space:]]Daily[[:space:]]Report[[:space:]].* ]]; then
        # Extract the date from the end of the filename
        date_string=$(echo $file | awk -F'Report ' '{print $2}' | awk -F'.xlsx' '{print $1}')
        # Convert the date to the format "Month_Year"
        # Reformat the date string to YYYY-MM-DD
        IFS="-" read -r month day year <<< "$date_string"
        formatted_date_string="$year-$month-$day"
        folder_name=$(date -d$formatted_date_string "+%B_%Y")
        # Check if the file is from the current month
        #if [[ "$folder_name" == "$current_month_year" ]]; then
            # If the file is from the current month, skip it
        #    continue
        #fi
        # Check if the folder exists in the dest_dir directory, if not create it
        if [[ ! -d "$dest_dir/$folder_name" ]]; then
            mkdir "$dest_dir/$folder_name"
        fi
        # Check if the file already exists in the target folder
        if [[ ! -f "$dest_dir/$folder_name/$(basename "$file")" ]]; then
            # If the file doesn't exist, copy it to the target folder
            mv "$file" "$dest_dir/$folder_name/"
        fi
    else
        echo "Done"
    fi
done
