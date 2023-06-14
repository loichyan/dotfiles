function docker_vbackup
    [ -n "$argv" ] && argparse f/file= v/volume= -- $argv || return
    set -l file (realpath $_flag_file)
    set -l dir (dirname $file)
    set -l base (basename $file)
    set -l volume $_flag_volume
    set -l docker (type -q podman && echo podman || echo docker)
    $docker run --rm \
        -v $volume:/tmp/volume:ro \
        -v $dir:/tmp/backup:Z \
        alpine \
        sh -c "tar -C '/tmp/volume' -cvzf '/tmp/backup/$base' ."
end
