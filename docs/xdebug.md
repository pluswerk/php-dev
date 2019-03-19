# Xdebug

You can set the default value for the PHP_DEBUGGER int your `.env` file:
````env
PHP_DEBUGGER=xdebug
XDEBUG_REMOTE_HOST=10.50.1.223
````
Where `XDEBUG_REMOTE_HOST` is the ip of your IDE.

## enable and disable xdebug in running container:

````bash
# enables xdebug and restarts fpm
xdebug-enable
# disable xdebug and restarts fpm
xdebug-disable
````

# With xdebug enabled you need to activate xdebug on script run.

## CLI: run any php script with this prefixed:
````
XDEBUG_CONFIG="remote_enable=1" php #...
````

## WEB:

We recomand usage of a enable disable tool like [Xdebug helper](https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc.)
