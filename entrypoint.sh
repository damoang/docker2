#!/bin/bash
set -ex

mkdir -p /var/log/php
touch /var/log/php/php-fpm-error.log
chmod 666 /var/log/php/php-fpm-error.log

mkdir -p /var/lib/php/sessions
chmod 777 /var/lib/php/sessions

exec php-fpm -F

