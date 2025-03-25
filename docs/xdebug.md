# Xdebug

## Setup in PhpStorm

You need to create a PHP->Server Config.  
chose a name you like or fallback to `_`.  
Add the Host `_` it is important that you use this exact Host. only with this Setting it will work in the newest PhpStorm version.
Setup the path mapping like the marked line in the picture: `project files -> /app`.

![PhpStorm Settings Php Servers][xdebug-setup]

Read more: [Creating a PHP Debug Server](https://www.jetbrains.com/help/phpstorm/creating-a-php-debug-server-configuration.html)

## Usage in PhpStorm

You can use the listening Feature in the Top of PhpStorm

![Listen for Debugging Connections][xdebug-listen]

## start xdebug

By default xdebug is disabled in the container.  
You can enable it by running `xdebug-enable` inside the container. (will disable xh-profiler)  
You can disable it by running `xdebug-disable` inside the container. (will enable xh-profiler again)  

it will also restart the `fpm` processes

### Web Debugging

We recommend the usage of an enable-disable tool like [Xdebug helper](https://chromewebstore.google.com/detail/xdebug-helper-by-jetbrain/aoelhdemabeimdhedkidlnbkfhnhgnhm)  
> hint: using the xdebug-helper also works for the xh-profiler, see [PHP Profiling](profiling.md) for more information


### Cli Debugging

````bash
export XDEBUG_CLIENT_HOST=172.23.96.1
export PHP_IDE_CONFIG="serverName=_"
````

`XDEBUG_CLIENT_HOST` is the ip-address of your IDE  
`serverName` is the Host input field in PhpStorm PHP->Server setting

> you can Also put these in the .env of the project. (if corresponding the 2 lines are in the docker-compose.yml)

Than if you run your command that you want to debug you should add `XDEBUG_CONFIG="client_enable=1"` in front of it.
````
XDEBUG_CONFIG="client_enable=1" ...
````

## Problem Solving:

you can enable the xdebug log like this:

````
touch xdebug.log
````

add this to your docker-compose.yml
````
      - php.xdebug.log=/app/xdebug.log
````

[xdebug-setup]: ./images/xdebug-phpstorm-server-config.png
[xdebug-listen]: ./images/xdebug-listen.png
