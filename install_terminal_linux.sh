# Fail on any command.
set -euxo pipefail

# Install ZSH
sudo dnf install -y git-core zsh curl --allowerasing
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
