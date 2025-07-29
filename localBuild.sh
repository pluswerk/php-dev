#!/usr/bin/env bash

set -euo pipefail

docker build --build-arg DIST_ADDON=-alpine --build-arg FROM=webdevops/php-nginx-dev:8.4-alpine -t pluswerk/php-dev:local-nginx-8.4-alpine .
docker build --build-arg DIST_ADDON= --build-arg FROM=webdevops/php-nginx-dev:8.4 -t pluswerk/php-dev:local-nginx-8.4 .
docker build --build-arg DIST_ADDON=-alpine --build-arg FROM=webdevops/php-apache-dev:8.4-alpine -t pluswerk/php-dev:local-apache-8.4-alpine .
docker build --build-arg DIST_ADDON= --build-arg FROM=webdevops/php-apache-dev:8.4 -t pluswerk/php-dev:local-apache-8.4 .

docker build --build-arg DIST_ADDON=-alpine --build-arg FROM=webdevops/php-nginx-dev:8.2-alpine -t pluswerk/php-dev:local-nginx-8.2-alpine .
docker build --build-arg DIST_ADDON= --build-arg FROM=webdevops/php-nginx-dev:8.2 -t pluswerk/php-dev:local-nginx-8.2 .
docker build --build-arg DIST_ADDON=-alpine --build-arg FROM=webdevops/php-apache-dev:8.2-alpine -t pluswerk/php-dev:local-apache-8.2-alpine .
docker build --build-arg DIST_ADDON= --build-arg FROM=webdevops/php-apache-dev:8.2 -t pluswerk/php-dev:local-apache-8.2 .
