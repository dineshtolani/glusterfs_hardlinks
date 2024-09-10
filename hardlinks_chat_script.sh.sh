#!/bin/bash

# Input path to .glusterfs directory
glusterfs_dir="/path/to/.glusterfs"

# Output file for orphaned GFIDs
output_file="/path/to/output.final"

# Clear the output file
> "$output_file"

# Function to resolve GFID
resolve_gfid() {
    local brick="$1"
    local gfid="$2"
    local gfid_dir="$brick/.glusterfs/$(echo "$gfid" | cut -c 1-2)/$(echo "$gfid" | cut -c 3-4)"
    local gfid_path="$gfid_dir/$gfid"

    if [[ -h "$gfid_path" ]]; then
        local dir_path="$gfid_dir/$(readlink "$gfid_path")"
        echo "$(cd "$(dirname "$dir_path")"; pwd -P)/$(basename "$dir_path")"
    else
        local inode=$(stat --format=%i "$gfid_path")
        find "$brick" -inum "$inode" ! -path '*.glusterfs/*'
    fi
}

# Recursively traverse the .glusterfs directory
find "$glusterfs_dir" -type f -links -2 | while read -r gfid_path; do
    gfid=$(basename "$gfid_path")
    resolved_path=$(resolve_gfid "$glusterfs_dir" "$gfid")
    
    # Check if the resolved path exists
    if [[ -z "$resolved_path" ]]; then
        echo "$gfid_path" >> "$output_file"
    fi
done

echo "Orphaned GFIDs written to $output_file"
