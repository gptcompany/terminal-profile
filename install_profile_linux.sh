#!/bin/bash
current_user=$(whoami)
echo "Current user: $current_user"
echo "Current shell: $SHELL"
echo "Current PATH: $PATH"

# Check if direnv is installed
if ! command -v direnv &>/dev/null; then
    echo "direnv is not installed. Installing..."
    curl -sfL https://direnv.net/install.sh | bash
    eval "$(direnv hook zsh)"
    eval "$(direnv hook bash)"
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
    
fi

echo "Both pyenv and direnv are installed."

# Install plug-ins (you can git-pull to update them later).
# Define the plugin directories
syntax_highlighting_dir=$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
autosuggestions_dir=$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

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
# Check if Poetry is installed
if ! command -v poetry &>/dev/null; then
    echo "Poetry is not installed. Installing..."

    # Install Poetry using the official installation script
    curl -sSL https://install.python-poetry.org | python3 -
    
    echo "Poetry has been installed."
fi
# Check if Powerlevel10k is installed
if ! command -v p10k &>/dev/null; then
    echo "Powerlevel10k is not installed. Installing..."
    if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        # Install Powerlevel10k by cloning the repository
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    fi
    echo "Powerlevel10k has been installed. Please reopen your terminal. Run: p10k configure to configure powerlevel10k from start"
    
fi
# Function to create a backup (.bak) of a file if it exists
backup_file() {
    if [ -f "$1" ]; then
        mv "$1" "$1.bak"
        echo "Backed up $1 to $1.bak"
    fi
}

# Backup existing configuration files if they exist
backup_file $HOME/.zshrc
backup_file $HOME/.p10k.zsh
backup_file $HOME/.zprofile
# Replace the configs with the saved one.
sudo cp configs/linux/.zshrc $HOME/.zshrc
sudo cp configs/linux/.p10k.zsh $HOME/.p10k.zsh
sudo cp configs/linux/.zprofile $HOME/.zprofile
sudo sh -c 'echo "export PATH=\"$HOME/.local/share/pypoetry/venv/bin:\$PATH\"" >> ~/.zshrc'
sudo sh -c 'echo "export PATH=\"$HOME/powerlevel10k:\$PATH\"" >> ~/.zshrc'
eval "$(direnv hook zsh)"
source $HOME/.zprofile
source $HOME/.p10k.zsh
source $HOME/.zshrc
# Switch the shell.
sudo yum install passwd -y

# Attempt to change the default shell using chsh
if command -v chsh &>/dev/null; then
    sudo chsh -s $(which zsh) "$current_user"
    if [ $? -eq 0 ]; then
        echo "Shell changed to Zsh using chsh."
    else
        echo "chsh command failed, falling back to usermod..."
        sudo usermod -s $(which zsh) "$current_user"
        echo "Shell changed to Zsh using usermod."
    fi
else
    echo "chsh command not found. Falling back to usermod..."
    sudo usermod -s $(which zsh) "$current_user"
    echo "Shell changed to Zsh using usermod."
fi
eval "$(direnv hook zsh)"
eval "$(direnv hook bash)"
echo "Zsh setup and configuration completed."