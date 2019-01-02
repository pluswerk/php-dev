FROM webdevops/php-apache-dev:7.3

# add sudo; without password
RUN apt-get update && \
  apt-get install -y sudo vim nano tree bash-completion && \
  rm -rf /var/lib/apt/lists/* && \
  usermod -aG sudo application && \
  echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN curl -fsSL https://get.docker.com/ | sh

# Install ImageMagick & GraphicMagick for PHP
RUN apt install -y imagemagick libmagickwand-dev && printf "\n" | pecl install imagick && \
    apt install -y graphicsmagick gcc libgraphicsmagick1-dev && \
    PHP_VERSION=`php -r "echo version_compare(PHP_VERSION, '7.0.0', '<');";` && \
    if [ "${PHP_VERSION}" = "1" ]; then printf "\n" | pecl install gmagick-1.1.7RC3; else printf "\n" | pecl install gmagick-2.0.5RC1; fi;

USER application
RUN composer global require hirak/prestissimo

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
