#!/bin/bash

. .env

USER=${APPLICATION_UID:-1000}:${APPLICATION_GID:-1000}

function startFunction {
  key="$1"
  echo "running script ${key}"
  case ${key} in
     start)
        startFunction pull && \
        startFunction build && \
        startFunction up && \
        startFunction login
        return
        ;;
     up)
        docker-compose -f docker-compose.php.yml up -d
        return
        ;;
     test)
        docker-compose -f docker-compose.test.yml up --build
        return
        ;;
     down)
        docker-compose -f docker-compose.php.yml down --remove-orphans
        return
        ;;
     login)
        docker-compose -f docker-compose.php.yml exec -u $(id -u):$(id -g) php-dev bash
        return
        ;;
     *)
        docker-compose -f docker-compose.php.yml "${@:1}"
        return
        ;;
  esac
}

startFunction "${@:1}"
        exit $?
