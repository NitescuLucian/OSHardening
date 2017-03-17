#!/bin/bash
blue=`tput setaf 2`
red=`tput setaf 1`
yellow=`tput setaf 3`
reset=`tput setaf 7`
echo "${yellow}Would you like to update your system and tools? (y/n)${reset}" 
read foo
#System update date & Instalations
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
fi

#Authentification security
echo "${blue}Please change your password for this user!${reset}"
passwd
echo "${blue}Checking for users with no password. Log will be saved in ./no_password_users.txt.${reset}"
cat /etc/shadow | awk -F: '($2==""){print $1}' 
cat /etc/shadow | awk -F: '($2==""){print $1}' > ./no_password_users.txt

#Network Security
echo "${blue}Please replace your hostname (save & close)."
gedit /etc/hostname
echo "${blue}Please redifine your host according to your new/previous hostname (save & close).${reset}"
gedit /etc/hosts
echo "${blue}Checking for all open ports. Log will be saved in ./open_ports_log.txt.${reset}"
netstat -tulpn
netstat -tulpn > ./open_ports_log.txt
echo "${yellow}Please close unwanted ports using iptables -A INPUT -p tcp --dport PORT_NUMBER -j DROP or with UFW Firewall Rules.${reset}" 
echo "${blue}Checking iptables. Log will be saved in ./iptables_log.txt${reset}"
iptables -L -n -v > ./iptables_log.txt
echo "${blue}Checking local firewall status. Log will be saved in ./ufw_log.txt${reset}"
sudo ufw status verbose
sudo ufw status verbose > ./ufw_log.txt
echo "${yellow}Would you like to block all ports? (without SSH) (y/n)${reset}" 
read foa
if [ "$foa" = "y" ]; then
sudo ufw allow ssh
sudo ufw enable
fi

#Specific System Security
echo "${yellow}Secureing shared memory, reboot will be needed.${reset}" 
echo "tmpfs     /run/shm     tmpfs     defaults,noexec,nosuid     0     0" >> /etc/fstab

#Aditional System Security Audit
echo "${blue}Running chkrootkit. Wait! Log will be saved in ./chkrootkit_log.txt.${reset}"
sudo chkrootkit > ./chkrootkit_log.txt
echo "${blue}Running lynis. Wait! Log will be saved in ./lynis_log.txt.${reset}"
lynis audit system > ./lynis_log.tx
echo "${blue}Running rkhunter. Wait!${reset}"
rkhunter -c

echo "${yellow}Would you like to reboot? (y/n)${reset}" 
read fob
if [ "$fob" = "y" ]; then
sudo reboot
fi
