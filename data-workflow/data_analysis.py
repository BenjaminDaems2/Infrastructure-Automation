#!/usr/bin/env python

import csv
import os
import matplotlib.pyplot as plt

# Set the directory with the input files
input_dir = "data"
output_dir = "data/analysis"

# Create the output directory if it doesn't exist yet
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Loop through all files in the input directory
timestamps = []
reserved_spots = []
most_occupied = []
least_occupied = []

for input_file in os.listdir(input_dir):
    # Skip files that are not CSV
    if not input_file.endswith(".csv"):
        continue

    # Get the timestamp from the file name
    timestamp = input_file.split("-")[1]

    # Parse the CSV file
    with open(os.path.join(input_dir, input_file)) as f:
        reader = csv.DictReader(f)
        total_spots = 0
        for row in reader:
            # Add the number of reserved spots to the total
            try:
                total_spots += int(row["gereserveerde_plaatsen"])

            except ValueError:
                # Skip rows that don't have a valid "gereserveerde_plaatsen" value
                continue

    # Add the timestamp and total number of reserved spots to the lists
    timestamps.append(timestamp)
    reserved_spots.append(total_spots)

# Create a bar chart with the data
plt.bar(timestamps, reserved_spots)

# Save the chart to a PNG file
plt.savefig(f"{output_dir}/occupancy.png")

#Calculate the average of the reserved spots at each time

average_reserved_spots = sum(reserved_spots) / len(reserved_spots)
#Find the index of the most and least occupied times

max_index = reserved_spots.index(max(reserved_spots))
min_index = reserved_spots.index(min(reserved_spots))

with open(f"{output_dir}/averages.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow([
        "Time", "Average Reserved Spots", "Most Occupied Value",
        "Least Occupied Value"
    ])
    for i in range(len(timestamps)):
        writer.writerow([
            timestamps[i], average_reserved_spots,
            max(reserved_spots),
            min(reserved_spots)
        ])
#Print a message to indicate that the file has been created

print(f"New CSV file created: {output_dir}/averages.csv")