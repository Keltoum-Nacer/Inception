FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php-fpm \
	php-mysql \
	curl \
	wget \
	tar \
	mariadb-client \	
	unzip \
	&& apt-get clean

RUN mkdir -p /var/www/wordpress

COPY tools/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

ENTRYPOINT ["/tmp/setup.sh"]
