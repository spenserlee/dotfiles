#!/bin/bash

##
# @file     start.sh
# @author   Spenser Lee
#
# Install all the dotfiles.
##

if [[ $OSTYPE =~ "linux-gnu" ]]; then
    ./scripts/programs.sh
    ./scripts/install-all.sh
else
    echo "Untested on ${OSTYPE}"
fi
