#!/bin/sh

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

# Konfiguracja bazy danych MySQL (ustawienie hasła root)
mysql_secure_installation

# Instalacja interfejsu webowego do zarządzania serwisami (phpMyAdmin)
apk add phpmyadmin
service nginx restart  # Restart serwera WWW

echo "Skrypt zakończył działanie. Sprawdź konfigurację poszczególnych usług."
