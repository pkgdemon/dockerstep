#!/bin/bash

. /System/Library/Makefiles/GNUstep.sh

# Start GWorkspace with XWayland
exec openapp GWorkspace --display ":0"