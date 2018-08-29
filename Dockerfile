FROM php:5-apache
RUN mkdir -p /cache
RUN mkdir -p /data/zotero

COPY src/ /var/www/html/
COPY config/php.ini /usr/local/etc/php/

ARG MY_ZOTERO_API_KEY
ARG MY_ZOTERO_USER_ID
ARG MY_ZOTERO_USER_NAME

ARG MY_ZOTERO_TIMEZONE=UTC

VOLUME /var/www/html/data/zotero
VOLUME /var/www/html/data/cache

# Check for mandatory build arguments
RUN ["/bin/bash", "-c", ": ${MY_ZOTERO_API_KEY:?Build argument needs to be set and not null.}"]
RUN ["/bin/bash", "-c", ": ${MY_ZOTERO_USER_ID:?Build argument needs to be set and not null.}"]
RUN ["/bin/bash", "-c", ": ${MY_ZOTERO_USER_NAME:?Build argument needs to be set and not null.}"]

RUN sed -i "s/MY_ZOTERO_API_KEY/${MY_ZOTERO_API_KEY}/" /var/www/html/settings.php
RUN sed -i "s/MY_ZOTERO_USER_ID/${MY_ZOTERO_USER_ID}/" /var/www/html/settings.php
RUN sed -i "s/MY_ZOTERO_USER_NAME/${MY_ZOTERO_USER_NAME}/" /var/www/html/settings.php

RUN sed -i "s/MY_ZOTERO_TIMEZONE/${MY_ZOTERO_TIMEZONE}/" /usr/local/etc/php/php.ini


#COPY config/default_htaccess /var/www/html/.htaccess
#RUN htpasswd -f /htpasswd -b "${MY_ZOTERO_WEB_USER}" "${MY_ZOTERO_WEB_PASSWORD}"
