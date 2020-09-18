# List all interfaces but ignore the mgmt interface
interfaces=$(ip link | awk -F: '$0 !~ "lo|vir|wl|ens3|^[^0-9]"{print $2;getline}')

for i in $interfaces; 
do 
ip link set dev $i up; 
done

node_name=$(hostname)

case $node_name in
Switch[1-5])
## If node is a switch

# Create OVS
ovs-vsctl add-br $node_name

# Add interfaces to OVS
for i in $interfaces; 
do 
ovs-vsctl add-port $node_name $i;
done

# Set OVS OpenFlow version
ovs-vsctl set bridge $node_name protocols=OpenFlow13

# Set controller
ovs-vsctl set-controller $node_name tcp:192.168.200.100

# Set IP to internal OVS interface
case $node_name in
S1)
ip add add dev $node_name 192.168.100.101/24
;;
S2)
ip add add dev $node_name 192.168.100.102/24
;;
S3)
ip add add dev $node_name 192.168.100.103/24
;;
S4)
ip add add dev $node_name 192.168.100.104/24
;;
S5)
ip add add dev $node_name 192.168.100.105/24
;;
esac
;;
Host1)
## If node is a host
ip add add dev ens4 10.0.0.1/24
;;
Host2)
## If node is a host
ip add add dev ens4 10.0.0.2/24
;;
Host3)
## If node is a host
ip add add dev ens4 10.0.0.3/24
;;
esac

