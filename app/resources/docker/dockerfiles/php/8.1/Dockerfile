FROM php:8.1-fpm

ARG PROJET_NAME

RUN apt-get update -y && apt-get install -y libpng-dev libicu-dev zlib1g-dev libmcrypt-dev libreadline-dev libedit-dev libxml2-dev libcurl4-openssl-dev pkg-config libssl-dev libmongoc-dev libgmp-dev

RUN docker-php-ext-install \
    bcmath \
    gmp \
    gd \
    intl \
    opcache \
    mysqli \
    pdo_mysql \
    soap \
    && pecl install mongodb && docker-php-ext-enable mongodb \
    && pear channel-discover pear.phing.info && pear install --alldeps phing/phing

COPY www.conf /usr/local/etc/php-fpm.d/www.conf

RUN apt update -y && apt install -y git

WORKDIR /$PROJET_NAME

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "php-fpm" ]