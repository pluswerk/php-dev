source ~/.shell-methods
sshAgentRestart
sshAgentAddKey 7d ~/.ssh/id_rsa
stylePS1
bashCompletion

export PATH=${PATH}:./bin:./vendor/bin:./node_modules/.bin

# Maybe only for root?
#if [[ $EUID -eq 0 ]]; then
    DOCKER_COMPOSE_PROJECT=$(docker inspect ${HOSTNAME} | grep '"com.docker.compose.project":' | awk '{print $2}' | tr --delete '"' | tr --delete ',')
    NODE_CONTAINER=$(docker ps -f "name=${DOCKER_COMPOSE_PROJECT}_node_1" --format {{.Names}})
    alias node='docker exec -w $(pwd) -it ${NODE_CONTAINER} node'
    alias npm='docker exec -w $(pwd) -it ${NODE_CONTAINER} npm'
    alias yarn='docker exec -w $(pwd) -it ${NODE_CONTAINER} yarn'
#fi;

