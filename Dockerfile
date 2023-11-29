ARG FROM=webdevops/php-nginx-dev:8.2-alpine
ARG DIST_ADDON=-alpine
FROM $FROM as base-alpine
# Install additional software Alpine:
RUN apk add --no-cache sudo vim nano git-perl less tree bash-completion mariadb-client iputils sshpass gdb tzdata findmnt jq docker-cli file && \
    echo "application ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

FROM $FROM as base
# Install additional software Debian:
RUN apt-get update && \
  apt-get install -y sudo vim nano less tree bash-completion mariadb-client iputils-ping sshpass gdb jq && \
  usermod -aG sudo application && \
  echo "application ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  curl -fsSL https://get.docker.com/ | sh && \
  rm -rf /var/lib/apt/lists/*

FROM base${DIST_ADDON}

COPY entrypoint.d/* /opt/docker/provision/entrypoint.d/
COPY profiler.php /opt/docker/profiler.php
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions @fix_letsencrypt xhprof mongodb pcov && \
    echo "auto_prepend_file=/opt/docker/profiler.php" >> /opt/docker/etc/php/php.ini && \
    echo "pcov.enabled=0" >> /usr/local/etc/php/conf.d/docker-php-ext-pcov.ini && \
    echo "pcov.exclude='~vendor~'" >> /usr/local/etc/php/conf.d/docker-php-ext-pcov.ini && \
    composer self-update --clean-backups && \
    php -r "version_compare(PHP_VERSION, '7.2', '>=') && print_r(exec('composer completion bash > /etc/bash_completion.d/composer'));" && \
    if [ -f /etc/apache2/envvars ]; then \
    sed -i 's/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=application/g' /etc/apache2/envvars && \
    sed -i 's/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=application/g' /etc/apache2/envvars ; \
    fi && \
    if [ -f /etc/nginx/nginx.conf ]; then sed -i 's/user www-data;/user application application;/g' /etc/nginx/nginx.conf ; fi


USER application

COPY bin/* /usr/local/bin/
COPY .additional_bashrc.sh .additional_bashrc_ps1.sh /home/application/
COPY .vimrc /home/application/.vimrc
COPY .vimrc /root/.vimrc
COPY apache.conf /opt/docker/etc/httpd/vhost.common.d/apache.conf

ENV \
    COMPOSER_HOME=/home/application/.composer \
    POSTFIX_RELAYHOST="[global-mail]:1025" \
    PHP_DISMOD="ioncube,tideways" \
    PHP_DISPLAY_ERRORS="1" \
    PHP_MEMORY_LIMIT="-1" \
    XHGUI_MONGO_URI="global-xhgui:27017" \
    XHGUI_PROFILING="enabled" \
    TZ=Europe/Berlin

RUN composer global require davidrjonas/composer-lock-diff perftools/xhgui-collector alcaeus/mongo-php-adapter perftools/php-profiler && \
    composer clear && \
    echo "source ~/.additional_bashrc.sh" >> ~/.bashrc && \
    curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git

USER root

WORKDIR /app
