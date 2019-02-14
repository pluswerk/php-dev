#!/usr/bin/env sh

# Set apache user & group
if [ -f /etc/apache2/envvars ]; then
   sed -i "s/^\(export APACHE_RUN_USER\)=.*/\1=${APPLICATION_USER}/" /etc/apache2/envvars;
   sed -i "s/^\(export APACHE_RUN_GROUP\)=.*/\1=${APPLICATION_GROUP}/" /etc/apache2/envvars;
fi

# Set nginx user
if [ -f /etc/nginx/nginx.conf ]; then
   sed -i "s/^user www-data;/user ${APPLICATION_USER} ${APPLICATION_GROUP};/" /etc/nginx/nginx.conf
fi
