#!/bin/sh

# Helper script to correctly invoke Qvim with flag
if [ -z "$DISPLAY" ]; then
    /usr/bin/nvim $@
else
    /usr/bin/nvim-qt $@
fi
