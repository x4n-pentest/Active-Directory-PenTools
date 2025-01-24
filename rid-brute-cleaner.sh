#!/bin/bash

# Function to display help message
show_help() {
    echo "Usage: $0 <input-file>"
    echo ""
    echo "Description:"
    echo "  This tool extracts usernames from a list of lines containing 'SID' entries."
    echo "  It removes the domain part (everything before the '\\')."
    echo "  Only lines ending with '(SidTypeUser)' are processed."
    echo ""
    echo "Examples:"
    echo "  $0 list.txt"
    exit 1
}

# Check if no arguments are provided
if [ "$#" -lt 1 ]; then
    show_help
fi

input_file="$1"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found!"
    exit 1
fi

# Extract the usernames and filter lines ending with '(SidTypeUser)'
grep -P '.*\\.*\(SidTypeUser\)$' "$input_file" | sed -E 's/.*\\//;s/ \(SidTypeUser\)$//'
