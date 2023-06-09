# Set proxy environment variables.
setproxy() {
  local proxy="${proxy:-$MY_HTTP_PROXY}"
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
  local proxy="${proxy:-$MY_HTTP_PROXY}"
  env HTTP_PROXY="$proxy" \
    http_proxy="$proxy" \
    HTTPS_PROXY="$proxy" \
    https_proxy="$proxy" \
    "$@"
}

__docker-vpare() {
  local _volume _file k t
  while (( $# )); do
    k=
    case $1 in
      -v|--volume)
        _volume="$2"
        shift && (( $# )) && shift
        ;;
      -f|--file)
        _file="$2"
        shift && (( $# )) && shift
        ;;
      *)
        echo "Unknown option $1"
        return 1
        ;;
    esac
  done
  for k (file); do
    if [[ -z "${(P)$(echo "_$k")}" ]]; then
      echo "'-${k:0:1}/--${k}' is required"
      return 1
    fi
  done
  _file=$(realpath "$_file")
  dir=$(dirname "$_file")
  file=$(basename -s .tgz "$_file")
  volume=${_volume:-file}
}

# Backup a volume
docker-vbackup() {
  local volume dir file
  __docker-vpare "$@" || return 1
  docker run --rm \
    -v "$volume:/tmp/volume" \
    -v "$dir:/tmp/backup:Z" \
    alpine \
    sh -c "tar -C '/tmp/volume' -cvf '/tmp/backup/$file.tgz' ."
}

# Restore a volume
docker-vrestore() {
  local volume dir file
  __docker-vpare "$@" || return 1
  docker run --rm \
    -v "$volume:/tmp/volume" \
    -v "$dir:/tmp/backup:Z" \
    alpine \
    sh -c "tar -C '/tmp/volume' -xvf '/tmp/backup/$file.tgz'"
}
