#!/bin/bash

set -e
echo "dpkg"
dpkg --add-architecture i386
echo "apt update"
apt-get update
echo "install liberis"
apt-get install gcc-multilib libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386 libc6:i386 wget screen
echo "making dir"
mkdir steam
cd steam
echo "downloading steam cmd"
wget http://media.steampowered.com/client/steamcmd_linux.tar.gz
tar xfvz steamcmd_linux.tar.gz
echo "downloading csgo"
./steamcmd.sh +login anonymous +force_install_dir ./csgo_server/ +app_update 740 validate +quit
