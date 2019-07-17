#!/usr/bin/env bash

if [[ ! -z  "${PHP_DEBUGGER}" ]] && [[ "${PHP_DEBUGGER}" = 'xdebug' ]]; then
  xdebug-enable;
else
  xdebug-disable;
fi;
