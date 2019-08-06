alias ll='ls -alh'
export PATH=$PATH:~/.composer/vendor/bin:./bin:./vendor/bin:./node_modules/.bin
source ~/.git-completion.bash
source ~/.git-prompt.sh

# only enable docker aliases if docker-socket is mounted
if test -f "/var/run/docker.sock"; then
  CONTAINER_ID=$(basename $(cat /proc/1/cpuset))
  DOCKER_COMPOSE_PROJECT=$(sudo docker inspect ${CONTAINER_ID} | grep '"com.docker.compose.project":' | awk '{print $2}' | tr --delete '"' | tr --delete ',')
  export NODE_CONTAINER=$(sudo docker ps -f "name=${DOCKER_COMPOSE_PROJECT}_node_1" --format {{.Names}})
  export HOST_DISPLAY_NAME=$(sudo docker inspect ${CONTAINER_ID} --format='{{.Name}}')
  export HOST_DISPLAY_NAME=${HOST_DISPLAY_NAME:1}
  if [[ $CONTAINER_ID != ${HOSTNAME}* ]] ; then
    export HOST_DISPLAY_NAME=$HOSTNAME
  fi

  alias node='sudo docker exec -u $(id -u):$(id -g) -w $(pwd) -it ${NODE_CONTAINER} node'
  alias npm='sudo docker exec -u $(id -u):$(id -g) -w $(pwd) -it ${NODE_CONTAINER} npm'
  alias npx='sudo docker exec -u $(id -u):$(id -g) -w $(pwd) -it ${NODE_CONTAINER} npx'
  alias yarn='sudo docker exec -u $(id -u):$(id -g) -w $(pwd) -it ${NODE_CONTAINER} yarn'
  alias node_exec='sudo docker exec -u $(id -u):$(id -g) -w $(pwd) -it ${NODE_CONTAINER}'
  alias node_root_exec='sudo docker exec -w $(pwd) -it ${NODE_CONTAINER}'
fi;

PS1='\033]2;'$(pwd)'\007\[\e[0;36m\][\[\e[1;31m\]\u\[\e[0;36m\]@\[\e[1;34m\]$HOST_DISPLAY_NAME\[\e[0;36m\]: \[\e[0m\]\w\[\e[0;36m\]]\[\e[0m\]\$\[\e[1;32m\]\s\[\e[0;33m\]$(__git_ps1)\[\e[0;36m\]> \[\e[0m\]\n$ ';

alias xdt='test $(php -m | grep xdebug) && xdebug-disable && echo "xdebug disabled" || (xdebug-enable && echo "xdebug enabled")'

# Run SSH Agent and add key 7d
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add -t 604800 ~/.ssh/id_rsa
fi
