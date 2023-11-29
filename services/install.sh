#!/bin/bash

# Aktualizacja systemu
sudo apt-get update
sudo apt-get upgrade -y

# Instalacja i uruchomienie serwera WWW (nginx)
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Instalacja i uruchomienie serwera pocztowego (Postfix)
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y postfix
sudo systemctl start postfix
sudo systemctl enable postfix

# Instalacja i uruchomienie serwera plików (vsftpd)
sudo apt-get install -y vsftpd
sudo systemctl start vsftpd
sudo systemctl enable vsftpd

# Instalacja i uruchomienie serwera bazy danych (MySQL)
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
sudo systemctl start mysql
sudo systemctl enable mysql

# Instalacja dowolnego interfejsu webowego do zarządzania serwisami (phpMyAdmin)
sudo apt-get install -y phpmyadmin
sudo systemctl restart nginx  # Restart serwera WWW

echo "Skrypt zakończył działanie. Sprawdź konfigurację poszczególnych usług."