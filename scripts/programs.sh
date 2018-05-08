#!/bin/bash

source ./scripts/utils.sh

##
# @file     programs.sh
# @author   Spenser Lee
#
# Install some programs.
##

p_header "Adding neovim PPA..."

grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep neovim

if [ $? -eq 0 ]; then
    p_success "PPA already present."
else
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

p_header "Installing neovim..."
sudo apt-get install neovim --yes

if [ $? -eq 0 ]; then
    p_success "Success."
else
    p_error "Failed to install neovim. Exiting..."
    exit 1
fi

p_header "Installing tmux..."
sudo apt-get install tmux --yes

if [ $? -eq 0 ]; then
    p_success "Success."
else
    p_error "Failed to install tmux. Exiting..."
    exit 1
fi

p_header "Installing htop..."
sudo apt-get install htop --yes

if [ $? -eq 0 ]; then
    p_success "Success."
else
    p_error "Failed to install htop. Exiting..."
    exit 1
fi

