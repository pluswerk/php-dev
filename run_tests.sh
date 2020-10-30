#!/usr/bin/env bash

# php should be callable
php -v &&
xdebug-enable &&
# test xdebug is enabled:
test "$(php -m | grep xdebug)" = "xdebug" &&
# test xhprof is disabled:
test "$(php -i | grep auto_prepend_file)" = "auto_prepend_file => no value => no value" &&
xdebug-disable &&
# test xdebug is disabled:
test "$(php -m | grep xdebug)" = "" &&
# test xhprof is enabled:
test "$(php -i | grep auto_prepend_file)" = "auto_prepend_file => /opt/docker/profiler.php => /opt/docker/profiler.php" &&
# test tideways is installed
test "$(php -m | grep tideways)" = "tideways_xhprof" &&
# is hirak/prestissimo installed in composer1
[[ "$(composer1 global show 2>&1 | grep 'hirak/prestissimo')" =~ ^hirak/prestissimo.* ]] &&
# is hirak/prestissimo installed in composer2
[[ "$(composer2 global show 2>&1 | grep 'davidrjonas/composer-lock-diff')" =~ ^davidrjonas/composer-lock-diff.* ]] &&
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
# composer should be installed (version 2)
composer --version &&
# composer1 should be installed
composer1 --version &&
# composer2 should be installed
composer2 --version &&
# timezone should be berlin
cat /etc/timezone &&
test $(cat /etc/timezone) = "Europe/Berlin" &&
test $(php -r 'echo date_default_timezone_get();') = "Europe/Berlin" &&

exit $?
