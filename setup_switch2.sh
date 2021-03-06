#!/bin/bash

# List all interfaces but ignore the mgmt interface
interfaces=$(ip link | awk -F: '$0 !~ "lo|vir|wl|ens3|^[^0-9]"{print $2;getline}')

for i in $interfaces; 
do 
sudo ip link set dev $i up; 
done

node_name=$(hostname)

case $node_name in
S[1-5])
## If node is a switch

# Create OVS
sudo ovs-vsctl add-br $node_name

# Add interfaces to OVS
for i in $interfaces; 
do 
sudo ovs-vsctl add-port $node_name $i;
done

# Set OVS OpenFlow version
sudo ovs-vsctl set bridge $node_name protocols=OpenFlow13

# Set controller
sudo ovs-vsctl set-controller $node_name tcp:192.168.100.100

# Set IP to internal OVS interface
case $node_name in
S1)
sudo ip add add dev $node_name 192.168.100.101/24
sudo ip link set dev $node_name up
;;
S2)
sudo ip add add dev $node_name 192.168.100.102/24
sudo ip link set dev $node_name up
;;
S3)
sudo ip add add dev $node_name 192.168.100.103/24
sudo ip link set dev $node_name up
;;
S4)
sudo ip add add dev $node_name 192.168.100.104/24
sudo ip link set dev $node_name up
;;
S5)
sudo ip add add dev $node_name 192.168.100.105/24
sudo ip link set dev $node_name up
;;
esac
;;
H)
## If node is a host
sudo ip add add dev ens4 10.0.0.1/24
sudo ip link set dev ens4 up
;;
H2)
## If node is a host
sudo ip add add dev ens4 10.0.0.2/24
sudo ip link set dev ens4 up
;;
H3)
## If node is a host
sudo ip add add dev ens4 10.0.0.3/24
sudo ip link set dev ens4 up
;;
esac


