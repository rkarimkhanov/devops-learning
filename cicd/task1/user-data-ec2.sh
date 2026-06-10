#!/bin/bash
set -euo pipefail
exec > >(tee /var/log/user-data.log) 2>&1

# Update system
dnf update -y

# Install Apache
dnf install -y httpd
systemctl start httpd
systemctl enable httpd

# Install PHP
dnf install -y php php-mysqlnd php-fpm php-json php-gd php-mbstring php-xml

systemctl restart httpd

# Install MariaDB
dnf install -y mariadb105-server
systemctl start mariadb
systemctl enable mariadb

# Configure database
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS wordpress_db;
CREATE USER IF NOT EXISTS 'wp_user'@'localhost' IDENTIFIED BY 'WpPass!2024';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wp_user'@'localhost';
FLUSH PRIVILEGES;
EOF

# Download WordPress
cd /tmp
wget -q https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* /var/www/html/

# Configure WordPress
cd /var/www/html
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/wordpress_db/" wp-config.php
sed -i "s/username_here/wp_user/"           wp-config.php
sed -i "s/password_here/WpPass!2024/"       wp-config.php

# Fix permissions
chown -R apache:apache /var/www/html/
find /var/www/html/ -type d -exec chmod 755 {} \;
find /var/www/html/ -type f -exec chmod 644 {} \;

systemctl restart httpd