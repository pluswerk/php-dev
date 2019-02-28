# Xdebug

if you like to use xdebug, you can enable it via the `.env` file:
````env
PHP_DEBUGGER=xdebug
XDEBUG_REMOTE_HOST=10.50.1.223
````
Where `XDEBUG_REMOTE_HOST` is the ip of your IDE.

## CLI: run any php script with this prefixed:
````
XDEBUG_CONFIG="remote_enable=1" php #...
````

## WEB:

We recomand usage of a enable disable tool like [Xdebug helper](https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc.)
