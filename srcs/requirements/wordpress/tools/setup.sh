#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

mkdir -p /run/php
cd /var/www/wordpress

if [ ! -f wp-config.php ]; then
    curl -O https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz --strip-components=1
    rm latest.tar.gz

    cp wp-config-sample.php wp-config.php

    sed -i "s/database_name_here/${DB_NAME}/" wp-config.php
    sed -i "s/username_here/${DB_USER}/" wp-config.php
    sed -i "s/password_here/${DB_PASSWORD}/" wp-config.php
    sed -i "s/localhost/${DB_HOST}/" wp-config.php

    sleep 10

    wp core install \
      --url="${DOMAIN_NAME}" \
      --title="Inception" \
      --admin_user="${WP_ADMIN_USER}" \
      --admin_password="${WP_ADMIN_PASSWORD}" \
      --admin_email="${WP_ADMIN_EMAIL}" \
      --skip-email \
      --allow-root

    wp user create \
      "${WP_USER}" "${WP_USER_EMAIL}" \
      --role=editor \
      --user_pass="${WP_USER_PASSWORD}" \
      --allow-root
fi

chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

exec php-fpm7.4 -F

