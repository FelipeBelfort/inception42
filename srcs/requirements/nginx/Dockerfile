FROM debian:11

RUN apt-get update && apt-get install -y\
	nginx\
	openssl\
	&& mkdir -p /etc/nginx/ssl

RUN openssl req -nodes -x509 -newkey rsa:4096 -out /etc/nginx/ssl/inception.crt\
	-keyout /etc/nginx/ssl/inception.key\
	-subj "/C=FR/ST=ARA/L=Lyon/O=42/OU=42Lyon/CN=fbelfort.42.fr/emailAddress=fbelfort@student.42lyon.fr"

COPY conf/nginx.conf /etc/nginx/sites-enabled/default

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
