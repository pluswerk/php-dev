alias ll='ls -alh'
export PATH=$PATH:~/.composer/vendor/bin:./bin:./vendor/bin:./node_modules/.bin
source ~/.shell-methods.sh
source ~/.git-completion.bash
source ~/.git-prompt.sh

DOCKER_COMPOSE_PROJECT=$(sudo docker inspect ${HOSTNAME} | grep '"com.docker.compose.project":' | awk '{print $2}' | tr --delete '"' | tr --delete ',')
NODE_CONTAINER=$(sudo docker ps -f "name=${DOCKER_COMPOSE_PROJECT}_node_1" --format {{.Names}})

stylePS1 "${DOCKER_COMPOSE_PROJECT}"

alias node='sudo docker exec -u $(id -u):$(id -g) -w $(pwd) -it ${NODE_CONTAINER} node'
alias npm='sudo docker exec -u $(id -u):$(id -g) -w $(pwd) -it ${NODE_CONTAINER} npm'
alias yarn='sudo docker exec -u $(id -u):$(id -g) -w $(pwd) -it ${NODE_CONTAINER} yarn'
alias node_exec='sudo docker exec -u $(id -u):$(id -g) -w $(pwd) -it ${NODE_CONTAINER}'
alias node_root_exec='sudo docker exec -w $(pwd) -it ${NODE_CONTAINER}'

PS1='\033]2;'$(pwd)'\007\[\e[0;36m\][\[\e[1;31m\]\u\[\e[0;36m\]@\[\e[1;34m\]$DOCKER_COMPOSE_PROJECT\[\e[0;36m\]: \[\e[0m\]\w\[\e[0;36m\]]\[\e[0m\]\$\[\e[1;32m\]\s\[\e[0;33m\]$(__git_ps1)\[\e[0;36m\]> \[\e[0m\]\n$ ';

# Run SSH Agent and add key 7d
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add -t 604800 ~/.ssh/id_rsa
fi
