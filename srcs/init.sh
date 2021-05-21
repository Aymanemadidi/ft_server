service php7.3-fpm start
service nginx start
service mysql start

# Configure a wordpress database
echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';"| mysql -u root --skip-password

#install wordpress
# cd /tmp/
# wget -c https://wordpress.org/latest.tar.gz
# tar -xvzf latest.tar.gz
# mv wordpress/ /var/www/html
# mv /tmp/wp-config.php /var/www/html

bash
