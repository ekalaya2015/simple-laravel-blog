FROM php:8.0-fpm

WORKDIR /var/www/html

COPY composer.lock composer.json /var/www/html

# Set working directory
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update
RUN apt-get install freetype-dev
RUN apt-get install libjpeg-turbo-dev
RUN apt-get install libpng-dev
RUN apt-get install libzip-dev
RUN apt-get install zlib-dev
RUN apt-get install ghostscript
RUN apt-get install busybox-extras
RUN apt-get install nano
RUN apt-get install curl
RUN apt-get install libxml2 libxslt-dev
RUN apt-get install jpeg-dev libpng-dev

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
