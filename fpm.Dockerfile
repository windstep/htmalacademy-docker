FROM php:7.2-fpm
RUN apt-get update \
    && apt-get install -y git unzip curl \
    && pecl install xdebug-2.7.1 \
    && docker-php-ext-enable xdebug \
    && curl -s https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin/ --filename=composer --quiet \
    && docker-php-ext-install pdo pdo_mysql \
    && groupadd -fr -g 1000 app \
    && useradd -rm -g 1000 -u 1000 app

USER app
WORKDIR /app
EXPOSE 9000
COPY --chown=app ./src /app
CMD ["sh ./fpm-start.sh"]
