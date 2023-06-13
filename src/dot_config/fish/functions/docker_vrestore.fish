function docker_vrestore
    [ -n "$argv" ] && argparse f/file= v/volume= -- $argv || return
    set -l file (realpath $_flag_f)
    set -l dir (dirname $file)
    set -l base (basename $file)
    set -l volume $_flag_v
    docker run --rm \
        -v $volume:/tmp/volume:Z \
        -v $dir:/tmp/backup:ro,Z \
        alpine \
        sh -c "tar -C '/tmp/volume' -xvzf '/tmp/backup/$base'"
end
