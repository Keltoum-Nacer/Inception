FROM php:7.4-apache

RUN apt-get update && apt-get install -y \
    libpng-dev libonig-dev libxml2-dev zip unzip \
    && docker-php-ext-install pdo_mysql

WORKDIR /var/www/html

ADD https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php index.php

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 8081
