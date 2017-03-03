harmonwood/nginx-php-symfony is a Symfony2/3 compatible image
==

php:7.1.2-fpm-alpine `=>` richarvey/nginx-php-fpm `=>` harmonwood/nginx-php-symfony

Production only image app_dev_.php will not execute at this time
--

Example Project Docker file
==

```
FROM harmonwood/nginx-php-symfony:latest

# Delete richarvey's index.php file
RUN rm -f ${PROJECT_DIR}/index.php

# Copy Symfony Project Directory into the directory container directory
COPY . ${PROJECT_DIR}
```

NOTES
--
* ${PROJECT_DIR} = /var/www/html

* Nginx should be looking for the file /var/www/html/web/app.php to map to yoursite.com/

* Composer install runs on startup
