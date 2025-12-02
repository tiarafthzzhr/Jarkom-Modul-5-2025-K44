cat << EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 192.233.0.29
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 192.233.0.17
    netmask 255.255.255.252

auto eth3
iface eth3 inet static
    address 192.233.0.1
    netmask 255.255.255.252

EOF

$IP_INTERFACE_NAT=$(ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1)
while true; do
    IP_INTERFACE_NAT=$(ip -4 addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1)
    if [ -n "$IP_INTERFACE_NAT" ]; then
        break
    fi
    sleep 1
done
iptables -t nat -A POSTROUTING -s 192.233.0.0/16 -o eth0 -j SNAT --to-source $IP_INTERFACE_NAT
route add -net 192.233.0.0 netmask 255.255.255.252 gw 192.233.2
route add -net 192.233.0.4 netmask 255.255.255.252 gw 192.233.0.2 
route add -net 192.233.0.8 netmask 255.255.255.252 gw 192.233.0.2 
route add -net 192.233.0.12 netmask 255.255.255.252 gw 192.233.0.2 
route add -net 192.233.0.128 netmask 255.255.255.128 gw 192.233.0.2 
route add -net 192.233.1.0 netmask 255.255.255.0 gw 192.233.0.2 
route add -net 192.233.0.16 netmask 255.255.255.252 gw 192.233. 
route add -net 192.233.0.20 netmask 255.255.255.252 gw 192.233.0.18 
route add -net 192.233.0.24 netmask 255.255.255.252 gw 192.233.0.18 
route add -net 192.233.0.64 netmask 255.255.255.192 gw 192.233.0.18 
route add -net 192.233.0.32 netmask 255.255.255.248 gw 192.233.0.18 
route add -net 192.233.0.28 netmask 255.255.255.252 gw 192.233. 
route add -net 192.233.0.40 netmask 255.255.255.248 gw 192.233.0.30 

# DHCP Relay
apt update
apt install isc-dhcp-relay -y

nano /etc/default/isc-dhcp-relay
SERVERS="192.233.0.43"
INTERFACES="eth1 eth2 eth3"
OPTIONS=""

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

sysctl -p
service isc-dhcp-relay restart