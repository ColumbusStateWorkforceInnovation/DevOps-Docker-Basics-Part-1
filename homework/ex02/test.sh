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
cleanup i1
cleanup i2

debug "building images"
docker build --build-arg ORG=CSCC -t image1 . > build.out 2>err.log
docker build --build-arg ORG=cscc -t image2 . > build.out 2>err.log

debug "running containers"
c1=$(docker run --rm -d --name i1 image1)
c2=$(docker run -d --name i2 image2)

cids=$(./run.sh)

numCont=$(echo $cids | wc -w)

[[ $numCont -eq 1 ]] || fail "Expected one container, found: $cids"

[[ "$c2" =~ ^"$cids"* ]] || fail "Wrong contaner ($cids) found.  Expected $c2"

docker stop i2

cids=$(./run.sh)

numCont=$(echo $cids | wc -w)

[[ $numCont -eq 0 ]] || fail "Expected no containers after stopping i2, found: $cids"

cleanup i1
cleanup i2

echo "SUCCESS!!!"

