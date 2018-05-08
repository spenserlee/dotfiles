#!/bin/bash

##
# @file     start.sh
# @author   Spenser Lee
#
# Install all the dotfiles.
##

INSTALL_PROGRAMS=true

# argument parsing
POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -h|--help)
            echo "TODO"
            exit 1
            ;;
        -s|--skip-programs)
            INSTALL_PROGRAMS=false
            shift   # past argument
            ;;
        *)      # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift # past argument
            ;;
    esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ $OSTYPE =~ "linux-gnu" ]]; then

    if [[ "$INSTALL_PROGRAMS" == true ]]; then
        ./scripts/programs.sh
    fi

    ./scripts/install-all.sh
else
    echo "Untested on ${OSTYPE}"
fi
