#!/usr/bin/env bash

# php should be callable
php -v &&
# php should have specific modules installed
xdebug-enable && php -m | grep xdebug || exit 1 &&
xdebug-disable && php -m | grep -v xdebug || exit 1 &&
[ 70000 -le $(php -r "echo PHP_VERSION_ID;") ] || php -m | grep tideways || exit 1 &&
# sudo should be installed
sudo echo 'done' &&
# nano should be installed
nano -V &&
# vim should be installed
vim --version &&
# less should be installed
less -V &&
# mysql should be installed
mysql -V &&
# mysqldump should be installed
mysqldump -V &&
# tree should be installed
tree --version &&
# ping should be installed
ping -V &&
# docker should be installed
docker --version &&
# composer should be installed
composer --version &&
# timezone should be berlin
cat /etc/timezone &&
test $(cat /etc/timezone) = "Europe/Berlin" || exit 1 &&
test $(php -r 'echo date_default_timezone_get();') = "Europe/Berlin" || exit 1 &&

exit $?
