<?php
declare(strict_types=1);

namespace Pluswerk;

final class CreateBranches
{
    private $config = [
        'apache' => 'webdevops/php-apache-dev:7.3',
        'apache-7.3' => 'webdevops/php-apache-dev:7.3',
        'apache-7.2' => 'webdevops/php-apache-dev:7.2',
        'apache-7.1' => 'webdevops/php-apache-dev:7.1',
        'apache-7.0' => 'webdevops/php-apache-dev:7.0',
        'apache-5.6' => 'webdevops/php-apache-dev:5.6',

        'nginx' => 'webdevops/php-nginx-dev:7.3',
        'nginx-7.3' => 'webdevops/php-nginx-dev:7.3',
        'nginx-7.2' => 'webdevops/php-nginx-dev:7.2',
        'nginx-7.1' => 'webdevops/php-nginx-dev:7.1',
        'nginx-7.0' => 'webdevops/php-nginx-dev:7.0',
        'nginx-5.6' => 'webdevops/php-nginx-dev:5.6',
    ];

    public function __construct()
    {
        `git checkout master -f && git push`;
        foreach ($this->config as $branch => $FROM) {
            `git checkout master -f && git reset Dockerfile && git checkout Dockerfile && git checkout -B $branch`;
            $lines = file("Dockerfile");
            $lines[0] = "FROM $FROM\n";
            file_put_contents("Dockerfile", $lines);
            `git add Dockerfile && git commit -m 'set image version to $branch with FROM $FROM'`;
        }
        $branches = implode(' ', array_keys($this->config));
        `git push -f --atomic origin $branches`;
        `git checkout master -f`;
    }
}

new CreateBranches();
