# W przypadku, gdy instalacja phpMyAdmin nie konfiguruje automatycznie serwera WWW
# edycja pliku /etc/nginx/sites-available/default
# umiesc w bloku server:

server {
    listen 80;

    server_name localhost;  # Zmień to na swoją nazwę domeny lub adres IP

    location /phpmyadmin {
        root /usr/share/;
        index index.php index.html index.htm;
        location ~ ^/phpmyadmin/(.+\.php)$ {
            try_files $uri =404;
            root /usr/share/;
            fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;  # Zależy od wersji PHP
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            include fastcgi_params;
        }
        location ~* ^/phpmyadmin/(.+\.(jpg|jpeg|gif|css|png|js|ico|html|xml|txt))$ {
            root /usr/share/;
        }
    }

    location /phpMyAdmin {
        rewrite ^/* /phpmyadmin last;
    }

    # Pozostała konfiguracja serwera...
}

# systemctl restart nginx