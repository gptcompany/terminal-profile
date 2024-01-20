set -eux pipefail

# Install plug-ins (you can git-pull to update them later).
(cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-syntax-highlighting)
(cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-autosuggestions)
cd
# Replace the configs with the saved one.
sudo cp configs/.zshrc ~/.zshrc
sudo cp configs/.p10k.zsh ~/.p10k.zsh
sudo cp configs/.vimrc ~/.vimrc
sudo cp configs/.zprofile ~/.zprofile
source ~/.vimrc
source ~/.zprofile
source ~/.zshrc
source ~/.p10k.zsh
# Switch the shell.
chsh -s $(which zsh)