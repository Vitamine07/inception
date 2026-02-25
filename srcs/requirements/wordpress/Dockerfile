FROM debian:bullseye
RUN apt-get update -y && apt-get install -y php-fpm php-mysql curl
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN rm -f /etc/php/7.4/fpm/pool.d/www.conf
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init.sh
RUN mkdir -p /run/php

WORKDIR /var/www/html
ENTRYPOINT ["/usr/sbin/php-fpm7.4", "--nodaemonize", "--fpm-config", "/etc/php/7.4/fpm/php-fpm.conf"]
ENTRYPOINT ["/usr/local/bin/init.sh"]
