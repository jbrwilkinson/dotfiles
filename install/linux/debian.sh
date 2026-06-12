#!/usr/bin/env bash

echo "Installing packages"
sudo apt-get install --yes \
  docker \
  tmux \
  vim \
  zsh-autosuggestions \
  zsh-syntax-highlighting

# Starship prompt
curl -sS https://starship.rs/install.sh | sh
