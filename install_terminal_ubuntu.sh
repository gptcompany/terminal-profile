# Fail on any command.
set -eux pipefail
sudo apt-get update  # Update package lists
sudo apt-get install -y git zsh curl
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"