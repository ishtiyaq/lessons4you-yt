#!/bin/bash

# Function to check if a command exists
command_exists () {
  command -v "$1" >/dev/null 2>&1 ;
}

# Check if xwininfo is installed
if ! command_exists xwininfo ; then
  echo "xwininfo is not installed."
  echo "Please install it using the following command:"
  echo "sudo apt-get install -y x11-utils"
  exit 1
fi

# Check if xdotool is installed
if ! command_exists xdotool ; then
  echo "xdotool is not installed."
  echo "Please install it using the following command:"
  echo "sudo apt-get install -y xdotool"
  exit 1
fi

# Run xwininfo and capture the output
output=$(xwininfo)

# Extract the Window id using grep and awk
window_id=$(echo "$output" | grep 'xwininfo: Window id:' | awk '{print $4}')

# Check if window_id is not empty
if [ -z "$window_id" ]; then
  echo "Error: Could not retrieve the Window id."
  exit 1
fi

# Run xdotool to close the window using the extracted Window id
xdotool windowclose $window_id

# Check if xdotool command succeeded
if [ $? -eq 0 ]; then
  echo "Window $window_id closed successfully."
else
  echo "Error: Failed to close the window $window_id."
fi
