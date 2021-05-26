#!/bin/bash
#Run this script inside the container to switch autoindex to on
cp /tmp/nginx_auto_on.conf /etc/nginx/sites-enabled/default
mv /var/www/html/index.html /var/www/html/.index.html
nginx -s reload

