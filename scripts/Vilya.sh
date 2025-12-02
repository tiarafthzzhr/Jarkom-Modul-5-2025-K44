# Konfigurasi DHCP Server dan Firewall untuk Vilya
cat << EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.233.0.43
    netmask 255.255.255.248
    gateway 192.233.0.41

EOF

echo "nameserver 192.168.122.1" > /etc/resolv.conf

# DHCP Server
apt update
apt install isc-dhcp-server -y

nano /etc/default/isc-dhcp-server
INTERFACESv4="eth0"

nano /etc/dhcp/dhcpd.conf
subnet 192.233.0.40 netmask 255.255.255.248 {
}

subnet 192.233.0.32 netmask 255.255.255.248 {
    range 192.233.0.33 192.233.0.38;
    option routers 192.233.0.33;
    option broadcast-address 192.233.0.39;
    option domain-name-servers 192.168.122.1;
    default-lease-time 600;
    max-lease-time 3600;
}

subnet 192.233.0.64 netmask 255.255.255.192 {
    range 192.233.0.65 192.233.0.126;
    option routers 192.233.0.65;
    option broadcast-address 192.233.0.127;
    option domain-name-servers 192.168.122.1;
    default-lease-time 600;
    max-lease-time 3600;
}

subnet 192.233.0.128 netmask 255.255.255.128 {
    range 192.233.0.129 192.233.0.254;
    option routers 192.233.0.129;
    option broadcast-address 192.233.0.255;
    option domain-name-servers 192.168.122.1;
    default-lease-time 600;
    max-lease-time 3600;
}
subnet 192.233.1.0 netmask 255.255.255.0 {
    range 192.233.1.1 192.233.1.254;
    option routers 192.233.1.1;
    option broadcast-address 192.233.1.255;
    option domain-name-servers 192.168.122.1;
    default-lease-time 600;
    max-lease-time 3600;
}


service isc-dhcp-server restart


apt install -y iptables
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP