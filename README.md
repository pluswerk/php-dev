# php-dev

PHP-DEV is a small package that includes a web server, PHP and some tools needed to develop a web application.
You can easily decide which version of PHP you want to use and whether you want to start an Apache or a Nginx webserver by setting the values in a docker-compose.yml.
We recommend using [pluswerk/docker-global](https://github.com/pluswerk/docker-global) as a wrapper for your projects, since this Dockerfile has been built keeping that in mind.

# Tags

- php versions supported: `8.1`-`8.5`
- php versions unsupported: `5.6`-`8.0`
- webserver supported: `nginx` and `apache`
- alpine images: `-alpine`
- examples
  - `pluswerk/php-dev:nginx-8.5-alpine`
  - `pluswerk/php-dev:apache-8.1-alpine`
  - `pluswerk/php-dev:nginx-8.4`
- list of [all Tags](https://github.com/pluswerk/php-dev/pkgs/container/php-dev/versions?filters%5Bversion_type%5D=tagged)

## Setup

Create a `compose/Development/docker-compose.yml` like shown below.  
Change all your settings. Mainly the `VIRTUAL_HOST`, `WEB_DOCUMENT_ROOT` and optionally the Application Context.
The Environment Variable `CONTEXT` is used to switch between different docker-compose.yml files.

Then you can copy the [start.sh](start.sh) into your project and start it.

# Documentation

The base Docker Images are [webdevops/php-apache-dev] and [webdevops/php-nginx-dev] respectively. ([github])

[webdevops/php-apache-dev]: https://hub.docker.com/r/webdevops/php-apache-dev
[webdevops/php-nginx-dev]: https://hub.docker.com/r/webdevops/php-nginx-dev
[github]: https://github.com/webdevops/Dockerfile

## Features
* [XDebug](docs/xdebug.md) - how to debug your code
* [Environment Variables](docs/env-variables.md) - what can I configure
* [PHP Profiling](docs/profiling.md) - why is my code so slow/memory hungry

## Helpful Information
* [Code Coverage](docs/code-coverage.md) - I want to test my code with code coverage (phpunit, infection)
* [Change docker project name](docs/docker-project-name.md) - all my projects are in folders named the same
* [Nginx Reverse Proxy](docs/nginx-reverse-proxy.md) - VIRTUAL_HOST explanation
* [TYPO3 configuration >=8](docs/typo3-configuration.md) - AdditionalConfiguration.php
* [TYPO3 configuration <=7](docs/typo3-configuration-legacy.md) - AdditionalConfiguration.php
* [ImageMagick or GraphicMagick](docs/magick.md) - using php module

## Docker compose

This is an example of a docker-compose.yml file.
It is enough to put this file into the project, configure it and start the Docker Project.
Further information can be found in the Documentation.

Example file: compose/Development/docker-compose.yml

```yaml
services:
  web:
    image: pluswerk/php-dev:nginx-8.5-alpine

    volumes:
      - .:/app
# the docker socket is optional if no node container is needed
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ~/.ssh:/home/application/.ssh
      - ~/.composer/cache:/home/application/.composer/cache
      - ~/.gitconfig:/home/application/.gitconfig

    environment:
#     Take a look at VIRTUAL_* in the documentation under Nginx Reverse Proxy
      VIRTUAL_HOST: docker-website.${TLD_DOMAIN:?TLD_DOMAIN is required},sub.docker-website.${TLD_DOMAIN:?TLD_DOMAIN is required}
#     HTTPS_METHOD: noredirect

      WEB_DOCUMENT_ROOT: /app/public
      XDEBUG_CLIENT_HOST: ${XDEBUG_CLIENT_HOST:-}
      php.xdebug.idekey: ${XDEBUG_IDEKEY:-PHPSTORM}
      PHP_IDE_CONFIG: ${XDEBUG_IDEKEY:-"serverName=_"}

#      Project Env vars (enable what you need)
#      APP_ENV: development_docker
#      PIMCORE_ENVIRONMENT: development_docker
#      TYPO3_CONTEXT: Development/docker

#      Don't forget to connect via bash start.sh
      APPLICATION_UID: ${APPLICATION_UID:-1000}
      APPLICATION_GID: ${APPLICATION_GID:-1000}

  node:
    image: node:24
    volumes:
      - ./:/app
    working_dir: /app
    environment:
#      Don't forget to connect via bash start.sh
      APPLICATION_UID: ${APPLICATION_UID:-1000}
      APPLICATION_GID: ${APPLICATION_GID:-1000}
    stop_signal: SIGKILL
    entrypoint: bash -c 'groupmod -g $$APPLICATION_GID node; usermod -u $$APPLICATION_UID node; sleep infinity'

networks:
  default:
    name: global
    external: true
```

**Hint for the example above:**
In your own configuration you might want to replace docker-website with your project name, e.g typo3.
TLD_DOMAIN is an environment variable, your nginx container listens on for incoming requests. e.g. example.com.
Your project will then be reachable by going to this domain: typo3.example.com

### Tested with

This project is a basic php-installation and should be able to run most applications.
Nonetheless has this tool successfully been tested/used with:
- TYPO3 >=7
- PIMCore >= 5.4
- Standalone PHP (Symfony, Laravel/Lumen, Vanilla) Projects
- WordPress >= 4.5

If you find any bug, don't hesitate to file an issue and/or pull request.
