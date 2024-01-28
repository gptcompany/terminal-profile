# Fail on any command.
set -euxo pipefail

# Install Powerline for VIM.
sudo dnf install -y python3-pip
sudo yum install git
pip3 install --user powerline-status
sudo cp configs/.vimrc ~/.vimrc
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
# Install Patched Font
mkdir ~/.fonts
sudo cp -a fonts/. ~/.fonts/
fc-cache -vf ~/.fonts/