#!/bin/bash
 
# Path to the file containing the list of files to delete
file_list="file_list.txt"
 
# Check if the file_list file exists
if [ ! -f "$file_list" ]; then
  echo "File $file_list not found!"
  exit 1
fi
 
# Read the file line by line
while IFS= read -r line; do
  # Check if the line is not empty
  if [ -n "$line" ]; then
    # Check if the file or directory exists
    if [ -e "$line" ]; then
      # Check if it's a file or directory
      if [ -f "$line" ]; then
        echo "Deleting file: $line"
        rm "$line"
      elif [ -d "$line" ]; then
        echo "Deleting directory: $line"
        rm -r "$line"
      else
        echo "Unknown file type: $line"
      fi
    else
      echo "File or directory not found: $line"
    fi
  fi
done < "$file_list"