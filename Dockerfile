FROM php:5-apache

RUN apt-get update && apt-get install -y zlib1g-dev && docker-php-ext-install zip

COPY src/ /var/www/html/
COPY config/php.ini /usr/local/etc/php/

ARG MY_ZOTERO_API_KEY
ARG MY_ZOTERO_USER_ID
ARG MY_ZOTERO_USER_NAME
ARG MY_ZOTERO_WEB_PASSWORD

ARG MY_ZOTERO_TIMEZONE=UTC

RUN mkdir -p /var/www/html/data

# Check for mandatory build arguments
RUN ["/bin/bash", "-c", ": ${MY_ZOTERO_API_KEY:?Build argument needs to be set and not null.}"]
RUN ["/bin/bash", "-c", ": ${MY_ZOTERO_USER_ID:?Build argument needs to be set and not null.}"]
RUN ["/bin/bash", "-c", ": ${MY_ZOTERO_USER_NAME:?Build argument needs to be set and not null.}"]
RUN ["/bin/bash", "-c", ": ${MY_ZOTERO_WEB_PASSWORD:?Build argument needs to be set and not null.}"]

RUN sed -i "s/MY_ZOTERO_API_KEY/${MY_ZOTERO_API_KEY}/" /var/www/html/settings.php
RUN sed -i "s/MY_ZOTERO_USER_ID/${MY_ZOTERO_USER_ID}/" /var/www/html/settings.php
RUN sed -i "s/MY_ZOTERO_USER_NAME/${MY_ZOTERO_USER_NAME}/" /var/www/html/settings.php

RUN sed -i "s/MY_ZOTERO_TIMEZONE/${MY_ZOTERO_TIMEZONE}/" /usr/local/etc/php/php.ini


COPY config/default_htaccess /var/www/html/.htaccess
RUN htpasswd -cmb /htpasswd "${MY_ZOTERO_USER_NAME}" "${MY_ZOTERO_WEB_PASSWORD}"
