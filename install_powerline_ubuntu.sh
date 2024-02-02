# Fail on any command.
set -eux pipefail
sudo apt-get upgrade -y
# Install Powerline for VIM.
sudo apt-get install -y python3-pip
pip3 install --user powerline-status
#sudo cp configs/.vimrc ~/.vimrc
sudo apt-get install fonts-powerline -y

# Install Patched Font
mkdir ~/.fonts
sudo cp -a fonts/. ~/.fonts/
fc-cache -vf ~/.fonts/