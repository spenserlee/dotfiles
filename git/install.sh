#!/bin/bash

source ./scripts/utils.sh

p_header "Configuring Git..."

WORKDIR=$(pwd)

ln -sf ${WORKDIR}/git/.gitconfig ~/.gitconfig

if [[ $? -ne 0 ]]; then
    p_error "Configuration failed!"
    exit 1
fi

p_success "Success."
