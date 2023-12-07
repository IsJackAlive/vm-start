#!/bin/sh

apk add iptables

# Otwarcie portu 80 dla serwera WWW (nginx)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Otwarcie portu 25 dla serwera pocztowego (Postfix)
iptables -A INPUT -p tcp --dport 25 -j ACCEPT

# Otwarcie portu 21 dla serwera plików (vsftpd)
iptables -A INPUT -p tcp --dport 21 -j ACCEPT

# Otwarcie portu 3306 dla serwera bazy danych (MySQL)
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT

# Otwarcie portu 443 dla serwera WWW HTTPS
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Otwarcie portu 8080 dla phpMyAdmin
# iptables -A INPUT -p tcp --dport 8080 -j ACCEPT

# Zapisanie zmian w konfiguracji iptables
iptables-save > /etc/iptables/rules.v4

# Restart serwisu netfilter-persistent
if rc-service networking restart; then
    echo "Zmiany w konfiguracji iptables zostały zapisane i serwis networking został ponownie uruchomiony."
else
    echo "Błąd podczas restartu serwisu networking. Sprawdź konfigurację iptables."
fi