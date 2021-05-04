# Xdebug

You can set the default value for the PHP_DEBUGGER in your `.env` file:
````env
# xdebug 3:
XDEBUG_CLIENT_HOST=10.50.1.223
# xdebug 2:
XDEBUG_REMOTE_HOST=10.50.1.223
````

`XDEBUG_CLIENT_HOST` is the ip-address of your IDE <br />
Information on how to set up xdebug with PHPStorm is here: [Creating a PHP Debug Server](https://www.jetbrains.com/help/phpstorm/creating-a-php-debug-server-configuration.html)

hint: if `PHP_DEBUGGER` is set to `xdebug`, then the xh-profiler won't profile anything 

## enable and disable xdebug in running container:

````bash
# enables xdebug and restarts fpm (hint: this also disables the xh-profiler)
xdebug-enable
# disable xdebug and restarts fpm (hint: this also enables the xh-profiler)
xdebug-disable
# the following alias toggles xdebug and xh-profiler
xdebug-toggle
````

# With xdebug enabled you need to activate xdebug on script run.

## CLI: run any php script with this prefixed:
````
# xdebug 3:
PHP_IDE_CONFIG="serverName=Unnamed" XDEBUG_CONFIG="client_enable=1" php #...
# xdebug 2:
PHP_IDE_CONFIG="serverName=Unnamed" XDEBUG_CONFIG="remote_enable=1" php #...
````

## WEB:

We recommend the usage of an enable-disable tool like [Xdebug helper](https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc)
<br />hint: using the xdebug-helper also works for the xh-profiler, see [PHP Profiling](profiling.md) for more information

### Listening for PHP Debug Sessions:

If you want to use the "Start Listening for PHP Debug Connections" Button in PHPStorm, you can set these ENV variables:
Where Unnamed is the name of the server config in PHPStorm.
````
    - php.xdebug.client_enable=1
    - php.xdebug.client_autostart=1
    - PHP_IDE_CONFIG=serverName=Unnamed
````
