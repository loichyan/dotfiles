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
