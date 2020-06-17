#!/bin/bash

# The current Version of this file can be found HERE:
# https://github.com/pluswerk/php-dev/blob/master/start.sh

[ -f .env ] && . .env

CONTEXT=${CONTEXT:-Development}

USER=${APPLICATION_UID:-1000}:${APPLICATION_GID:-1000}

if [ -z "$SSH_AUTH_SOCK" ]
then
  SSH_AGENT_PART=
else
  SSH_AGENT_PART="-v $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
fi

function startFunction {
  key="$1"
  case ${key} in
     start)
        startFunction pull && \
        startFunction build && \
        startFunction up && \
        startFunction login
        return
        ;;
     up)
        docker-compose --project-directory . -f compose/${CONTEXT}/docker-compose.yml up -d
        return
        ;;
     down)
        docker-compose --project-directory . -f compose/${CONTEXT}/docker-compose.yml down --remove-orphans
        return
        ;;
     login)
        docker-compose --project-directory . -f compose/${CONTEXT}/docker-compose.yml exec -u $USER web bash
        return
        ;;
     login:node)
        docker-compose --project-directory . -f compose/${CONTEXT}/docker-compose.yml exec -u $USER node bash
        return
        ;;
     # this is use full if you ssh into your server and than want to execute something in your php container with ssh access (eg. composer install)
     # example usage: bash start.sh run:ssh -T web composer install --no-dev --ansi --verbose
     run:ssh)
        docker-compose --project-directory . -f compose/${CONTEXT}/docker-compose.yml run -u $USER --rm --entrypoint= $SSH_AGENT_PART ${@:2}
        return
        ;;
     *)
        docker-compose --project-directory . -f compose/${CONTEXT}/docker-compose.yml "${@:1}"
        return
        ;;
  esac
}

startFunction "${@:1}"
        exit $?
