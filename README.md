# OSHardening
Multiple OS Hardening Scripts.

Clone repository
```
git clone https://github.com/NitescuLucian/OSHardening.git
```
Navigate to the repository folder
```
cd OSHardening
```
Choose your OS from the following:
* [Kali Linux](#kali-linux)
* [Ubuntu 16.04 LTS](#ubuntu-1604-lts)

## Kali Linux
Give execution permission to the fille.
```
chmod +x ./kali.sh
```
Execute.
```
./kali.sh
```
Review cli and log filles and make your changes according to your preferences.

In this OS I did not cover the following steps:
* Adding a non-root user.
* Log management
* Closeing open ports (iptables -A INPUT -p tcp --dport PORT_NUMBER -j DROP or UFW specific rules) 
* Local encryption

Problems might be caused by:
* UFW Firewall rules for specific tools within the Kali Linux

## Ubuntu 16.04 LTS
Give execution permission to the fille.
```
chmod +x ./ubuntu_16.04LTS.sh
```
Execute.
```
sudo ./ubuntu_16.04LTS.sh
```
Review cli and log filles and make your changes according to your preferences.

In this OS I did not cover the following steps:
* Adding a non-root user.
* Log management
* Closeing open ports (iptables -A INPUT -p tcp --dport PORT_NUMBER -j DROP or UFW specific rules) 
* Local encryption

Problems might be caused by:
* UFW Firewall rules for specific tools within the Kali Linux
