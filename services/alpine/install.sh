#!/bin/sh

# Repozytoria Community
cat > /etc/apk/repositories << EOF; $(echo)
https://dl-cdn.alpinelinux.org/alpine/v$(cut -d'.' -f1,2 /etc/alpine-release)/main/
https://dl-cdn.alpinelinux.org/alpine/v$(cut -d'.' -f1,2 /etc/alpine-release)/community/
https://dl-cdn.alpinelinux.org/alpine/edge/testing/
EOF

# Aktualizacja systemu
apk update
apk upgrade

# Instalacja i uruchomienie serwera WWW (nginx)
apk add nginx
rc-update add nginx default
service nginx start

# Instalacja i uruchomienie serwera pocztowego (Postfix)
apk add postfix
rc-update add postfix default
service postfix start

# Instalacja i uruchomienie serwera plików (vsftpd)
apk add vsftpd
rc-update add vsftpd default
service vsftpd start

# Instalacja i uruchomienie serwera bazy danych (MariaDB)
apk add mariadb mariadb-client
rc-update add mariadb default
service mariadb start

# jeżeli istnieje mariadb.apk-new: ls /etc/init.d/ | grep mariadb
# mv /etc/init.d/mariadb.apk-new /etc/init.d/mariadb

# Konfiguracja bazy danych MySQL (ustawienie hasła root)
mysql_secure_installation

# Instalacja interfejsu webowego do zarządzania serwisami (phpMyAdmin)
apk add phpmyadmin
service nginx restart  # Restart serwera WWW

# Sprawdzenie, czy pliki są wykonywalne
chmod +x route.sh
chmod +x status.sh

read -p "Czy uruchomić skrypt route.sh? (T/n): " choice
choice=${choice:-Tak}  # domyślna wartość na "Tak"

if [ "$(echo "$choice" | tr '[:upper:]' '[:lower:]')" = "tak" ]; then
    ./route.sh
fi

./status.sh

echo "Skrypt install.sh zakończył działanie."
