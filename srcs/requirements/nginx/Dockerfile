FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/ssl/certs /etc/ssl/private\
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY conf/certs/cert.pem /etc/ssl/certs/
COPY conf/certs/key.pem /etc/ssl/private/
COPY conf/default.conf /etc/nginx/conf.d/default.conf

RUN chmod 600 /etc/ssl/private/key.pem

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;"]


