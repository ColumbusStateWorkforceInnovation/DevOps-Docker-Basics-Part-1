CONTAINER_NAME=h1ex01
DEBUG=

function debug {
  [[ -n $DEBUG ]] && echo $*
}

function getid {
  echo $(docker ps -aq --filter name=$1 2>>err.log)
}

function fail {
  echo $*
  exit 1
}

function cleanup {
  container=$(getid $1)
  debug "container=$container, arg=$1"
  [[ -n $container ]] && docker rm -f $container 2>>err.log
}

debug "cleaning up"
cleanup $CONTAINER_NAME

debug "running container"
./run.sh

cid=$(getid $CONTAINER_NAME)

[[ -n $cid ]] || fail "Couldn't find container named $CONTAINER_NAME!!!"

port=$(docker inspect -f '{{ index (index (index .NetworkSettings.Ports "80/tcp") 0) "HostPort" }}' $cid)
[[ $port == "9191" ]] || fail "Listening on wrong port: $port"

docker stop $CONTAINER_NAME
[[ -n $(getid $CONTAINER_NAME) ]] && fail "Container $(getid $CONTAINER_NAME) still exists for $CONTAINER_NAME" 
cleanup $CONTAINER_NAME

echo "SUCCESS!!!"
