#!/bin/sh

# Lista serwisów
services=("nginx" "postfix" "mysql" "vsftpd" "mysql" "phpmyadmin")

for service_name in "${services[@]}"; do
    status=$(rc-status default | grep "$service_name" | awk '{print $2}')
    echo "service.${service_name} status: ${status}"
done
