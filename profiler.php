<?php

// we do not want the /home/application/.config/composer/vendor/autoload.php
// we want minimal file inclusion.

if ((isset($_COOKIE['XDEBUG_PROFILE']) || getenv('PROFILING_ENABLED'))) {
    $composerVendorDir = '/home/application/.composer/vendor';
    if (!is_dir($composerVendorDir)) {
        $composerVendorDir = '/home/application/.config/composer/vendor';
    }
    require_once $composerVendorDir . '/perftools/php-profiler/autoload.php';

    $tmpFile = '/tmp/' . uniqid('xhgui', true) . '.data.jsonl';

    $profiler = new \Xhgui\Profiler\Profiler(
        [
            'profiler' => \Xhgui\Profiler\Profiler::PROFILER_XHPROF,
            #  'save.handler' => \Xhgui\Profiler\Profiler::SAVER_MONGODB,

            'save.handler' => \Xhgui\Profiler\Profiler::SAVER_FILE,
            'save.handler.file' => [
                // Appends jsonlines formatted data to this path
                'filename' => $tmpFile,
            ],
        ]
    );
    $profiler->enable();


    register_shutdown_function(static function () use ($composerVendorDir, $tmpFile, $profiler) {
        //we want this autoloading only after the main php script executed everything.
        require_once $composerVendorDir . '/autoload.php';
        $profiler->stop();

        //huge performance Optimisation possible:
        // do not import into mongodb at this point, do it asyncroniasly in the background
        //return;
        $saver = \Xhgui\Profiler\SaverFactory::create(
            \Xhgui\Profiler\Profiler::SAVER_MONGODB,
            new \Xhgui\Profiler\Config(
                [
                    'save.handler.mongodb' => [
                        'dsn' => 'mongodb://' . str_replace('mongodb://', '', getenv('XHGUI_MONGO_URI') ?: 'global-xhgui:27017'),
                        'database' => 'xhprof',
                        // Allows you to pass additional options like replicaSet to MongoClient.
                        // 'username', 'password' and 'db' (where the user is added)
                        'options' => [],
                        // Allows you to pass driver options like ca_file to MongoClient
                        'driverOptions' => [],
                    ],
                ]
            )
        );
        if (!$saver) {
            throw new RuntimeException("Unable to obtain saver");
        }

        $importer = new \Xhgui\Profiler\Importer($saver);
        $fp = fopen($tmpFile, 'r');
        if (!$fp) {
            throw new RuntimeException("Can't open " . $tmpFile);
        }
        $importer->import($fp);
        fclose($fp);
        unlink($tmpFile);
    });
}
