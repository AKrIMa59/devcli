FROM php:7.0-fpm

ARG PROJET_NAME

#Installation des dépendances pour les modules PHP
RUN apt-get update -y && apt-get install -y libpng-dev libicu-dev zlib1g-dev libmcrypt-dev libreadline-dev libedit-dev libxml2-dev libcurl4-openssl-dev pkg-config libssl-dev libmongoc-dev

#Installation des modules PHP
RUN docker-php-ext-install \
    bcmath \
    gd \
    intl \
    json \
    mbstring \
    mcrypt \
    mysqli \
    pdo_mysql \
    opcache \
    readline \
    soap \ 
    xml \
    zip \
    && pecl install mongodb-1.7.5 && docker-php-ext-enable mongodb

#Copie du fichier de config pour changer l'utilisateur utilisé par php-fpm
COPY www.conf /usr/local/etc/php-fpm.d/www.conf

#Changement du working directory
WORKDIR /$PROJET_NAME

RUN apt update -y && apt install -y git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "php-fpm" ]