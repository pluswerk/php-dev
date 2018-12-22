# PHP-dev

## Links:

Made to use with [pluswerk/docker-global](https://github.com/pluswerk/docker-global).

## Docker compose

Example File: docker-compose.yaml

```yaml
version: '3.5'

services:
  web:
    restart: always
    #build: php-dev
    image: pluswerk/php-dev:nginx-7.2

    volumes:
      - .:/app
      - ~/.ssh:/home/application/.ssh
      - ~/.composer/cache:/home/application/.composer/cache
      - ~/.gitconfig:/home/application/.gitconfig

    env_file:
      - .env
    environment:
      - VIRTUAL_HOST=~^(.+\.)?docker-website\.vm$$
      - WEB_DOCUMENT_ROOT=/app/public
      - PHP_DISMOD=ioncube
      # @todo - PHP_SENDMAIL_PATH="/home/application/go/bin/mhsendmail --smtp-addr=global-mail:1025"
      - php.display_errors=1

      - php.xdebug.cli_color=1
      - php.xdebug.idekey=PHPSTORM
      - php.xdebug.max_nesting_level=400
      - php.xdebug.remote_enable=On
      - php.xdebug.remote_connect_back=On
      #- php.xdebug.remote_host=192.168.178.123
      - php.xdebug.remote_port=9000
      - php.xdebug.remote_autostart=On
      - php.xdebug.remote_log=/tmp/xdebug.log
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
