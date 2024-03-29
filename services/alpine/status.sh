#!/bin/sh

# Lista serwisów
services="nginx postfix mariadb vsftpd"

for service_name in $services; do
    status=$(rc-status default | grep "$service_name" | awk '{print $3}')
    echo "service.${service_name} status: ${status}"
done
