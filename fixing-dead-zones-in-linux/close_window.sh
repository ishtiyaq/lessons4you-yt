#!/bin/bash

output=$(xwininfo)
window_id=$(echo "$output" | grep 'xwininfo: Window id:' | awk '{print $4}')

xdotool windowclose $window_id
