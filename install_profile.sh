#!/bin/bash
echo $SHELL
echo $PATH
set -eux pipefail

# Check if direnv is installed
if ! command -v direnv &>/dev/null; then
    echo "direnv is not installed. Installing..."

    # Install direnv using the appropriate package manager for your system
    if command -v dnf &>/dev/null; then
        sudo dnf install direnv -y
    elif command -v apt-get &>/dev/null; then
        sudo apt-get install direnv -y
    else
        echo "Unsupported package manager. Please install direnv manually."
        exit 1
    fi

    echo "direnv has been installed."
fi

# Check if pyenv is installed
if ! command -v pyenv &>/dev/null; then
    echo "pyenv is not installed. Installing..."
        # Check if .pyenv folder already exists, and if yes, delete it
    if [ -d "$HOME/.pyenv" ]; then
        echo "Found existing .pyenv folder. Deleting..."
        rm -rf ~/.pyenv
    fi
    # Clone pyenv from GitHub
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv


    echo "pyenv has been installed. Please reopen your terminal."
    exit 0
fi

echo "Both pyenv and direnv are installed."

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

# Check if Powerlevel10k is installed
if ! command -v p10k &>/dev/null; then
    echo "Powerlevel10k is not installed. Installing..."
    if [ ! -d "$HOME/powerlevel10k" ]; then
        # Install Powerlevel10k by cloning the repository
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    fi
    echo "Powerlevel10k has been installed. Please reopen your terminal. Run: p10k configure to configure powerlevel10k from start"
    exit 0
fi
# Function to create a backup (.bak) of a file if it exists
backup_file() {
    if [ -f "$1" ]; then
        mv "$1" "$1.bak"
        echo "Backed up $1 to $1.bak"
    fi
}

# Backup existing configuration files if they exist
backup_file ~/.zshrc
backup_file ~/.p10k.zsh
backup_file ~/.vimrc
backup_file ~/.zprofile
# Replace the configs with the saved one.
sudo cp configs/.zshrc ~/.zshrc
sudo cp configs/.p10k.zsh ~/.p10k.zsh
sudo cp configs/.vimrc ~/.vimrc
sudo cp configs/.zprofile ~/.zprofile
source ~/.zprofile
source ~/.zshrc
source ~/.p10k.zsh

# Switch the shell.
chsh -s $(which zsh)
echo "Zsh setup and configuration completed."