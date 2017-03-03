FROM richarvey/nginx-php-fpm:latest

MAINTAINER Harmon Wood (-) <oldman@harmonwood.com>

ENV PROJECT_DIR /var/www/html
ENV WEBROOT ${PROJECT_DIR}/web

ADD conf/nginx-symfony.conf /etc/nginx/sites-available/default.conf
ADD conf/nginx-symfony-ssl.conf /etc/nginx/sites-available/default-ssl.conf

WORKDIR $PROJECT_DIR