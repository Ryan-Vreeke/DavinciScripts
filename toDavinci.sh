#!/bin/bash

# Check if enough arguments are provided (input file and optional framerate)
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: $0 <input-file> [framerate]"
    exit 1
fi

# Get the input file
input_file="$1"

# Get the framerate (default to 30 if not provided)
framerate="${2:-30}"

# Check if the framerate is valid (either 30 or 60)
if [ "$framerate" -ne 30 ] && [ "$framerate" -ne 60 ]; then
    echo "Error: Framerate must be either 30 or 60."
    exit 1
fi

# Get the output filename by replacing the extension with .mov
output_file="${input_file%.*}.mov"

# Run the ffmpeg command with the given arguments
ffmpeg -i "$input_file" -vcodec dnxhd -acodec pcm_s16le -s 1920x1080 -r "$framerate" -b:v 36M -pix_fmt yuv422p -f mov "$output_file"
