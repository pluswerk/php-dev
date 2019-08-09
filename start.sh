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
        docker-compose up -d
        return
        ;;
     down)
        docker-compose down --remove-orphans
        return
        ;;
     login)
        docker-compose exec -u $USER web bash
        return
        ;;
     *)
        docker-compose "${@:1}"
        return
        ;;
  esac
}

startFunction "${@:1}"
        exit $?
