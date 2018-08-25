FROM php:5-apache
RUN mkdir -p /cache
RUN mkdir -p /data/zotero
COPY src/ /var/www/html/

VOLUME /data/zotero
ADD settings.php.template /var/www/html/settings.php

