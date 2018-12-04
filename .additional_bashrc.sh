export PATH=$PATH:./bin:./vendor/bin:./node_modules/.bin

DOCKER_COMPOSE_PROJECT=$(docker inspect ${HOSTNAME} | grep '"com.docker.compose.project":' | awk '{print $2}' | tr --delete '"' | tr --delete ',')
NODE_CONTAINER=$(docker ps -f "name=${DOCKER_COMPOSE_PROJECT}_node_1" --format {{.Names}})
alias node='docker exec -w $(pwd) -it ${NODE_CONTAINER} node'
alias npm='docker exec -w $(pwd) -it ${NODE_CONTAINER} npm'
alias yarn='docker exec -w $(pwd) -it ${NODE_CONTAINER} yarn'
