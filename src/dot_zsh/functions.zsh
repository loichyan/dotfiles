# Set proxy environment variables.
setproxy() {
  local proxy="${1:-$MY_HTTP_PROXY}"
  export HTTP_PROXY="$proxy"
  export http_proxy="$proxy"
  export HTTPS_PROXY="$proxy"
  export https_proxy="$proxy"
}

# Remove proxy environment variables.
noproxy() {
  unset HTTP_PROXY
  unset http_proxy
  unset HTTPS_PROXY
  unset https_proxy
}

# Temporarily set environment variables.
byproxy() {
  env HTTP_PROXY="$MY_HTTP_PROXY" \
    http_proxy="$MY_HTTP_PROXY" \
    HTTPS_PROXY="$MY_HTTP_PROXY" \
    https_proxy="$MY_HTTP_PROXY" \
    "$@"
}

# Backup a volume
docker-vbackup() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "No directroy/volume supplied"
    return 1
  fi
  local dir=$1
  local vname=$2
  docker run --rm \
    -v "$vname:/$vname" \
    -v "$(pwd)/$dir:/__backup:Z" \
    alpine \
    sh -c "tar -C '/$vname' -cvf '/__backup/$vname.tar.gz' ."
}

# Restore a volume
docker-vrestore() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "No directroy/volume supplied"
    return 1
  fi
  local dir=$1
  local vname=$2
  docker run --rm \
    -v "$vname:/$vname" \
    -v "$(pwd)/$dir:/__backup:Z" \
    alpine \
    sh -c "tar -C '/$vname' -xvf '/__backup/$vname.tar.gz'"
}
