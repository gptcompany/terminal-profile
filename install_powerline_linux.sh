# Fail on any command.
set -euxo pipefail

# Install Powerline for VIM.
sudo dnf install -y python3-pip
sudo yum install git
pip3 install --user powerline-status
sudo cp configs/.vimrc ~/.vimrc
# Create a temporary directory and clone Powerline fonts into it.
temp_fonts_dir=$(mktemp -d)
git clone https://github.com/powerline/fonts.git --depth=1 "$temp_fonts_dir/fonts"
cd "$temp_fonts_dir/fonts"
./install.sh

# Clean up: remove the temporary directory.
cd ~
rm -rf "$temp_fonts_dir"

# Install Patched Font
mkdir ~/.fonts
sudo cp -a fonts/. ~/.fonts/
fc-cache -vf ~/.fonts/