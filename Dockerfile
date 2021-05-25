FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget

#install nginx
RUN apt-get -y install nginx
#install MYSQL
RUN apt-get -y install mariadb-server
#install PHP
RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

#ARG AUTO

#RUN if [ "$AUTO" = "off" ] ; then  ; else yarn client:build ; fi

COPY ./srcs/nginx.conf /etc/nginx/sites-available/default
# COPY ./srcs/phpinfo.php /var/www/html
COPY ./srcs/wp-config.php ./tmp/wp-config.php

#install phpmyadmin
WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin
COPY ./srcs/config.inc.php phpmyadmin

#install wordpress
# WORKDIR /tmp/
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
# RUN mv wordpress /var/www/html
COPY ./srcs/wp-config.php /var/www/html
COPY ./srcs/auto_off.sh /var/www/html
COPY ./srcs/auto_on.sh /var/www/html
COPY ./srcs/nginx_auto_off.conf /tmp
COPY ./srcs/nginx_auto_on.conf /tmp

# SSL
RUN openssl req -x509 -nodes -days 365 -subj "/C=MA/ST=Morocco/L=Agadir/O=Benguerir/OU=1337/CN=ael-madi" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;
RUN chown -R www-data:www-data *
RUN chmod -R 755 /var/www/*

RUN mv index.nginx-debian.html .index.html

COPY ./srcs/init.sh ./

CMD bash init.sh
