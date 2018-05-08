#!/bin/bash

##
# @file     utils.sh
# @author   Spenser Lee
#
# Utility functions.
# Inspired by https://github.com/lawsmith/dotfiles/blob/master/script/utils.sh
##

p_header() {
    printf "\n$(tput setaf 7)%s$(tput sgr0)\n" "$@"
}

# Success logging
p_success() {
    printf "$(tput setaf 64)✓ %s$(tput sgr0)\n" "$@"
}

# Error logging
p_error() {
    printf "$(tput setaf 1)x %s$(tput sgr0)\n" "$@"
}

# Warning logging
p_warning() {
    printf "$(tput setaf 3)! %s$(tput sgr0)\n" "$@"
}

seek_confirm() {
    p_warning "$@"

    while true; do
        read -p "Continue? (y/n)" choice
        case "$choice" in
            [Yy] ) break;;
            [nN] ) exit 0;;
            * ) echo "";;
        esac
    done
}


