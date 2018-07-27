#!/bin/bash

#Setup Variables
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
RED='\033[0;31m'
NC='\033[0m'

#Checking OS
if [[ $(lsb_release -d) != *16.04* ]]; then
  echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${NC}
  exit 1
fi

echo -e ${YELLOW}"This will Install an Update for Primestone"${NC}
echo
echo -e ${GREEN}"Do You Wish To Update? type y/n followed by [ENTER]:"${NC}
read AGREE


if [[ $AGREE =~ "y" ]] ; then

#Updating Files
sudo apt install -y unzip
primestone-cli stop
wget https://primestone.global/wp-content/uploads/2018/06/prime_linux.zip
chmod 755 prime_linux.zip
unzip -o prime_linux.zip
chmod 755 prime_linux
cd prime_linux
chmod 755 primestoned
chmod 755 primestone_cli
mv -f primestoned ~/../usr/local/bin
mv -f primestone-cli ~/../usr/local/bin
cd ~
rm -rf prime_linux.zip
rm -rf prime_linux
primestoned -daemon
echo -e ${GREEN}"You're wallet is now updated, you may need to restart the masternode from the Windows/MAC side now."${NC}
fi