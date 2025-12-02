# Konfigurasi DNS Server dan Firewall untuk Narya
cat << EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.233.0.42
    netmask 255.255.255.248
    gateway 192.233.0.41

EOF

echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt update
apt install bind9 -y

nano /etc/bind/named.conf.local
zone "k44.com" {
    type master;
    file "/etc/bind/k44.com";
};

zone "0.89.10.in-addr.arpa" {
	type master;
    file "/etc/bind/0.89.10.in-addr.arpa";
};

nano /etc/bind/k44.com
$TTL    604800          ; Waktu cache default (detik)
@       IN      SOA     k44.com. root.k44.com. (
                        2025100401 ; Serial (format YYYYMMDDXX)
                        604800     ; Refresh (1 minggu)
                        86400      ; Retry (1 hari)
                        2419200    ; Expire (4 minggu)
                        604800 )   ; Negative Cache TTL
;

@         IN      NS      k44.com.
@       IN      A       192.233.0.42

nano /etc/bind/0.89.10.in-addr.arpa
$TTL    604800          ; Waktu cache default (detik)
@       IN      SOA     k44.com. root.k44.com. (
                        2025100401 ; Serial (format YYYYMMDDXX)
                        604800     ; Refresh (1 minggu)
                        86400      ; Retry (1 hari)
                        2419200    ; Expire (4 minggu)
                        604800 )   ; Negative Cache TTL
;

0.89.10.in-addr.arpa.       IN      NS      k44.com.
42       IN      PTR     k44.com.


ln -s /etc/init.d/named /etc/init.d/bind9
service bind9 restart

# Firewall DNS
apt install -y iptables
iptables -A INPUT -p udp --dport 53 -s 192.233.0.43 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -s 192.233.0.43 -j ACCEPT
iptables -A INPUT -p udp --dport 53 -j DROP
iptables -A INPUT -p tcp --dport 53 -j DROP

iptables -L INPUT --line-numbers
iptables -D INPUT 1