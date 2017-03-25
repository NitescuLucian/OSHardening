#!/bin/bash
blue=`tput setaf 2`
red=`tput setaf 1`
yellow=`tput setaf 3`
reset=`tput setaf 7`
mkdir OSHardeningLogs

#System update date & Instalations
echo "${yellow}Would you like to update your system and tools? (y/n)${reset}"
read foo
if [ "$foo" = "y" ]; then
apt-get clean
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get install chkrootkit
apt-get install lynis
apt-get -f install
apt-get install lynis
apt-get install rkhunter
rkhunter --update
sudo apt-get install ufw
apt-get autoremove
fi

#Authentification security
echo "${blue}Please change your password for this user!${reset}"
passwd
echo "${blue}Checking for users with no password. Log will be saved in ./OSHardeningLogs/no_password_users.txt.${reset}"
cat /etc/shadow | awk -F: '($2==""){print $1}'
cat /etc/shadow | awk -F: '($2==""){print $1}' > ./OSHardeningLogs/no_password_users.txt

#Network Security
echo "${blue}Please replace your hostname (save & close)."
leafpad /etc/hostname
echo "${blue}Please redifine your host according to your new/previous hostname (save & close).${reset}"
leafpad /etc/hosts
echo "${blue}Checking for all open ports. Log will be saved in ./OSHardeningLogs/open_ports_log.txt.${reset}"
netstat -tulpn
netstat -tulpn > ./OSHardeningLogs/open_ports_log.txt
echo "${yellow}Please close unwanted ports using iptables -A INPUT -p tcp --dport PORT_NUMBER -j DROP or with UFW Firewall Rules.${reset}"
echo "${blue}Checking iptables. Log will be saved in ./OSHardeningLogs/iptables_log.txt${reset}"
iptables -L -n -v > ./OSHardeningLogs/iptables_log.txt
echo "${blue}Checking local firewall status. Log will be saved in ./OSHardeningLogs/ufw_log.txt${reset}"
sudo ufw status verbose
sudo ufw status verbose > ./OSHardeningLogs/ufw_log.txt
echo "${yellow}Would you like to block all ports? (without SSH)) (y/n)${reset}"
read foa
if [ "$foa" = "y" ]; then
sudo ufw allow ssh
sudo ufw enable
fi
echo "${yellow}Ignore ICMP Request ${reset}"
echo net.ipv4.icmp_echo_ignore_all = 1 >> /etc/sysctl.conf
echo "${yellow}Ignore Broadcast Request ${reset}"
echo net.ipv4.icmp_echo_ignore_broadcasts = 1 >> /etc/sysctl.conf
sysctl -p

#Log management
echo "${yellow}Would you like to copy all system logs in ./SystemLogs? (y/n)${reset}"
read foc
if [ "$foc" = "y" ]; then
mkdir SystemLogs
cp /var/log/syslog ./SystemLogs/syslog
cp /var/log/messages ./SystemLogs/messages
cp /var/log/auth.log ./SystemLogs/auth.log
cp /var/log/kern.log ./SystemLogs/kern.log
#cp /var/log/cron.log ./SystemLogs/cron.log
#cp /var/log/mail.log ./SystemLogs/mail.log
#cp /var/log/boot.log ./SystemLogs/boot.log
#cp /var/log/mysqld.log ./SystemLogs/mysqld.log
#cp /var/log/secure ./SystemLogs/secure
#cp /var/log/utmp ./SystemLogs/utmp
cp /var/log/wtmp ./SystemLogs/wtmp
#cp /var/log/yum.log ./SystemLogs/yum.log
cp /var/log/apt/history.log ./SystemLogs/apt_history.log
#cp /var/log/dist-upgrade/apt.log ./SystemLogs/apt.log
#cp /var/log/apport.log ./SystemLogs/apport.log
fi

#Aditional System Security Audits
echo "${blue}Running chkrootkit. Wait! Log will be saved in ./OSHardeningLogs/chkrootkit_log.txt.${reset}"
sudo chkrootkit > ./OSHardeningLogs/chkrootkit_log.txt
echo "${blue}Running lynis. Wait! Log will be saved in ./OSHardeningLogs/lynis_log.txt.${reset}"
lynis audit system -Q > ./OSHardeningLogs/lynis_log.txt
echo "${blue}Running rkhunter. Wait!${reset}"
rkhunter -c
