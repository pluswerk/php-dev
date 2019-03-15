#!/bin/bash

function startFunction {
  key="$1"
  echo "running script ${key}"
  case ${key} in
     start)
        startFunction pull
        startFunction build
        startFunction up
        startFunction login
        return
        ;;
     up)
        APPLICATION_UID=$(id -u) APPLICATION_GID=$(id -g) docker-compose up -d
        return
        ;;
     down)
        docker-compose down --remove-orphans
        return
        ;;
     login)
        docker-compose exec -u $(id -u):$(id -g) web bash
        return
        ;;
     *)
        APPLICATION_UID=$(id -u) APPLICATION_GID=$(id -g) docker-compose "${@:1}"
        return
        ;;
  esac
}

startFunction "${@:1}"
        exit $?
