#!/bin/bash

source ./scripts/utils.sh

p_header "Configuring neovim..."

WORKDIR=$(pwd)

mkdir -p ~/.config/nvim/

ln -sf ${WORKDIR}/vim/init.vim ~/.config/nvim/init.vim

if [[ $? -ne 0 ]]; then
    p_error "Configuration failed!"
    exit 1
fi

p_success "Success."
