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

COPY .bashrc-additional /tmp/docker-files/.bashrc-additional
COPY apache.conf /opt/docker/etc/httpd/vhost.common.d/apache.conf

RUN curl -fsSL https://get.docker.com/ | sh && \
  sudo usermod -aG docker application && \
  sudo usermod -aG 999 application

# Configure root
RUN cat /tmp/docker-files/.bashrc-additional >> ~/.bashrc && \
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    ssh-keygen -t rsa -b 4096 -C 'Auto generated, overwrite with volume mount' -f ~/.ssh/id_rsa -P ''

COPY .shell-methods .zshrc /root/
COPY cyb.zsh-theme /root/.oh-my-zsh/custom/themes/cyb.zsh-theme
COPY .vimrc /root/.vimrc

# Configure user
USER application
RUN composer global require hirak/prestissimo

RUN cat /tmp/docker-files/.bashrc-additional >> ~/.bashrc && \
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    ssh-keygen -t rsa -b 4096 -C 'Auto generated, overwrite with volume mount' -f ~/.ssh/id_rsa -P ''

COPY .shell-methods .zshrc /home/application/
COPY cyb.zsh-theme /home/application/.oh-my-zsh/custom/themes/cyb.zsh-theme
COPY .vimrc /home/application/.vimrc

USER root
