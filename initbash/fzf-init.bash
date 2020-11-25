#!/bin/bash
# yes | ./resource_dirs/fzf/install

function fzin() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    yes | ~/.fzf/install
}

fzin
