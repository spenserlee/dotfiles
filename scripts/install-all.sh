#!/bin/bash

##
# @file     install-all.sh
# @author   Spenser Lee
#
# Executes all the submodule install scripts.
##

find ./ \
    -maxdepth 2 \
    -not -path "*/script/*" \
    -type f \
    -name 'install.sh' \
    -exec ./{} \;
