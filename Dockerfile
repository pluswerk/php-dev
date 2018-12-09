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
    update-alternatives --set editor /usr/bin/vim.basic

RUN curl -fsSL https://get.docker.com/ | sh && \
  sudo usermod -aG docker application && \
  sudo usermod -aG 999 application

# Configure root
RUN echo "source ~/.shell-methods" >> ~/.bashrc && \
    echo "addAlias" >> ~/.bashrc && \
    echo "stylePS1" >> ~/.bashrc && \
    echo "bashCompletion" >> ~/.bashrc && \
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

COPY .shell-methods .zshrc .oh-my-zsh/custom/themes/cyb.zsh-theme /root/
COPY cyb.zsh-theme /root/.oh-my-zsh/custom/themes/cyb.zsh-theme
COPY .vimrc /root/.vimrc

COPY apache.conf /opt/docker/etc/httpd/vhost.common.d/apache.conf

# Configure user
USER application
RUN composer global require hirak/prestissimo

RUN echo "source ~/.shell-methods" >> ~/.bashrc && \
    echo "sshAgentRestart" >> ~/.bashrc && \
    echo "sshAgentAddKey 7d ~/.ssh/id_rsa" >> ~/.bashrc && \
    echo "stylePS1" >> ~/.bashrc && \
    echo "bashCompletion" >> ~/.bashrc && \
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

COPY .shell-methods .zshrc .oh-my-zsh/custom/themes/cyb.zsh-theme /home/application/
COPY cyb.zsh-theme /home/application/.oh-my-zsh/custom/themes/cyb.zsh-theme
COPY .vimrc /home/application/.vimrc

COPY .additional_bashrc.sh /home/application/.additional_bashrc.sh
RUN echo "source ~/.additional_bashrc.sh" >> ~/.bashrc

USER root
