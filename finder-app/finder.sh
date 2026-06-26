#!/usr/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path> <search_term> "
    exit 1
fi


path="$1"
search_term="$2"

if [[ ! -d "$1" ]]; then
    echo "ERROR: first argument is not a valid directory"
    exit 1
fi

readarray -d '' all_files < <(find "$path" -type f -print0)

num_files=$(find "$path" -type f | wc -l);
num_match=$(grep -r "$search_term" "$path" | wc -l);

echo "The number of files are $num_files and the number of matching lines are $num_match"