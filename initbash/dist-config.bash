#!/bin/bash

if [ ! -d  ~/.ssh ]; then
  mkdir ~/.ssh
fi

ln -sf $(pwd)/config/bashrc.bash ~/.bashrc
ln -sf $(pwd)/config/bashrc_functions.bash ~/.bashrc_functions
ln -sf $(pwd)/config/.tmux.conf ~
ln -sf $(pwd)/config/.vimrc ~/.vimrc
