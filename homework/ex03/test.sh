DEBUG=

function debug {
  [[ -n $DEBUG ]] && echo $*
}

function fail {
  echo $*
  exit 1
}

echo "This could take a couple minutes... please wait..."
docker pull alpine:3.12 >> pull.log
docker pull alpine:latest >> pull.log
docker pull alpine:3 >> pull.log

./run.sh

imageid=$(docker images -q alpine:3.12)

[[ -z "$imageid" ]] || fail "The alpine image 3.12 is still installed in this system"
 
imageid=$(docker images -q alpine:latest)
[[ -n "$imageid" ]] || fail "Expected alpine latest to still be available"

imageid=$(docker images -q alpine:3)
[[ -n "$imageid" ]] || fail "Expected alpine 3 to still be available"

echo "SUCCESS!!!"

