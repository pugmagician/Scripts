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

echo -e ${YELLOW}"Welcome to the Primestone Automated Install, Please Hit Enter or Input What is Asked."${NC}
echo
echo -e ${YELLOW}"You Will See alot of code flashing across your screen, don't be alarmed it's supposed to do that. This process can take up to an hour and may appear to be stuck, but I can promise you it's not."${NC}
echo
echo -e ${GREEN}"Do You Wish to Install a Primestone Masternode? type y/n followed by [ENTER]:"${NC}
read AGREE


if [[ $AGREE =~ "y" ]] ; then
echo -e ${GREEN}"Please Enter Your Masternodes Private Key:"${NC}
read privkey
sudo apt-get -y update 
sudo apt-get -y upgrade
sudo apt-get -y install software-properties-common 
sudo apt-get -y install build-essential  
sudo apt-get -y install libtool autotools-dev autoconf automake  
sudo apt-get -y install libssl-dev 
sudo apt-get -y install libevent-dev 
sudo apt-get -y install libboost-all-dev 
sudo apt-get -y install pkg-config  
sudo add-apt-repository ppa:bitcoin/bitcoin 
sudo apt-get update 
sudo apt-get -y install libdb4.8-dev 
sudo apt-get -y install libdb4.8++-dev 
sudo apt-get -y install libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0-5 
sudo apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev
sudo apt-get -y install libqrencode-dev bsdmainutils 
sudo apt install git 
cd /var 
sudo touch swap.img 
sudo chmod 600 swap.img 
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000 
sudo mkswap /var/swap.img 
sudo swapon /var/swap.img 
sudo echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd ~ 

sudo git clone https://github.com/pugmagician/primestone.git 
sudo chmod -R 755 ~/primestone 
cd primestone 
sudo ./autogen.sh 
sudo ./configure --disable-tests --disable-gui-tests 
sudo make 
sudo make install 
sudo mkdir ~/.primestonecore
sudo touch ~/.primestonecore/primestone.conf 
echo -e "rpcuser=dsfjkdsui3874djnaiksk\nrpcpassword=dskasiue98873kjeih87iakj\nrpcallowip=127.0.0.1\ndaemon=1\nserver=1\nlisten=1\nmasternode=1\nlogtimestamps=1\nmaxconnections=256\nmasternodeprivkey=$privkey\nexternalIP=$(hostname  -I | cut -f1 -d' '):19941" >> ~/.primestonecore/primestone.conf 
primestoned -daemon
cd ~
echo -e ${GREEN}"Congrats Your Masternode is Now Installed and Has Started, Please wait 5 Minutes before you start the Windows or Mac Side of your wallet to give the masternode time to sync."${NC}
fi