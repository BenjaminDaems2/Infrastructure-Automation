#!/bin/bash

# Set the directory with the input files
input_dir="data"

# Set the fields to extract from the JSON file
fields="adres,titel,gereserveerde_plaatsen,totale_capaciteit"

# Loop through all files in the input directory
for input_file in "$input_dir"/*.json
do
  # Set the output file name
  output_file="${input_file%.*}.csv"

  # Create the header row
  echo "$fields" > "$output_file"

  # Extract the specified fields from the JSON file and append to the CSV file
  jq -r --arg fields "$fields" '(.records[] | [.fields[$fields]] | @csv)' "$input_file" >> "$output_file"
done
