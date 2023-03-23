# Set proxy environment variables.
setproxy() {
  export HTTP_PROXY="$MY_HTTP_PROXY"
  export http_proxy="$MY_HTTP_PROXY"
  export HTTPS_PROXY="$MY_HTTP_PROXY"
  export https_proxy="$MY_HTTP_PROXY"
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
