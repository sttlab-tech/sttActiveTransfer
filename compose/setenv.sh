export COMPOSE_PATH_SEPARATOR=:

export COMPOSE_FILE=./docker-compose.yml
export COMPOSE_FILE=$COMPOSE_FILE:./postgres/docker-compose.yml
export COMPOSE_FILE=$COMPOSE_FILE:./activetransfer/docker-compose.yml
export COMPOSE_FILE=$COMPOSE_FILE:./haproxy/docker-compose.yml
#export COMPOSE_FILE=$COMPOSE_FILE:./dbc/docker-compose.yml