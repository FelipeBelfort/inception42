FROM debian:11

ARG WP_DB 
ARG DB_USER 
ARG DB_USER_PASS 
ARG DB_ROOT_PASS 

RUN apt-get update && apt-get install -y\
	mariadb-server\
	&& mkdir -p /run/mysqld\
	&& chown -R mysql:mysql /var/lib/mysql /run/mysqld

COPY conf/mariadb.cnf /etc/mysql/conf.d/mariadb.cnf

RUN service mariadb start\
	&& echo "\nY\nY\nroot\nroot\nY\nY\nY\nY\n" | mysql_secure_installation\
	&& mysql -u root -e "CREATE DATABASE IF NOT EXISTS $WP_DB;"\
	&& mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASS';"\
	&& mysql -u root -e "GRANT ALL PRIVILEGES ON $WP_DB.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASS';"\
	&& mysql -u root -e "FLUSH PRIVILEGES;"\
	&& mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';"

EXPOSE 3306

CMD [ "mysqld", "--bind-address=0.0.0.0" ]