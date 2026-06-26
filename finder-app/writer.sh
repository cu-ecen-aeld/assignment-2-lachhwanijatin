#!/usr/bin/bash


if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <full_path> <content> "
    exit 1
fi

full_path=$1
content=$2

dir=$(dirname "$full_path")
filename=$(basename "$full_path")

if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir" 2>&1 > /dev/null
    if [ "$?" -ne 0 ]; then
        echo "file creation failed"
        exit 1;
    fi
fi

error_msg=$(touch "$full_path" 2>&1 > /dev/null)

if [ "$?" -ne 0 ]; then
    echo "file creation failed"
    exit 1;
fi

echo "$content" > "$full_path" 2> /dev/null

if [ "$?" -ne 0 ]; then
    echo "write to file failed"
    exit 1;
fi