#!/bin/sh

# Helper script to correctly invoke Qvim with flag
if [ -z "$DISPLAY" ]; then
    /usr/bin/vim $@
else
    /usr/bin/qvim --nofork $@
fi
