FROM debian:11

RUN apt-get update && apt-get install -y\
	wget\
	php7.4-fpm\
	php7.4-mysql

COPY conf/set_wp.sh /tmp

RUN sed -i "/^listen\s=.*/c\listen = 0.0.0.0:9000" /etc/php/7.4/fpm/pool.d/www.conf\
	&& sed -i "/^clear_env\s=.*/c\clear_env = no" /etc/php/7.4/fpm/pool.d/www.conf\
	&& mkdir -p /run/php /var/www/wordpress\
	# && export WP_CONTAINER_HEALTH_CHECK\
	&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar\
	&& chmod +x wp-cli.phar\
	&& chmod 1777 /tmp/set_wp.sh\
	&& mv wp-cli.phar /usr/local/bin/wp\
	&& wp core download --path="/var/www/wordpress" --version=6.5.3 --allow-root

EXPOSE 9000

CMD [ "/bin/bash", "/tmp/set_wp.sh" ]