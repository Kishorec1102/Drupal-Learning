# Use official Drupal image
FROM drupal:10-apache

# Install required extensions
RUN apt-get update && apt-get install -y \
    git unzip libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libzip-dev zip curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        gd \
        pdo \
        pdo_mysql \
        mysqli \
        zip \
    && a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# 🔥 COPY YOUR CUSTOM THEME
COPY themes /var/www/html/themes/custom

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]