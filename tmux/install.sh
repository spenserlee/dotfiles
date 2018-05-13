#!/bin/bash

source ./scripts/utils.sh

p_header "Configuring tmux..."

WORKDIR=$(pwd)

mkdir -p ~/.config/nvim/

ln -sf ${WORKDIR}/tmux/tmux.conf ~/.tmux.conf

if [ $? -ne 0 ]; then
    p_error "Configuration failed!"
    exit 1
fi

p_success "Success."
