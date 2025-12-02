# Konfigurasi interface network dan routing untuk AnduinBanks
cat << EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.233.0.10
    netmask 255.255.255.252

auto eth1
iface eth1 inet static
    address 192.233.0.129
    netmask 255.255.255.128

EOF

echo "nameserver 192.168.122.1" > /etc/resolv.conf

echo 1 > /proc/sys/net/ipv4/ip_forward
route add default gw 192.233.0.9
route add -net 192.233.0.0 netmask 255.255.255.252 gw 192.233.0.9 
route add -net 192.233.0.4 netmask 255.255.255.252 gw 192.233.0.9 
route add -net 192.233.0.8 netmask 255.255.255.252 gw 192.233. 
route add -net 192.233.0.12 netmask 255.255.255.252 gw 192.233.0.9 
route add -net 192.233.0.128 netmask 255.255.255.128 gw 192.233. 
route add -net 192.233.1.0 netmask 255.255.255.0 gw 192.233.0.9 
route add -net 192.233.0.16 netmask 255.255.255.252 gw 192.233.0.9 
route add -net 192.233.0.20 netmask 255.255.255.252 gw 192.233.0.9 
route add -net 192.233.0.24 netmask 255.255.255.252 gw 192.233.0.9 
route add -net 192.233.0.64 netmask 255.255.255.192 gw 192.233.0.9 
route add -net 192.233.0.32 netmask 255.255.255.248 gw 192.233.0.9 
route add -net 192.233.0.28 netmask 255.255.255.252 gw 192.233.0.9 
route add -net 192.233.0.40 netmask 255.255.255.248 gw 192.233.0.9 

apt update
apt install isc-dhcp-relay -y

nano /etc/default/isc-dhcp-relay
SERVERS="192.233.0.43"
INTERFACES="eth0 eth1"
OPTIONS=""

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

sysctl -p
service isc-dhcp-relay restart