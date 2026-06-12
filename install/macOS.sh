#!/usr/bin/env bash

if [[ $(command -v brew) == "" ]]; then
    echo "Installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

BREW="brew install --quiet --yes"

echo "Installing macOS applications and tools"
$BREW \
  starship \
  tmux \
  vim \
  zsh-autosuggestions \
  zsh-syntax-highlighting

echo "Installing font for starship prompt and VSCode"
$BREW --cask font-meslo-lg-nerd-font

echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | PROFILE=/dev/null bash
