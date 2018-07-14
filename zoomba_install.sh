#!/bin/bash
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

sudo git clone https://github.com/zoombacoin/zoomba 
sudo chmod -R 755 ~/zoomba 
cd zoomba 
sudo ./autogen.sh 
sudo ./configure --disable-tests --disable-gui-tests 
sudo make 
sudo make install 
sudo mkdir ~/.zoomba
sudo touch ~/.zoomba/zoomba.conf 
GREEN='\033[0;32m'
NC='\033[0m'
echo -e {GREEN}"Please Enter Your Masternodes Private Key:"{NC}
read privkey
echo -e "rpcuser=dsfjkdsui3874djnaiksk\nrpcpassword=dskasiue98873kjeih87iakj\nrpcallowip=127.0.0.1\ndaemon=1\nserver=1\nlisten=1\nmasternode=1\nlogtimestamps=1\nmaxconnections=256\nmasternodeprivkey=$privkey\nexternalIP=$(hostname  -I | cut -f1 -d' '):5330" >> ~/.zoomba/zoomba.conf 
zoombad -daemon