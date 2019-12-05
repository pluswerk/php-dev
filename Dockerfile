ARG FROM=webdevops/php-nginx-dev:7.4
FROM $FROM

ENV XHPROF_VERSION=5.0.1

# Install additional software
RUN apt-get update && \
  apt-get install -y sudo vim nano less tree bash-completion mariadb-client iputils-ping && \
  usermod -aG sudo application && \
  echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  curl -fsSL https://get.docker.com/ | sh && \
  rm -rf /var/lib/apt/lists/*

# Install XHProf
COPY profiler.php /opt/docker/profiler.php

RUN if [ 70000 -le $(php -r "echo PHP_VERSION_ID;") ]; then \
    cd /tmp && \
      wget https://github.com/tideways/php-xhprof-extension/archive/v${XHPROF_VERSION}.zip && \
      unzip v${XHPROF_VERSION}.zip && \
      cd php-xhprof-extension-${XHPROF_VERSION} && \
      phpize && \
      ./configure && \
      make && \
      make install && \
    cd / && \
      rm -rf /tmp/php-xhprof-extension-${XHPROF_VERSION} && \
      echo "extension=tideways_xhprof.so" >> /opt/docker/etc/php/php.ini && \
      echo "auto_prepend_file = /opt/docker/profiler.php" >> /opt/docker/etc/php/php.ini; \
  else echo 'do not install xhprof'; fi;

USER application
RUN composer global require hirak/prestissimo davidrjonas/composer-lock-diff perftools/xhgui-collector alcaeus/mongo-php-adapter && \
    composer clear

# add .git-completion.bash
RUN curl https://raw.githubusercontent.com/git/git/v$(git --version | awk 'NF>1{print $NF}')/contrib/completion/git-completion.bash > /home/application/.git-completion.bash
# add .git-prompt.bash
RUN curl https://raw.githubusercontent.com/git/git/v$(git --version | awk 'NF>1{print $NF}')/contrib/completion/git-prompt.sh > /home/application/.git-prompt.sh

# add .additional_bashrc.sh
COPY bin/* /usr/local/bin/
COPY .additional_bashrc.sh /home/application/.additional_bashrc.sh
COPY .vimrc /home/application/.vimrc
COPY .vimrc /home/root/.vimrc
COPY apache.conf /opt/docker/etc/httpd/vhost.common.d/apache.conf
RUN echo "source ~/.additional_bashrc.sh" >> ~/.bashrc

USER root

ENV \
    POSTFIX_RELAYHOST="[global-mail]:1025" \
    PHP_DISMOD="ioncube" \
    PHP_DISPLAY_ERRORS="1" \
    PHP_MEMORY_LIMIT="-1" \
    XHGUI_MONGO_URI="global-xhgui:27017" \
    XHGUI_PROFILING="enabled"

COPY entrypoint.d/* /entrypoint.d/

# set apache user group to application:
RUN if [ -f /etc/apache2/envvars ]; then sed -i 's/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=application/g' /etc/apache2/envvars ; fi
RUN if [ -f /etc/apache2/envvars ]; then sed -i 's/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=application/g' /etc/apache2/envvars ; fi
# set nginx user group to application:
RUN if [ -f /etc/nginx/nginx.conf ]; then sed -i 's/user www-data;/user application application;/g' /etc/nginx/nginx.conf ; fi

COPY run_tests.sh /tmp/run_tests.sh

WORKDIR /app
