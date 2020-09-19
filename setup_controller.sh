#!/bin/bash

# Set IP to controller:
sudo ip add add dev ens4 192.168.100.100/24

wget https://github.com/floodlight/floodlight/archive/v1.2.zip

#sudo apt install unzip

unzip v1.2.zip

cd floodlight-1.2 && ant
