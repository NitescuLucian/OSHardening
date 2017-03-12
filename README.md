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

## Kali Linux
Give execution permission to the fille.
```
chmod +x ./kali.sh
```
Execute.
```
./kali.sh
```
Review log filles and close unwanted open ports (iptables -A INPUT -p tcp --dport PORT_NUMBER -j DROP ).
