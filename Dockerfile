FROM php:8.4-rc-fpm

RUN apt-get update && apt-get install -y \
    unzip \
    zip \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libpq-dev \
    netcat-openbsd \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip

RUN pecl install -f redis || true && docker-php-ext-enable redis

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

#WORKDIR /var/www/html
WORKDIR /home/damoang/staging


RUN if [ -f composer.json ]; then composer install --no-interaction --prefer-dist --optimize-autoloader; fi

# 모든 기본 PHP-FPM 설정 파일 완전 제거
RUN rm -rf /usr/local/etc/php-fpm.d/*

RUN mkdir -p /var/lib/php/sessions && chmod -R 777 /var/lib/php/sessions

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
