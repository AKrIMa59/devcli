FROM php:7.4-fpm

ARG PROJET_NAME

#Installation des dépendances pour les modules PHP et creation du répertoire pour OCI8
RUN apt-get update -y && apt-get install -y libpng-dev libicu-dev zlib1g-dev libmcrypt-dev libreadline-dev libedit-dev libxml2-dev libcurl4-openssl-dev pkg-config libssl-dev libmongoc-dev libonig-dev libzip-dev unzip libaio1\
    && mkdir /usr/lib/oracle

#Copy de instantclient nécessaire à OCI8
COPY instantclient-basic-linux.x64-12.1.0.2.0.zip /usr/lib/instantclient-basic-linux.x64-12.1.0.2.0.zip
COPY instantclient-sdk-linux.x64-12.1.0.2.0.zip /usr/lib/instantclient-sdk-linux.x64-12.1.0.2.0.zip

#décompression des librairies,ajout de liens symboliques et rechargement de ldconfig
RUN unzip /usr/lib/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /usr/lib/oracle \
    && unzip /usr/lib/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /usr/lib/oracle \
    && rm /usr/lib/instantclient-basic-linux.x64-12.1.0.2.0.zip && rm /usr/lib/instantclient-sdk-linux.x64-12.1.0.2.0.zip \
    && ln -s /usr/lib/oracle/instantclient_12_1/libclntsh.so.12.1 /usr/lib/oracle/instantclient_12_1/libclntsh.so \
    && ln -s /usr/lib/oracle/instantclient_12_1/libclntshcore.so.12.1 /usr/lib/oracle/instantclient_12_1/libclntshcore.so \
    && ln -s /usr/lib/oracle/instantclient_12_1/libocci.so.12.1 /usr/lib/oracle/instantclient_12_1/libocci.so \
    && echo /usr/lib/oracle/instantclient_12_1 > /etc/ld.so.conf.d/oracle-instantclient.conf \
    && ldconfig

#Ajout de la variable d'environnement LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH /usr/lib/oracle/instantclient_12_1

# fin install oci8 et install des autres modules PHP
RUN docker-php-ext-configure oci8 --with-oci8=instantclient,/usr/lib/oracle/instantclient_12_1 \
    && docker-php-ext-install -j$(nproc) oci8 \
    && docker-php-ext-install \
    bcmath \
    gd \
    intl \
    json \
    mbstring \
    mysqli \
    pdo_mysql \
    opcache \
    soap \ 
    xml \
    zip

#Installation de mongodb
RUN pecl install mongodb && docker-php-ext-enable mongodb && pecl install mcrypt-1.0.4 && docker-php-ext-enable mcrypt

#Copy du fichier de config pour changer l'utilisateur utilisé par php-fpm
COPY www.conf /usr/local/etc/php-fpm.d/www.conf

RUN apt update -y && apt install -y git
#Changement du working directory pour le dossier /webdeal où se trouve le projet
WORKDIR /$PROJET_NAME

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "php-fpm" ]