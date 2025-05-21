<?php

// we do not want the /home/application/.config/composer/vendor/autoload.php
// we want minimal file inclusion.

if (!isset($_COOKIE['XDEBUG_PROFILE']) && !getenv('PROFILING_ENABLED')) {
    return;
}

(function () {
    $composerVendorDir = '/home/application/.composer/vendor';
    if (!is_dir($composerVendorDir)) {
        $composerVendorDir = '/home/application/.config/composer/vendor';
    }
    require_once $composerVendorDir . '/perftools/php-profiler/autoload.php';
    $profiler = new \Xhgui\Profiler\Profiler(
        [
            'save.handler.upload' => [
                'url' => 'http://' . (getenv('XHGUI_MONGO_HOST') ?: 'global-xhgui') . '/run/import',
            ],
        ]
    );
    $profiler->start();
}
)();
