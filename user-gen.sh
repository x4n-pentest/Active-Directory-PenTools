#!/bin/bash

# Function to display help message
show_help() {
    echo "Usage: $0 <firstnames-file> <lastnames-file> <separator> [-a]"
    echo ""
    echo "Description:"
    echo "  Combines a list of first names and last names with a specified separator."
    echo "  Alternatively, use the '-a' option to generate usernames starting with A-Z."
    echo ""
    echo "Examples:"
    echo "  $0 firstnames.list lastnames.list '.'"
    echo "      Output:"
    echo "        Tim.Müller"
    echo "        Tim.Simons"
    echo "        ..."
    echo ""
    echo "  $0 -a lastnames.list '-'"
    echo "      Output:"
    echo "        A-Müller"
    echo "        B-Simons"
    echo "        ..."
    echo ""
    echo "Options:"
    echo "  -a   Use alphabet letters (A-Z) instead of a first names list."
    echo ""
    exit 1
}

# Check if the correct number of arguments is provided
if [ "$#" -lt 3 ]; then
    echo "Error: Invalid number of arguments."
    show_help
fi

# Handle the alphabet switch "-a"
if [ "$1" == "-a" ]; then
    vornamen_liste=""
    nachnamen_liste=$2
    trennzeichen=$3
    use_alphabet=true
else
    vornamen_liste=$1
    nachnamen_liste=$2
    trennzeichen=$3
    use_alphabet=false
fi

# Check if files exist if not using alphabet mode
if [ "$use_alphabet" = false ] && { [ ! -f "$vornamen_liste" ] || [ ! -f "$nachnamen_liste" ]; }; then
    echo "Error: One or both input files do not exist."
    exit 1
elif [ "$use_alphabet" = true ] && [ ! -f "$nachnamen_liste" ]; then
    echo "Error: Last names file '$nachnamen_liste' does not exist."
    exit 1
fi

# Generate usernames
if [ "$use_alphabet" = true ]; then
    # Loop through letters A-Z instead of first names
    for letter in {A..Z}; do
        while IFS= read -r nachname; do
            echo "${letter}${trennzeichen}${nachname}"
        done < "$nachnamen_liste"
    done
else
    # Read first and last names from files
    while IFS= read -r vorname; do
        while IFS= read -r nachname; do
            echo "${vorname}${trennzeichen}${nachname}"
        done < "$nachnamen_liste"
    done < "$vornamen_liste"
fi
