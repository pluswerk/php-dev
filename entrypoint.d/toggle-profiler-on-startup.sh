#!/usr/bin/env sh

if [ "${PHP_DEBUGGER}" = 'xdebug' ]; then
  xdebug-enable;
else
  xdebug-disable;
fi;
