#!/bin/bash

# Create missing folder for PHP socket (needed even if we switch to port later)
mkdir -p /run/php

cd /var/www/wordpress

# Only download and setup WP if not already configured
if [ ! -f wp-config.php ]; then
    curl -O https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz --strip-components=1
    rm latest.tar.gz  # Fixed typo

    cp wp-config-sample.php wp-config.php

    sed -i "s/database_name_here/$DB_NAME/" wp-config.php
    sed -i "s/username_here/$DB_USER/" wp-config.php
    sed -i "s/password_here/$DB_PASSWORD/" wp-config.php
    sed -i "s/localhost/$DB_HOST/" wp-config.php
fi

# Set correct permissions
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

# Make php-fpm listen on TCP port instead of Unix socket
sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

# Start PHP-FPM in foreground
exec php-fpm7.4 -F

