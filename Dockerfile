FROM php:7.3.0

RUN set -x \
 && apt-get update -y \
 && apt-get install -y  wget apt-transport-https gnupg \
 && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
 && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && apt-get update -y \
 && apt-get install -y git zip nodejs xz-utils libzip-dev libpq-dev libcurl4-gnutls-dev libicu-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev libc-client-dev libkrb5-dev libgconf-2-4 google-chrome-stable yarn nodejs mysql-client \
 && pecl install apcu \
 && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
 && docker-php-ext-install mbstring curl json intl gd xml zip bz2 opcache pdo_mysql pcntl imap exif \
 && docker-php-ext-enable apcu \
 && pecl install xdebug \
 && echo "date.timezone = Europe/Berlin" > /usr/local/etc/php/conf.d/timezone.ini \
 && echo "memory_limit = -1" > /usr/local/etc/php/conf.d/memory.ini  \
 && wget -O /usr/local/bin/composer https://getcomposer.org/download/1.7.2/composer.phar \
 && chmod +x /usr/local/bin/composer \
 && wget https://chromedriver.storage.googleapis.com/2.45/chromedriver_linux64.zip -O /tmp/chromedriver.zip \
 && unzip /tmp/chromedriver.zip -d /usr/local/bin \
 && apt-get autoclean -y \
 && apt-get --purge autoremove -y \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \ 
 && php -i
