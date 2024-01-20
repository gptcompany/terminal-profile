#!/bin/bash
echo $SHELL
echo $PATH
set -eux pipefail

# Install plug-ins (you can git-pull to update them later).
# Define the plugin directories
syntax_highlighting_dir=~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
autosuggestions_dir=~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Check if the directories already exist and are not empty
if [ -d "$syntax_highlighting_dir" ] && [ -n "$(ls -A $syntax_highlighting_dir)" ]; then
    echo "zsh-syntax-highlighting directory is not empty. Skipping clone."
else
    # Clone the zsh-syntax-highlighting repository
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$syntax_highlighting_dir"
fi

if [ -d "$autosuggestions_dir" ] && [ -n "$(ls -A $autosuggestions_dir)" ]; then
    echo "zsh-autosuggestions directory is not empty. Skipping clone."
else
    # Clone the zsh-autosuggestions repository
    git clone https://github.com/zsh-users/zsh-autosuggestions "$autosuggestions_dir"
fi

# Replace the configs with the saved one.
sudo cp configs/.zshrc ~/.zshrc
sudo cp configs/.p10k.zsh ~/.p10k.zsh
sudo cp configs/.vimrc ~/.vimrc
sudo cp configs/.zprofile ~/.zprofile
. ~/.vimrc
. ~/.zprofile
. ~/.zshrc
. ~/.p10k.zsh

# Switch the shell.
chsh -s $(which zsh)
echo "Zsh setup and configuration completed."