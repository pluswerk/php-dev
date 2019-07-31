#!/bin/bash

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
        APPLICATION_UID=$(id -u) APPLICATION_GID=$(id -g) docker-compose -f docker-compose.php.yml up -d
        return
        ;;
     test)
        APPLICATION_UID=$(id -u) APPLICATION_GID=$(id -g) docker-compose -f docker-compose.test.yml up --build
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
        APPLICATION_UID=$(id -u) APPLICATION_GID=$(id -g) docker-compose -f docker-compose.php.yml "${@:1}"
        return
        ;;
  esac
}

startFunction "${@:1}"
        exit $?
