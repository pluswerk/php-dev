FROM webdevops/php-apache-dev:7.3

RUN \
    echo "deb http://deb.debian.org/debian stretch universe" >> /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian stretch-updates universe" >> /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian stretch multiverse" >> /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian stretch-updates multiverse" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y sudo less vim nano diffutils tree git-core bash-completion zsh htop && \
    rm -rf /var/lib/apt/lists/* && \
    usermod -aG sudo application && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    update-alternatives --set editor /usr/bin/vim.basic && \
    mkdir /tmp/docker-files

COPY .bashrc-additional.sh /tmp/docker-files/.bashrc-additional.sh
COPY apache.conf /opt/docker/etc/httpd/vhost.common.d/apache.conf

RUN curl -fsSL https://get.docker.com/ | sh

# Configure root
RUN cat /tmp/docker-files/.bashrc-additional.sh >> ~/.bashrc && \
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

COPY .shell-methods .zshrc /root/
COPY cyb.zsh-theme /root/.oh-my-zsh/custom/themes/cyb.zsh-theme
COPY .vimrc /root/.vimrc

# Configure user
USER application
RUN composer global require hirak/prestissimo

RUN cat /tmp/docker-files/.bashrc-additional.sh >> ~/.bashrc && \
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Add folder to fix root permissions
RUN mkdir ~/.ssh

COPY .shell-methods .zshrc /home/application/
COPY cyb.zsh-theme /home/application/.oh-my-zsh/custom/themes/cyb.zsh-theme
COPY .vimrc /home/application/.vimrc

USER root

# Fix application "root" permissions
RUN chown -R application:application /home/application
