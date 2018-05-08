#!/bin/bash

source ./scripts/utils.sh

p_header "Configuring system files..."

WORKDIR=$(pwd)

ln -sf ${WORKDIR}/system/.bashrc ~/.bashrc

if [[ $? -ne 0 ]]; then
    p_error "Configuration failed!"
    exit 1
fi

p_success "Success."
