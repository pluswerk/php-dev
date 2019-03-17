# php-dev

PHP-DEV is a small package that includes a web server, PHP and some tools needed to develop a web page.
You can easily decide with a docker-compose.yml which PHP version you want and if you want to start an Apache or a Nginx webserver.
We recommend to use [pluswerk/docker-global](https://github.com/pluswerk/docker-global) as a wrapper for your projects since this Dockerfile has been build by keeping that in mind.

## Docker compose

This is an example of a docker-compose.yml file.
It is enough to put this file into the project, configure it and start the Docker container.
Further information can be found in the [documentation].

Example file: docker-compose.yml

```yaml
version: '3.5'

services:
  web:
    image: pluswerk/php-dev:nginx-7.2

    volumes:
      - .:/app
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ~/.ssh:/home/application/.ssh
      - ~/.composer/cache:/home/application/.composer/cache
      - ~/.gitconfig:/home/application/.gitconfig

    environment:
      # Take a look at VIRTUAL_* in the documentation under Nginx Reverse Proxy
      - VIRTUAL_HOST=~^docker-website-[a-z]+\.vm$$
      #- VIRTUAL_PROTO=https
      #- VIRTUAL_PORT=443

      - WEB_DOCUMENT_ROOT=/app/public
      - XDEBUG_REMOTE_HOST=${XDEBUG_REMOTE_HOST:-}
      - XDEBUG_REMOTE_PORT=${XDEBUG_REMOTE_PORT:-9000}
      - php.xdebug.idekey=${XDEBUG_IDEKEY:-PHPSTORM}
      - php.xdebug.remote_log=${XDEBUG_REMOTE_LOG:-/tmp/xdebug.log}
      - PHP_DEBUGGER=${PHP_DEBUGGER:-none}
      - BLACKFIRE_SERVER_ID=${BLACKFIRE_SERVER_ID:-}
      - BLACKFIRE_SERVER_TOKEN=${BLACKFIRE_SERVER_TOKEN:-}

      # Project Env vars (enable what you need)
#      - APP_ENV=development_docker
#      - PIMCORE_ENVIRONMENT=development_docker
#      - TYPO3_CONTEXT=Development/docker

      # Don't forget to connect via ./start.sh
      - APPLICATION_UID=${APPLICATION_UID:-1000}
      - APPLICATION_GID=${APPLICATION_GID:-1000}
    working_dir: /app

  node:
    image: node:lts
    volumes:
      - ./:/app
    working_dir: /app
    command: tail -f /dev/null

networks:
  default:
    external:
      name: global
```

## Documentation

See the [documentation] for more information.

[documentation]: docs/index.md


## Setup


Create a docker-compose.yml like the one from above.
Change all your settings. Mainly the `VIRTUAL_HOST`, `WEB_DOCUMENT_ROOT` and maybe the Application Context.

Then you can copy the [start.sh](start.sh) into your Project and start it.
