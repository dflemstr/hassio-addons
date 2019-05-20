docker run --rm --privileged \
  -v ~/.docker:/root/.docker \
  -v $PWD:/data \
  homeassistant/amd64-builder \
  --all \
  -t /data
