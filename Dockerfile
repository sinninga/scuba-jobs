# Use an official PHP runtime as a parent image
FROM php:8.1.2-apache

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Install required dependencies
RUN apt-get update

RUN apt-get install -y \
    libonig-dev
RUN apt-get install -y \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev

RUN a2enmod rewrite


# Install required PHP extensions
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install exif
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install bcmath
# RUN docker-php-ext-install gd
RUN docker-php-ext-install zip
RUN apt-get install -y default-mysql-client


RUN service apache2 restart
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf



# Copy the current directory contents into the container at /var/www/html
COPY . /var/www/html

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# Install Laravel dependencies
RUN composer install --optimize-autoloader --no-dev

# Expose port 80 to the outside world
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
