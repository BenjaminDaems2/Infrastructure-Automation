#!/bin/bash

# This script generates a markdown report from a csv file
# with columns 'Time,Average Reserved Spots,Most Occupied Value,Least Occupied Value'
# and an image 'occupancy.png'.

# Specify the input directory
INPUT_DIR="data/analysis"

# Check if the required files are present
if [ ! -f "$INPUT_DIR/occupancy.png" ]; then
    echo "Error: occupancy.png not found"
    exit 1
fi

if [ ! -f "$INPUT_DIR/averages.csv" ]; then
    echo "Error: averages.csv not found"
    exit 1
fi

# Generate the markdown report
echo "# Occupancy Report" > report.md
echo "" >> report.md
echo "This report contains information about the occupancy of a parking lot." >> report.md
echo "" >> report.md
echo "## Data" >> report.md
echo "" >> report.md
echo "| Time | Average Reserved Spots | Most Occupied Value | Least Occupied Value |" >> report.md
echo "|------|------------------------|--------------------|----------------------|" >> report.md

# Add the data from the csv file to the report
while IFS= read -r line; do
    # Split the line into fields
    IFS=',' read -r -a fields <<< "$line"

    # Format the fields
    time=${fields[0]}
    avg_reserved_spots=$(printf "%0.2f" ${fields[1]})
    most_occupied_value=${fields[2]}
    least_occupied_value=${fields[3]}

    # Add the formatted fields to the report
    echo "| $time | $avg_reserved_spots | $most_occupied_value | $least_occupied_value |" >> report.md
done < "$INPUT_DIR/averages.csv"

echo "" >> report.md
echo "## Occupancy Chart" >> report.md
echo "" >> report.md

# Add the occupancy chart to the report
echo "![Occupancy Chart]($INPUT_DIR/occupancy.png)" >> report.md


# Convert the markdown report to a PDF
pandoc report.md -o report.pdf
