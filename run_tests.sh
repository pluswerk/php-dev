#!/usr/bin/env bash

# php should be callable
php -v &&
# php should have speficic modules installed
php -m | grep xdebug || exit 1 &&
php -m | grep tideways || exit 1 &&
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
composer --version

exit $?
