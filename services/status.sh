#!/bin/bash

# lista serwisów
services=("nginx" "postfix" "mysql" "vsftpd" "mysql" "phpmyadmin")

for service_name in "${services[@]}"; do
    status=$(systemctl is-active "$service_name")
    echo "service.${service_name} status: ${status}"
done