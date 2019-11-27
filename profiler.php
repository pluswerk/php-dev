<?php

$profilerHeader = '/home/application/.composer/vendor/perftools/xhgui-collector/external/header.php';
if ((isset($_COOKIE['XDEBUG_PROFILE']) || getenv('PROFILING_ENABLED')) && file_exists($profilerHeader)) {
    require $profilerHeader;
}
