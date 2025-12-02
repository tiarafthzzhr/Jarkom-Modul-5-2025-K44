cat << EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.233.0.22
    netmask 255.255.255.252
    gateway 192.233.0.21
    
EOF

echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt update
apt install -y apache2
service apache2 start
echo "<h1>Welcome to Ironhills</h1>" > /var/www/html/index.html
service apache2 restart

apt install iptables -y

iptables -A INPUT -s 192.233.0.32/29 -m time --weekdays Sat,Sun -j ACCEPT
iptables -A INPUT -s 192.233.0.64/26 -m time --weekdays Sat,Sun -j ACCEPT
iptables -A INPUT -s 192.233.1.0/24 -m time --weekdays Sat,Sun -j ACCEPT

iptables -A INPUT -s 192.233.0.32/29 -j DROP
iptables -A INPUT -s 192.233.0.64/26 -j DROP
iptables -A INPUT -s 192.233.1.0/24 -j DROP

iptables -A INPUT -j DROP

iptables -A INPUT -p tcp --syn --dport 80 -m connlimit --connlimit-above 3 --connlimit-mask 32 -j REJECT --reject-with tcp-reset

ab -n 50 -c 5 http://192.233.0.22/