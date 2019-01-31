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
        docker-compose -f docker-compose.dev.yml up -d
        return
        ;;
     down)
        docker-compose -f docker-compose.dev.yml down --remove-orphans
        return
        ;;
     login)
        docker-compose -f docker-compose.dev.yml exec -u application web bash
        return
        ;;
     *)
        docker-compose -f docker-compose.dev.yml "${@:1}"
        return
        ;;
  esac
}

startFunction "${@:1}"
        exit 0
