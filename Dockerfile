ARG FROM=webdevops/php-apache-dev:7.3
FROM $FROM

RUN apt-get update && \
  apt-get install -y sudo vim nano less tree bash-completion mysql-client iputils-ping && \
  usermod -aG sudo application && \
  echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  curl -fsSL https://get.docker.com/ | sh && \
  rm -rf /var/lib/apt/lists/*

USER application
RUN composer global require hirak/prestissimo davidrjonas/composer-lock-diff

# add .git-completion.bash
RUN curl https://raw.githubusercontent.com/git/git/v$(git --version | awk 'NF>1{print $NF}')/contrib/completion/git-completion.bash > /home/application/.git-completion.bash
# add .git-prompt.bash
RUN curl https://raw.githubusercontent.com/git/git/v$(git --version | awk 'NF>1{print $NF}')/contrib/completion/git-prompt.sh > /home/application/.git-prompt.sh

# add .additional_bashrc.sh
COPY .additional_bashrc.sh /home/application/.additional_bashrc.sh
COPY .vimrc /home/application/.vimrc
COPY apache.conf /opt/docker/etc/httpd/vhost.common.d/apache.conf
RUN echo "source ~/.additional_bashrc.sh" >> ~/.bashrc

USER root

ENV \
    POSTFIX_RELAYHOST="[global-mail]:1025" \
    PHP_DISMOD="ioncube" \
    PHP_DISPLAY_ERRORS="1" \
    PHP_MEMORY_LIMIT="-1"

COPY entrypoint.d/* /entrypoint.d/

# set apache user group to application:
RUN if [ -f /etc/apache2/envvars ]; then sed -i 's/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=application/g' /etc/apache2/envvars ; fi
RUN if [ -f /etc/apache2/envvars ]; then sed -i 's/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=application/g' /etc/apache2/envvars ; fi
# set nginx user group to application:
RUN if [ -f /etc/nginx/nginx.conf ]; then sed -i 's/user www-data;/user www-data application;/g' /etc/nginx/nginx.conf ; fi
