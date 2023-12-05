FROM php:8.1.2-apache

RUN apt-get update && apt-get install -y \
    libonig-dev \
    && docker-php-ext-install mbstring

RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mbstring
RUN a2enmod rewrite


COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www/html
    
COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache


ENV DB_CONNECTION=mysql
ENV DB_HOST=mysql
ENV DB_PORT=3306
ENV DB_DATABASE=scubajobs
ENV DB_USERNAME=adam
ENV DB_PASSWORD=marshall25

ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

EXPOSE 80

CMD ["apache2-foreground"]
