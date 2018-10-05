#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

echo -e "${RED}Installation ...${NC}";

# Update & Upgrade

echo -e "${RED}Update and Upgrade${NC}";
apt-get update && apt-get upgrade;

# Install Terminator

echo -e "${RED}Install Terminator${NC}";
apt-get install terminator;

# Install Zim

echo -e "${RED}Install Zim${NC}";
git clone --recursive https://github.com/zimfw/zimfw.git ${ZDOTDIR:-${HOME}}/.zim

setopt EXTENDED_GLOB
for template_file in ${ZDOTDIR:-${HOME}}/.zim/templates/*; do
  user_file="${ZDOTDIR:-${HOME}}/.${template_file:t}"
  touch ${user_file}
  ( print -rn "$(<${template_file})$(<${user_file})" >! ${user_file} ) 2>/dev/null
done

source ${ZDOTDIR:-${HOME}}/.zlogin

# Install FW

echo -e "${RED}Install Firewall${NC}";

cp ./firewall.sh /etc/init.d/firewall.sh
ln -s /etc/init.d/firewall.sh /etc/rc0.d/K01firewall.sh

# Install Fish

echo -e "${RED}Install Fish${NC}";

apt-get install fish;
chsh -s /usr/bin/fish;
#mkdir -p ~/.config/fish;

# Set Aliases

echo -e "${RED}Set aliases${NC}";

echo "alias la='ls -al'" >> ~/.bashrc;
#echo "alias la='ls -al'" >> ~/.zshrc;
echo "alias ll='ls -l'" >> ~/.bashrc;
#echo "alias ll='ls -l'" >> ~/.zshrc;


source ~/.bashrc;
#source ~/.zshrc;


