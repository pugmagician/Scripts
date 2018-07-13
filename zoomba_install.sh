#!/bin/bash
apt-get update 
apt-get -y upgrade
apt-get -y install software-properties-common 
apt-get -y install build-essential  
apt-get -y install libtool autotools-dev autoconf automake  
apt-get -y install libssl-dev 
apt-get -y install libevent-dev 
apt-get -y install libboost-all-dev 
apt-get -y install pkg-config  
add-apt-repository ppa:bitcoin/bitcoin 
apt-get update 
apt-get -y install libdb4.8-dev 
apt-get -y install libdb4.8++-dev 
apt-get -y install libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0-5 
apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev
apt-get -y install libqrencode-dev bsdmainutils 
apt install git 
cd /var 
touch swap.img 
chmod 600 swap.img 
dd if=/dev/zero of=/var/swap.img bs=1024k count=2000 
mkswap /var/swap.img 
swapon /var/swap.img 
echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd ~ 

git clone https://github.com/zoombacoin/zoomba 
chmod -R 755 ~/zoomba 
cd zoomba 
./autogen.sh 
./configure --disable-tests --disable-gui-tests 
make 
make install 
mkdir ~/.zoomba
touch ~/.zoomba/zoomba.conf 
ip=`ifconfig|xargs|awk '{print $7}'|sed -e 's/[a-z]*:/''/'`
echo "Please Enter Your Masternodes Private Key: "
read privkey
echo -e "rpcuser=dsfjkdsui3874djnaiksk\nrpcpassword=dskasiue98873kjeih87iakj\nrpcallowip=127.0.0.1\ndaemon=1\nserver=1\nlisten=1\nmasternode=1\nlogtimestamps=1\nmaxconnections=256\nmasternodeprivkey=$privkey\nexternalIP=$ip:5330" >> ~/.zoomba/zoomba.conf 
zoombad -daemon