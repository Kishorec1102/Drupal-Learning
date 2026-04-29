FROM drupal:10-apache

# Install extensions
RUN apt-get update && apt-get install -y \
    git unzip libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libzip-dev zip curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        gd pdo pdo_mysql mysqli zip \
    && a2enmod rewrite

# 🔥 DO NOT change Apache root
# Drupal official image already configured correctly

# Copy theme safely
COPY themes /opt/drupal/web/themes/custom

# Fix permissions
RUN chown -R www-data:www-data /opt/drupal

EXPOSE 80
CMD ["apache2-foreground"]