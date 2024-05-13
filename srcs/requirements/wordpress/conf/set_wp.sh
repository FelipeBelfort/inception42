#!/bin/bash

cd /var/www/wordpress

wp config create --path="/var/www/wordpress" --dbname=$WP_DB --dbuser=$DB_USER --dbpass=$DB_USER_PASS --dbprefix=$WP_TABLE_PREFIX --dbhost=$WORDPRESS_DB_HOST --allow-root

wp core install --path="/var/www/wordpress" --url=$DOMAIN --title="$SITE_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

wp user create --path="/var/www/wordpress" $WP_USER $WP_USER_MAIL --user_pass=$WP_USER_PASS --allow-root

wp option update siteurl $DOMAIN --allow-root

chown -R www-data:www-data /var/www/wordpress/wp-content

export WP_CONTAINER_HEALTH_CHECK=ok

/usr/sbin/php-fpm7.4 -F