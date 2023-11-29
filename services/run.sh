#!/bin/bash

# Otwarcie portu 80 dla serwera WWW (nginx)
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Otwarcie portu 25 dla serwera pocztowego (Postfix)
sudo iptables -A INPUT -p tcp --dport 25 -j ACCEPT

# Otwarcie portu 21 dla serwera plików (vsftpd)
sudo iptables -A INPUT -p tcp --dport 21 -j ACCEPT

# Otwarcie portu 3306 dla serwera bazy danych (MySQL)
sudo iptables -A INPUT -p tcp --dport 3306 -j ACCEPT

# Otwarcie portu 443 dla serwera WWW HTTPS
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Otwarcie portu 8080 dla phpMyAdmin
sudo iptables -A INPUT -p tcp --dport 8080 -j ACCEPT

# Zapisanie zmian w konfiguracji iptables
sudo sh -c 'iptables-save > /etc/iptables.rules'

sudo systemctl enable netfilter-persistent
sudo systemctl start netfilter-persistent