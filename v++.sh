#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 VERSION_DIR"
    exit 1
fi

# Set the VERSION_DIR to the provided argument
VERSION_DIR="$1"

# Find the highest version number folder
highest_version=$(find "$VERSION_DIR" -maxdepth 1 -type d -name 'v*' | grep -oE '[0-9]+$' | sort -nr | head -n 1)

echo "Highest version found: $highest_version"

# If no version folders exist, set the highest version to 0
if [ -z "$highest_version" ]; then
    highest_version=0
fi

# Increment the highest version number
new_version=$((highest_version + 1))
# Create a new version folder
new_folder="v$new_version"
mkdir "$new_folder"

echo "Created new version folder: $new_folder"

# Find files matching the pattern "-{$new_folder}.*" in the current directory
# Use null termination to handle filenames with spaces
find . -maxdepth 1 -type f -name "*-${new_folder}.*" -print0 |
while IFS= read -r -d '' file; do
    mv "$file" "$new_folder/"
    echo "Moved '$file' to '$new_folder/'"
done

echo "All matching files moved to $new_folder/"

# Iterate over each .ai file in $new_folder
for file in "$new_folder"/*.ai; do
    # Check if the file exists
    if [ -e "$file" ]; then
        # Get the base filename without extension
        base_name="${file%.*}"
        #echo $base_name
        # Get the version number (last number before .ai)
        version_number=$(echo "$base_name" | grep -oE '[0-9]+$' | tail -1)

        # Increment the version number
        ((version_number++))

        # Get the filename without version number
        file_without_version="${base_name::-3}"

        # Construct the new filename with incremented version number
        new_filename="${file_without_version}-v${version_number}.ai"
        echo $new_filename
        # Copy the file to the parent directory with the new filename
        cp "$file" $1/"$(basename "$new_filename")"
        #echo "$new_filename"
        #echo "Copied $file to ../$new_filename"
    else
        echo "No .ai files found in $new_folder"
        exit 1
    fi
done


