#!/bin/bash

# Check if GNUstep directory exists in user's home
if [ ! -d "/home/$USER/GNUstep" ]; then
    # If not, copy GNUstep defaults recursively from /etc/skel
    cp -r /etc/skel/GNUstep /home/$USER/
fi

# Start GWorkspace with XWayland
exec GWorkspace --display ":1"