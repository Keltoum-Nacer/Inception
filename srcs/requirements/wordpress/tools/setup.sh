#!/bin/bash

set -e  # Exit on any error

mkdir -p /var/www/wordpress
cd /var/www/wordpress

# Install wp-cli if not present
if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# Wait for database to be ready 
echo "Waiting for database at $DB_HOST ..."
until mysqladmin ping -h"$DB_HOST" --silent; do
  echo "Waiting for database connection..."
  sleep 3
done

if [ ! -f wp-config.php ]; then
    # Only download core if not already downloaded
    if [ ! -f wp-load.php ]; then
        wp core download --allow-root
    fi

    # Create wp-config.php with DB credentials
    wp config create --dbname="${DB_NAME}" --dbuser="${DB_USER}" --dbpass="${DB_PASSWORD}" --dbhost="${DB_HOST}" --allow-root
fi


if ! wp core is-installed --allow-root; then
    if [[ "${WP_ADMIN_USER}" =~ [Aa]dmin|[Aa]dministrator ]]; then
        echo "Error: Administrator username cannot contain 'admin', 'Admin', or 'administrator' ..."
        exit 1
    fi

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

wp theme activate twentytwentyfour --allow-root

mkdir -p /run/php
echo "Starting PHP-FPM..."
exec php-fpm7.4 -F