# PHP-DEV

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
      - VIRTUAL_HOST=~^${DOMAIN_PREFIX:-}docker-website-[a-z]+\.vm$$
      - WEB_DOCUMENT_ROOT=/app/public
      - PHP_DISMOD=${PHP_DISMOD-ioncube}
      - XDEBUG_REMOTE_HOST=${XDEBUG_REMOTE_HOST:-}
      - XDEBUG_REMOTE_PORT=${XDEBUG_REMOTE_PORT:-9000}
      - php.xdebug.idekey=${XDEBUG_IDEKEY:-PHPSTORM}
      - php.xdebug.remote_log=${XDEBUG_REMOTE_LOG:-/logs/xdebug.log}
      - PHP_DEBUGGER=${PHP_DEBUGGER:-none}
      - BLACKFIRE_SERVER_ID=${BLACKFIRE_SERVER_ID:-}
      - BLACKFIRE_SERVER_TOKEN=${BLACKFIRE_SERVER_TOKEN:-}

      # @todo - PHP_SENDMAIL_PATH="/home/application/go/bin/mhsendmail --smtp-addr=global-mail:1025"
      
      # Project Env vars (enable what you need)
#      - APP_ENV=development_docker
#      - PIMCORE_ENVIRONMENT=development_docker
#      - TYPO3_CONTEXT=Development/docker

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
