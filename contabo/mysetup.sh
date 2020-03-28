#!/bin/bash
# github.com/mamutal91
# https://www.youtube.com/channel/UCbTjvrgkddVv4iwC9P2jZFw

# sudo useradd -m -G wheel -s /bin/bash mamutal91 && sudo chmod +x /home/mamutal91 && sudo chown -R mamutal91:mamutal91 /home/mamutal91 && sudo chmod +x /home/mamutal91 && sudo passwd mamutal91

# Config system
USER=mamutal91
mkdir -p $HOME/.ccache
mkdir -p $HOME/.pull_rebase

sudo chown -R $USER:$USER /home/$USER
git config --global user.email "mamutal91@gmail.com"
git config --global user.name "Alexandre Rangel"

# nginx
sudo mkdir -p $HOME/.mamutal91/building
sudo chown -R mamutal91:mamutal91 $HOME/.mamutal91/building
sudo chmod -R 755 $HOME/.mamutal91/building

# Set color in pacman
sudo sed -i "s/#Color/Color/g" /etc/pacman.conf

# Set date
sudo ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

PACKAGES='
  nano
  reflector zsh
  '
sudo pacman -Syy $PACKAGES --noconfirm --needed --color auto

AUR='
  zsh-syntax-highlighting
  '
yay -S $AUR --needed --noconfirm --color auto

sudo reflector -c Germany --save /etc/pacman.d/mirrorlist

# Install oh-my-zsh
# rm -rf $HOME/.oh-my-zsh && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
