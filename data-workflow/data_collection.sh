#!/bin/bash

# Set the directory where the data will be saved
dir="data"

# Create the directory if it does not exist
if [ ! -d "$dir" ]; then
  mkdir -p "$dir"
fi

# Get the current date and time in the format JJJJMMDD-uummss
timestamp=$(date +"%Y%m%d-%H%M%S")

# Set the file name
file_name="data-$timestamp.json"

# Set the URL of the API
url="https://data.stad.gent/api/records/1.0/search/?dataset=bloklocaties-gent&q="

# Use curl to make the request and save the response to a file
curl "$url" -o "$dir/$file_name"
