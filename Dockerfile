# Use an official PHP runtime as a parent image
FROM php:8.1.2-apache as php

WORKDIR /var/www/html

RUN apt-get update -y
RUN apt-get install -y unzip
RUN apt-get install -y libpq-dev
RUN apt-get install -y libcurl4-gnutls-dev
RUN apt-get install -y default-mysql-client

# Enable Apache modules
RUN a2enmod rewrite

RUN docker-php-ext-install pdo pdo_mysql bcmath

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*
# Update apache conf to point to application public directory
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

COPY . /var/www/html

# Set execution permissions for the entrypoint script
RUN chmod +x docker/entrypoint.sh

COPY --from=composer:2.3.5 /usr/bin/composer /usr/bin/composer

ENV PORT=8080 
# ENTRYPOINT [ "docker/entrypoint.sh" ]