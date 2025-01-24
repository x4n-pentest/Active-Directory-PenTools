#!/bin/bash

# Function to display help message
show_help() {
    echo "Usage: $0 <input-file> [-c]"
    echo ""
    echo "Description:"
    echo "  This tool extracts valid usernames from an input file."
    echo ""
    echo "Options:"
    echo "  -c   Remove the domain part from usernames (everything after '@')."
    echo ""
    echo "Examples:"
    echo "  $0 input.txt"
    echo "  $0 input.txt -c"
    exit 1
}

# Check if no arguments are provided
if [ "$#" -lt 1 ]; then
    show_help
fi

input_file="$1"
clean_output=false

# Check for the -c option
if [ "$#" -eq 2 ] && [ "$2" == "-c" ]; then
    clean_output=true
fi

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found!"
    exit 1
fi

# Extract valid usernames
if [ "$clean_output" = true ]; then
    # Remove domain part after '@'
    grep -oP '(?<=VALID USERNAME:\t).*' "$input_file" | sed 's/@.*//'
else
    grep -oP '(?<=VALID USERNAME:\t).*' "$input_file"
fi

