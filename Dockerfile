FROM php:8.0-fpm

WORKDIR /var/www/html

COPY composer.lock composer.json /var/www/html

# Set working directory
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update -y
RUN apt-get install freetype-dev -y
RUN apt-get install libjpeg-turbo-dev -y
RUN apt-get install libpng-dev -y
RUN apt-get install libzip-dev -y
RUN apt-get install zlib-dev -y
RUN apt-get install ghostscript -y
RUN apt-get install busybox-extras -y
RUN apt-get install nano -y
RUN apt-get install curl -y
RUN apt-get install libxml2 libxslt-dev -y
RUN apt-get install jpeg-dev libpng-dev -y

# COPY ./docker/php/config/php.ini /usr/local/etc/php

RUN docker-php-ext-configure gd --with-jpeg
RUN docker-php-ext-install pdo pdo_mysql gd zip soap

# Install extensions
RUN docker-php-ext-configure gd --with-jpeg
RUN docker-php-ext-install pdo pdo_mysql gd zip soap

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install

RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

COPY . /var/www/html
COPY --chown=www:www . /var/www/html

USER www
EXPOSE 9000
CMD ["php-fpm"]
