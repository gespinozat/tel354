#!/bin/bash

node_name=$(hostname)

case $node_name in
S1)

## Switch 1
# Create OVS
sudo ovs-vsctl add-br $node_name
# Add interfaces to OVS
for i in 4 5 6 7;
do
sudo ip link set dev ens$i up
sudo ovs-vsctl add-port $node_name ens$i;
done
# Set OVS OpenFlow version
sudo ovs-vsctl set bridge $node_name protocols=OpenFlow13

# Set controller
sudo ovs-vsctl set-controller $node_name tcp:192.168.200.200

# Set IP to internal OVS interface
sudo ip add add dev $node_name 192.168.200.201/24
sudo ip link set dev $node_name up

;;
S2)

## Switch 2
# Create OVS
sudo ovs-vsctl add-br $node_name
# Add interfaces to OVS
for i in 4 6;
do
sudo ip link set dev ens$i up
sudo ovs-vsctl add-port $node_name ens$i;
done
# Set OVS OpenFlow version
sudo ovs-vsctl set bridge $node_name protocols=OpenFlow13

# Set controller
sudo ovs-vsctl set-controller $node_name tcp:192.168.200.200

# Set IP to internal OVS interface
sudo ip add add dev $node_name 192.168.200.202/24
sudo ip link set dev $node_name up

;;
S3)

## Switch 3
# Create OVS
sudo ovs-vsctl add-br $node_name
# Add interfaces to OVS
for i in 4 6;
do
sudo ip link set dev ens$i up
sudo ovs-vsctl add-port $node_name ens$i;
done
# Set OVS OpenFlow version
sudo ovs-vsctl set bridge $node_name protocols=OpenFlow13

# Set controller
sudo ovs-vsctl set-controller $node_name tcp:192.168.200.200

# Set IP to internal OVS interface
sudo ip add add dev $node_name 192.168.200.203/24
sudo ip link set dev $node_name up

;;
S4)

## Switch 4
# Create OVS
sudo ovs-vsctl add-br $node_name
# Add interfaces to OVS
for i in 5 7;
do
sudo ip link set dev ens$i up
sudo ovs-vsctl add-port $node_name ens$i;
done
# Set OVS OpenFlow version
sudo ovs-vsctl set bridge $node_name protocols=OpenFlow13

# Set controller
sudo ovs-vsctl set-controller $node_name tcp:192.168.200.200

# Set IP to internal OVS interface
sudo ip add add dev $node_name 192.168.200.204/24
sudo ip link set dev $node_name up

;;
S5)

## Switch 5
# Create OVS
sudo ovs-vsctl add-br $node_name
# Add interfaces to OVS
for i in 4 5;
do
sudo ip link set dev ens$i up
sudo ovs-vsctl add-port $node_name ens$i;
done
# Set OVS OpenFlow version
sudo ovs-vsctl set bridge $node_name protocols=OpenFlow13

# Set controller
sudo ovs-vsctl set-controller $node_name tcp:192.168.200.200

# Set IP to internal OVS interface
sudo ip add add dev $node_name 192.168.200.205/24
sudo ip link set dev $node_name up

;;
H1)
sudo ip add add dev ens4 10.0.0.1/24
sudo ip link set dev ens4 up

;;
H2)
sudo ip add add dev ens4 10.0.0.2/24
sudo ip link set dev ens4 up

;;
H3)
sudo ip add add dev ens4 10.0.0.3/24
sudo ip link set dev ens4 up

;;
esac
