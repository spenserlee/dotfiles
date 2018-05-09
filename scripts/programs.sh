#!/bin/bash

source ./scripts/utils.sh

##
# @file     programs.sh
# @author   Spenser Lee
#
# Install some programs.
##

declare -a programs=("curl" "neovim" "tmux" "htop")

p_header "Adding neovim PPA..."

grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep neovim

if [ $? -eq 0 ]; then
    p_success "PPA already present."
else
    # debian doesn't have add-apt-repository by default
    sudo apt-get install software-properties-common --yes
    sudo add-apt-repository ppa:neovim-ppa/stable --yes

    if [ $? -eq 0 ]; then
        p_success "Success."
    else
        p_error "Failed to add PPA. Exiting..."
        exit 1
    fi
fi

p_header "Updating repositories..."

sudo apt-get update

if [ $? -eq 0 ]; then
    p_success "Success."
else
    p_error "Failed to update. Exiting..."
    exit 1
fi

for program in "${programs[@]}"
do
    p_header "Installing ${program}..."

    sudo apt-get install "$program" --yes

    if [ $? -eq 0 ]; then
        p_success "Success."
    else
        p_error "Failed to install ${program}. Exiting..."
    fi
done
