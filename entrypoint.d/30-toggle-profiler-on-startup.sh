#!/usr/bin/env bash

if [ -n "${PHP_DEBUGGER:-}" ] && [[ "${PHP_DEBUGGER}" = 'xdebug' ]]; then
  echo 'xdebug-enable:'
  xdebug-enable || true;
else
  echo 'xdebug-disable:'
  xdebug-disable || true;
fi;
