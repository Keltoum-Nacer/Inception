FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

COPY tools/setup.sh /tmp/
RUN chmod +x /tmp/setup.sh

ENTRYPOINT ["/tmp/setup.sh"]
