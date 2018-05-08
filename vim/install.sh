#!/bin/bash

source ./scripts/utils.sh

p_header "Configuring neovim..."

WORKDIR=$(pwd)

mkdir -p ~/.config/nvim/
mkdir -p ~/.vim/autoload/

ln -sf ${WORKDIR}/vim/init.vim ~/.config/nvim/init.vim
ln -sf ${WORKDIR}/vim/autoload/plug.vim ~/.vim/autoload/plug.vim

if [[ $? -ne 0 ]]; then
    p_error "Configuration failed!"
    exit 1
fi

p_success "Success."
