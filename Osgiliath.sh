auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 192.168.220.13
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 192.168.220.10
    netmask 255.255.255.252

auto eth3
iface eth3 inet static
    address 192.168.220.17
    netmask 255.255.255.252
