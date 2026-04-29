FROM drupal:10-apache

# Install extensions
RUN apt-get update && apt-get install -y \
    git unzip libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libzip-dev zip curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        gd pdo pdo_mysql mysqli zip \
    && a2enmod rewrite

# 🔥 IMPORTANT: Change Apache root to /web
RUN sed -i 's|/var/www/html|/var/www/html/web|g' /etc/apache2/sites-available/000-default.conf

# Copy theme
COPY themes /var/www/html/web/themes/custom

# Permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]