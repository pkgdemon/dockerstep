#!/bin/bash

# Source GNUstep.sh
. /System/Library/Makefiles/GNUstep.sh

# Write GNUstep defaults
defaults write NSGlobalDomain GSBackHandlesWindowDecorations NO

# Start GWorkspace with XWayland
exec openapp GWorkspace --display ":0"