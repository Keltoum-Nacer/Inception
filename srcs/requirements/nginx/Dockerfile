FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl && \
     apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes \
    -days 365 \
    -keyout /etc/nginx/ssl/inc.key \
    -out /etc/nginx/ssl/inc.crt \
    -subj "/CN=${DOMAIN_NAME}"

RUN mkdir -p /var/www/wordpress /var/run/nginx && \
    chmod 755 /var/www/wordpress && \
    chown -R www-data:www-data /var/www/wordpress

COPY conf/default.conf /etc/nginx/conf.d/default.conf


CMD [ "nginx", "-g", "daemon off;"]


