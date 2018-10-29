FROM php:7.2.10-apache
ARG HTTP_PROXY
RUN echo "Acquire::http::Proxy \"${HTTP_PROXY}\";" >> /etc/apt/apt.conf

# GD: libpng-dev
# RUN apt-get update && apt-get install -y postgresql libpq-dev unzip rsync
RUN apt-get update && apt-get install -y libpq-dev unzip rsync libldap2-dev zlib1g-dev imagemagick libpng-dev
RUN ldconfig && ln -fs /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/
RUN docker-php-ext-install pgsql pdo pdo_pgsql ldap zip exif gd\
    && docker-php-ext-enable pgsql pdo pdo_pgsql ldap zip exif gd

# postgresql-client for pg_dump
RUN mkdir -p /usr/share/man/man1 && mkdir -p /usr/share/man/man7
RUN  apt install -y postgresql-client
# install php composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN rm /etc/apt/apt.conf

COPY apache2-foreground /usr/local/bin/

EXPOSE 80 443
CMD ["apache2-foreground"]
