export LS_COLORS="${LS_COLORS}di=1;34:"
alias ll='ls -alh'
export PATH=$PATH:~/.config/composer/vendor/bin:~/.composer/vendor/bin:./bin:./vendor/bin:./node_modules/.bin:.

# only enable docker aliases if docker-socket is mounted
CONTAINER_ID=$(basename $(findmnt /etc/hosts -o SOURCE | grep -o 'containers\/.\+\/'))
export HOST_DISPLAY_NAME=$HOSTNAME
if sudo docker ps -q &>/dev/null; then
  DOCKER_COMPOSE_PROJECT=$(sudo docker inspect ${CONTAINER_ID} | jq -r '.[0].Config.Labels."com.docker.compose.project"')
  export NODE_CONTAINER=$(sudo docker ps --format {{.Names}} | grep ^${DOCKER_COMPOSE_PROJECT} | grep node)
  export HOST_DISPLAY_NAME=$(sudo docker inspect ${CONTAINER_ID} --format='{{.Name}}')
  export HOST_DISPLAY_NAME=${HOST_DISPLAY_NAME:1}
fi;

export HISTCONTROL=ignoreboth:erasedups

if [[ $CONTAINER_ID != ${HOSTNAME}* ]] ; then
  export HOST_DISPLAY_NAME=$HOSTNAME
fi

source ~/.bash_git
source ~/.additional_bashrc_ps1.sh

alias xdebug-toggle='test $(php -m | grep xdebug) && xdebug-disable && echo "xdebug disabled" || (xdebug-enable && echo "xdebug enabled")'

# Run SSH Agent and add key 7d
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  if [ -f ~/.ssh/id_rsa ]; then
    ssh-add -t 604800 ~/.ssh/id_rsa
  fi
  if [ -f ~/.ssh/id_ed25519 ]; then
    ssh-add -t 604800 ~/.ssh/id_ed25519
  fi
fi

urls

# makes it possible to add custom prompt functions without changing the entrypoint:
test -f ~/after-bashrc_*.sh && source ~/after-bashrc_*.sh || true
