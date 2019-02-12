# PHP-dev

## Links:

Made to use with [pluswerk/docker-global](https://github.com/pluswerk/docker-global).

## Docker compose

Example File: docker-compose.yml

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

# Documentation

The base Docker Images are [webdevops/php-apache-dev] and [webdevops/php-nginx-dev] respectivly. ([github])

[webdevops/php-apache-dev]: https://hub.docker.com/r/webdevops/php-apache-dev
[webdevops/php-nginx-dev]: https://hub.docker.com/r/webdevops/php-nginx-dev
[github]: https://github.com/webdevops/Dockerfile

## TYPO3 AdditionalConfiguration.php Example
```php
if ($_SERVER['TYPO3_CONTEXT'] === 'Development/docker') {
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['host'] = getenv('typo3DatabaseHost') ?: 'global-db';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['port'] = getenv('typo3DatabasePort') ?: '3306';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['user'] = getenv('typo3DatabaseUsername') ?: 'root';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['password'] = getenv('typo3DatabasePassword') ?: 'root';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['dbname'] = getenv('typo3DatabaseName') ?: 'default_database';

    
    $GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport'] = 'smtp';
    $GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport_smtp_encrypt'] = '';
    $GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport_smtp_username'] = '';
    $GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport_smtp_password'] = '';
    $GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport_smtp_server'] = getenv('SMTP_MAIL_SERVER') ?: 'global-mail:1025';
        
//    $vmNumber = getenv('VM_NUMBER');
//    if (!\TYPO3\CMS\Core\Utility\MathUtility::canBeInterpretedAsInteger($vmNumber)) {
//        throw new \Exception('env VM_NUMBER needed! it must be an int!');
//    }
//    $domainPrefix = getenv('DOMAIN_PREFIX') ?: '';
//    $GLOBALS['TYPO3_CONF_VARS']['EXTCONF']['xyz_search']['domainA'] = sprintf('%sproject.de.vm%d.iveins.de', $domainPrefix, $vmNumber);
//    $GLOBALS['TYPO3_CONF_VARS']['EXTCONF']['xyz_search']['domainB'] = sprintf('cn.%sproject.de.vm%d.iveins.de', $domainPrefix, $vmNumber);
}
```

## ImageMagick & GraphicMagick included in PHP

If you need ImageMagick or GraphicMagick as a PHP module, you need to install and activate it.
You can create your own Dockerfile and derive from this image.

Both are already preinstalled in the Docker image and it is recommended that you use these binarys instead of the PHP module.

For Example:

```php
<?php exec('/usr/bin/convert ...');
```

### Install ImageMagick or GraphicMagick included in PHP

If you still want to install and activate the PHP module, then create your own Dockerfile.

Install ImageMagick:

```dockerfile
RUN apt install -y imagemagick libmagickwand-dev && printf "\n" | pecl install imagick
```

Install GraphicMagick:

```dockerfile
RUN apt install -y graphicsmagick gcc libgraphicsmagick1-dev && \
    PHP_VERSION=`php -r "echo version_compare(PHP_VERSION, '7.0.0', '<');";` && \
    if [ "${PHP_VERSION}" = "1" ]; then printf "\n" | pecl install gmagick-1.1.7RC3; else printf "\n" | pecl install gmagick-2.0.5RC1; fi;
```

For whatever reason, you can only activate one of them in PHP. If you activate both, PHP will not work properly anymore.
Therefore either use ImageMagick or GraphicMagick:

```dockerfile
# For ImageMagick
RUN echo 'extension=imagick.so' >> /usr/local/etc/php/conf.d/docker-php-ext-magick.ini;

# For GraphicMagick
RUN echo 'extension=gmagick.so' >> /usr/local/etc/php/conf.d/docker-php-ext-magick.ini;
```

## Mail

If you use another mail server you can specify it in docker-compose.yaml file via RelayHost.

```yaml
environment:
  - POSTFIX_RELAYHOST=[global-mail]:1025
```
