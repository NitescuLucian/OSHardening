apt-get clean
apt-get update 
apt-get upgrade -y 
apt-get dist-upgrade -y
passwd
apt-get install chkrootkit
leafpad /etc/hostname
leafpad /etc/hosts
updatedb
cat /etc/shadow | awk -F: '($2==""){print $1}' > ./no_password_users.txt
echo Running chkrootkit. Wait!
sudo chkrootkit > ./chkrootkit_log.txt
apt-get install lynis
apt-get -f install
apt-get install lynis
echo Running lynis. Wait! 
lynis audit system > ./lynis_log.txt
netstat -tulpn > ./open_ports_log.txt
echo Close Unwanted Ports using: iptables -A INPUT -p tcp --dport PORT_NUMBER -j DROP 
iptables -L -n -v > ./iptables_log.txt
apt-get install rkhunter
rkhunter --update
rkhunter -c
sudo apt-get install ufw
sudo ufw allow ssh
sudo ufw enable
sudo ufw status verbose > ./ufw_log.txt
